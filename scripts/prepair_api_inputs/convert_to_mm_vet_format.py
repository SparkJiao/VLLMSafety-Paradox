import json
import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input_file", type=str)
    parser.add_argument("--key-words", type=str, default=None)
    args = parser.parse_args()

    data = json.load(open(args.input_file, encoding='utf-8'))

    outputs = {}
    cnt = 0
    for item in data:
        if args.key_words:
            if args.key_words not in item["response"]:
                cnt += 1
                continue
            item["response"] = item["response"].replace(args.key_words, "")
        outputs[item["id"]] = item["response"]
    print(cnt / len(data))

    json.dump(outputs, open(args.input_file.replace(".json", ".format.json"), "w"), ensure_ascii=False, indent=2)


if __name__ == '__main__':
    main()
