import json
import argparse
import os


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--win-rate-file", type=str)
    parser.add_argument("--llm-prediction", type=str)
    args = parser.parse_args()

    llm_predictions = json.load(open(args.llm_prediction))
    llm_predictions = [item for item in llm_predictions if item["category"] == "safe-image-safe-instruction"]
    print(len(llm_predictions))
    img_id2pred = {"/".join(item["image"].split("/")[-2:]): item for item in llm_predictions}

    win_pairs = json.load(open(args.win_rate_file))

    cnt = 0
    for item in win_pairs:
        if item["choice"] == "m" and img_id2pred[item["image"]]["res"] is False:
            cnt += 1

    print(cnt / len(win_pairs))



if __name__ == '__main__':
    main()