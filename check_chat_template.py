from transformers import AutoTokenizer
import json
import argparse


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--tokenizer_path", "-t", type=str)
    args = parser.parse_args()

    tokenizer = AutoTokenizer.from_pretrained(args.tokenizer_path)
    print(f"BOS Token:")
    print(tokenizer.bos_token)
    print(f"EOS Token:")
    print(tokenizer.eos_token)
    print(f"PAD Token:")
    print(tokenizer.pad_token)

    user_message = {
        "role": "user",
        "content": "This is a user message!"
    }
    agent_message = {
        "role": "system",
        "content": "This is an agent message!"
    }
    system_message = {
        "role": "system",
        "content": "This is a system message!"
    }

    res = tokenizer.apply_chat_template([user_message], tokenize=False, add_generation_prompt=True)
    print(res)
    print(json.dumps({"text": res}, indent=2))
    print()

    res = tokenizer.apply_chat_template([user_message, agent_message], tokenize=False, add_generation_prompt=True)
    print(res)
    print(json.dumps({"text": res}, indent=2))
    print()

    res = tokenizer.apply_chat_template([system_message, user_message, agent_message], tokenize=False, add_generation_prompt=True)
    print(res)
    print(json.dumps({"text": res}, indent=2))
    print()


if __name__ == '__main__':
    main()
