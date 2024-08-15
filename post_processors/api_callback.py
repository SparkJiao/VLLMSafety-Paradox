import collections
import json
import os
import re
from typing import Dict, Any, List, Tuple, Union, Callable
import numpy as np
import vllm
from omegaconf import ListConfig

from general_util.logger import get_child_logger

logger = get_child_logger(__name__)


class MCQAAnswerClean:
    def __init__(self, prompt: str = "zero-shot"):
        self.prompt = prompt

    def __call__(self, pred: str):
        # print("pred_before: ", pred)
        preds = re.findall(r"A|B|C|D|E", pred)
        if len(preds) == 0:
            return ""

        if self.prompt == "zero-shot":
            return preds[0]
        if self.prompt == "few-shot":
            return preds[-1]
        return preds[0]


class OpenAICallBack:
    def __init__(self, output_file: str, answer_clean: Union[MCQAAnswerClean, str], resume: bool = False, index_field: str = "index",
                 label_field: str = "label", saved_keys: List[str] = None):
        self.predictions = []
        self.output_file = output_file
        self.answer_clean = answer_clean
        self.index_field = index_field
        self.label_field = label_field
        self.saved_keys = saved_keys
        if isinstance(self.saved_keys, ListConfig):
            self.saved_keys = list(self.saved_keys)

        logging_file = output_file.replace(".json", ".jsonl")
        save_dir = os.path.dirname(logging_file)
        if not os.path.exists(save_dir):
            os.makedirs(save_dir, exist_ok=True)

        if os.path.exists(logging_file):
            if resume:
                with open(logging_file, "r") as f:
                    for line in f.readlines():
                        # self.predictions.append(json.loads(line))
                        item = json.loads(line)
                        if isinstance(item["response"], str):
                            if item["response"].strip() == "":
                                continue
                        elif isinstance(item["response"], list):
                            if any([tmp.strip() == "" for tmp in item["response"]]):
                                continue
                        self.predictions.append(item)
                logger.info(f"Load {len(self.predictions)} from {logging_file}")
            self.fw = open(logging_file, "a")
        else:
            self.fw = open(logging_file, "w")

    def __call__(self, meta_data: Dict[str, Any], batch_model_outputs: Dict[str, Any], **kwargs):
        text = meta_data["text"]
        if self.label_field in meta_data:
            label = meta_data[self.label_field]
        else:
            label = -1
        index = meta_data[self.index_field]

        response = batch_model_outputs["response"]
        if isinstance(response, vllm.RequestOutput):
            if response.finished:
                response = [o.text for o in response.outputs]
                if len(response) == 1:
                    response = response[0]
            else:
                response = ""
        if isinstance(response, str):
            pred_clean = self.answer_clean(response)
        elif isinstance(response, list):
            pred_clean = [self.answer_clean(item) for item in response]
        else:
            raise ValueError(f"Unknown type of response: {type(response)}")

        out_item = {
            "text": text,
            "label": label,
            "response": response,
            "pred": pred_clean,
            "id": index,
        }
        if self.saved_keys is not None:
            for key in self.saved_keys:
                out_item[key] = meta_data[key]
        self.predictions.append(out_item)
        self.fw.write(json.dumps(self.predictions[-1]) + "\n")
        self.fw.flush()

    @staticmethod
    def eval_single_item(pred, label):
        if not pred.strip():
            return False
        if len(pred.strip()) > 1:
            return False
        if isinstance(label, str):
            if label.strip() == pred.strip():
                return True
        if isinstance(label, list) and isinstance(label[0], str):
            if label[0].strip() == pred.strip():
                return True
        if label == ord(pred.strip()) - ord("A"):
            return True
        return False

    def get_results(self):
        save_dir = os.path.dirname(self.output_file)
        if not os.path.exists(save_dir):
            os.makedirs(save_dir, exist_ok=True)
        json.dump(self.predictions, open(self.output_file, "w"), indent=2)
        self.fw.close()

        cnt = 0
        outputs = []
        pass_at_k = 0
        for item in self.predictions:
            if isinstance(item["pred"], list):
                preds = item["pred"]
            else:
                preds = [item["pred"]]

            pred = collections.Counter(preds).most_common(1)[0][0]

            mul_pass = 0
            for tmp in preds:
                if self.eval_single_item(tmp, item["label"]):
                    mul_pass = 1
                    break
            pass_at_k += mul_pass

            if not pred.strip():
                outputs.append((item["id"], 0))
                continue
            if len(pred.strip()) > 1:
                outputs.append((item["id"], 0))
                continue
            if isinstance(item["label"], str):
                if item["label"].strip() == pred.strip():
                    cnt += 1
            elif isinstance(item["label"], list) and isinstance(item["label"][0], str):
                if item["label"][0].strip() == pred.strip():
                    cnt += 1
            else:
                if item["label"] == ord(pred.strip()) - ord("A"):
                    cnt += 1
            outputs.append((item["id"], ord(pred.strip()) - ord("A")))
        assert len(outputs) == len(self.predictions)

        # Remove duplicated ids to satisfy the submission requirements of ReClor.
        outputs = sorted(outputs, key=lambda x: x[0])
        id_set = set()
        new_outputs = []
        for item in outputs:
            if item[0] not in id_set:
                new_outputs.append(item[1])
                id_set.add(item[0])
        outputs = new_outputs

        np_output_file = self.output_file.replace(".json", ".npy")
        np.save(np_output_file, np.array(outputs))

        if len(self.predictions) == 0:
            metrics = {"acc": 0, "pass@k": 0, "correct": 0, "total": 0}
        else:
            metrics = {"acc": cnt / len(self.predictions), "pass@k": pass_at_k / len(self.predictions), "correct": cnt, "total": len(self.predictions)}
        json.dump(metrics, open(self.output_file.replace(".json", ".metrics.json"), "w"), indent=2)
        # return {"acc": cnt / len(self.predictions)}, []
        return metrics, []


