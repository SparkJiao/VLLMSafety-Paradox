from transformers import AutoProcessor
import json
import argparse
from qwen_vl_utils import process_vision_info


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--tokenizer_path", "-t", type=str)
    args = parser.parse_args()

    tokenizer = AutoProcessor.from_pretrained(args.tokenizer_path)
    # print(f"BOS Token:")
    # print(tokenizer.bos_token)
    # print(f"EOS Token:")
    # print(tokenizer.eos_token)
    # print(f"PAD Token:")
    # print(tokenizer.pad_token)

    user_img_message = {
        "role": "user",
        "content": [
            {
                "type": "text",
                "text": "This is a user message!"
            },
            {
                "type": "image",
                "image": "https://qianwen-res.oss-cn-beijing.aliyuncs.com/Qwen-VL/assets/demo.jpeg",
            }
        ]
    }
    agent_message = {
        "role": "assistant",
        # "content": {"type": "text", "text": "This is an agent message!"}
        "content": "This is an agent message!"
    }
    system_message = {
        "role": "system",
        "content": "This is a system message!"
    }

    res = tokenizer.apply_chat_template([user_img_message], tokenize=False, add_generation_prompt=True)
    print(res)
    print(json.dumps({"text": res}, indent=2))
    print()

    res = tokenizer.apply_chat_template([user_img_message, agent_message], tokenize=False, add_generation_prompt=True)
    print(res)
    print(json.dumps({"text": res}, indent=2))
    print()

    res = tokenizer.apply_chat_template([system_message, user_img_message, agent_message], tokenize=False, add_generation_prompt=True)
    print(res)
    print(json.dumps({"text": res}, indent=2))


if __name__ == '__main__':
    main()
