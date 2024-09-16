
#caption_file="/export/home2/fangkai/mm-safety-explore/outputs/InternVL2-8B/fig-step/fig-step.caption.full.v1.0.n1.tem0.0.json"
#
#python vllm_inference.py \
#  test_file="$caption_file" \
#  -cp conf/vllm/llama3_guard/ -cn caption_guard_judge_template_v1_0

for model in "InternVL2-8B" "llama3-llava-next-8b-hf" "llava-1.5-13b-hf" "llava-1.5-7b-hf" "llava-v1.6-mistral-7b-hf" "Qwen2-VL-7B-Instruct"; do
#  for caption_file in "outputs/$model/fig-step/fig-step.caption.full.v1.0.n1.tem0.0.json" \
  for caption_file in "outputs/$model/fig-step/fig-step.caption.v1.0.n1.tem0.0.json" \
    "outputs/$model/mm-safety/mm-safety.caption.sd.v1.0.n1.tem0.0.json" \
    "outputs/$model/mm-safety/mm-safety.caption.sd_typo.v1.0.n1.tem0.0.json" \
    "outputs/$model/mm-safety/mm-safety.caption.typo.v1.0.n1.tem0.0.json" \
    "outputs/$model/vl-guard/vl-guard.caption.v1.0.n1.tem0.0.json" \
    "outputs/$model/vl-safe/vl-safe.caption.v1.0.n1.tem0.0.json"; do
#  "outputs/$model/vl-safe/vl-safe.caption.v1.0.n1.tem0.0.json"; do
    python vllm_inference.py \
      test_file="$caption_file" \
      -cp conf/vllm/llama3_guard/ -cn caption_guard_judge_template_v1_0
  done
done
