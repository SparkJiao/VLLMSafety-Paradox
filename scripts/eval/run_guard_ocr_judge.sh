

for model in "InternVL2-8B" "llama3-llava-next-8b-hf" "llava-1.5-13b-hf" "llava-1.5-7b-hf" "llava-v1.6-mistral-7b-hf" "Qwen2-VL-7B-Instruct"; do
  for caption_file in "outputs/$model/fig-step/fig-step.ocr.v1.0.n1.tem0.0.json" \
    "outputs/$model/vl-guard/vl-guard.ocr.v1.0.n1.tem0.0.json"; do
    python vllm_inference.py \
      test_file="$caption_file" \
      -cp conf/vllm/llama3_guard/ -cn ocr_guard_judge_template_v1_0
  done
done
