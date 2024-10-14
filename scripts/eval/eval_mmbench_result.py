import json
import argparse
import re


def parse_option(pred):
    # Extract "A", "B", "C", "D" from the prediction
    pattern = r'[A-D]'
    match = re.search(pattern, pred)
    if match:
        return match.group(0)
    return pred


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input_file", type=str)
    args = parser.parse_args()

    predictions = json.load(open(args.input_file))

    correct = 0
    for item in predictions:
        pred = parse_option(item["response"])
        if pred.strip() == item["answer"].strip():
            correct += 1

    print(f"Accuracy: {correct / len(predictions)}")


if __name__ == "__main__":
    main()