class SaveOnlyCallBack(OpenAICallBack):
    def __call__(self, meta_data: Dict[str, Any], batch_model_outputs: Dict[str, Any], **kwargs):
        text = meta_data["text"]
        if self.label_field in meta_data:
            label = meta_data[self.label_field]
        else:
            label = -1
        index = meta_data[self.index_field]

        response = batch_model_outputs["response"]
        if isinstance(response, vllm.RequestOutput):
            if response.finished:
                response = [o.text for o in response.outputs]
                if len(response) == 1:
                    response = response[0]
            else:
                response = ""

        out_item = {
            "text": text,
            "label": label,
            "response": response,
            "id": index,
        }
        if self.saved_keys is not None:
            for key in self.saved_keys:
                out_item[key] = meta_data[key]
        self.predictions.append(out_item)
        self.fw.write(json.dumps(self.predictions[-1]) + "\n")
        self.fw.flush()

    def get_results(self):
        save_dir = os.path.dirname(self.output_file)
        if not os.path.exists(save_dir):
            os.makedirs(save_dir, exist_ok=True)
        json.dump(self.predictions, open(self.output_file, "w"), indent=2)
        self.fw.close()
        return {}, []


class SafetyResponseCallback:
    def __init__(self, output_file: str, answer_clean: Callable = None, resume: bool = False, label_field: str = "label",
                 index_field: str = "index", evaluator: Callable = None, saved_keys: List[str] = None):
        self.predictions = []
        self.output_file = output_file
        self.answer_clean = answer_clean
        self.label_field = label_field
        self.index_field = index_field
        self.evaluator = evaluator
        self.saved_keys = saved_keys
        if isinstance(self.saved_keys, ListConfig):
            self.saved_keys = list(self.saved_keys)

        logging_file = output_file.replace(".json", ".jsonl")
        save_dir = os.path.dirname(logging_file)
        if not os.path.exists(save_dir):
            os.makedirs(save_dir, exist_ok=True)

        if os.path.exists(logging_file):
            if resume:
                with open(logging_file, "r", encoding="utf-8") as f:
                    for line in f.readlines():
                        item = json.loads(line)
                        if isinstance(item["response"], str):
                            if item["response"].strip() == "":
                                continue
                        elif isinstance(item["response"], list):
                            if any([tmp.strip() == "" for tmp in item["response"]]):
                                continue
                        self.predictions.append(item)
                logger.info(f"Load {len(self.predictions)} from {logging_file}")
            self.fw = open(logging_file, "a", encoding="utf-8")
        else:
            self.fw = open(logging_file, "w", encoding="utf-8")

    def __call__(self, meta_data: Dict[str, Any], batch_model_outputs: Dict[str, Any], **kwargs):
        text = meta_data["text"]
        if self.label_field in meta_data:
            label = meta_data[self.label_field]
        else:
            label = -1
        index = meta_data[self.index_field]

        response = batch_model_outputs["response"]
        if isinstance(response, vllm.RequestOutput):
            if response.finished:
                response = [o.text for o in response.outputs]
                if len(response) == 1:
                    response = response[0]
            else:
                response = ""

        out_item = {
            "text": text,
            "response": response,
            "id": index,
            "label": label,
        }
        if self.saved_keys is not None:
            for key in self.saved_keys:
                out_item[key] = meta_data[key]
        self.predictions.append(out_item)
        self.fw.write(json.dumps(self.predictions[-1], ensure_ascii=False) + "\n")
        self.fw.flush()

    def get_results(self):
        save_dir = os.path.dirname(self.output_file)
        if not os.path.exists(save_dir):
            os.makedirs(save_dir, exist_ok=True)
        self.fw.close()

        # Remove duplicated ids to satisfy the submission requirements of ReClor.
        outputs = sorted(self.predictions, key=lambda x: x["id"])
        id_set = set()
        new_outputs = []
        for item in outputs:
            if item["id"] not in id_set:
                new_outputs.append(item)
                id_set.add(item["id"])
        self.predictions = new_outputs

        self.predictions, metrics = self.evaluator(self.predictions)
        json.dump(self.predictions, open(self.output_file, "w", encoding="utf-8"), ensure_ascii=False, indent=2)
        json.dump(metrics, open(self.output_file.replace(".json", ".metrics.json"), "w"), indent=2)
        return metrics, []
