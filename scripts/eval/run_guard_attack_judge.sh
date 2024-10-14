

#for model in "InternVL2-8B" "llama3-llava-next-8b-hf" "llava-1.5-13b-hf" "llava-1.5-7b-hf" "llava-v1.6-mistral-7b-hf" "Qwen2-VL-7B-Instruct"; do
#  for caption_file in "outputs/$model/fig-step/fig-step.ocr.v1.0.n1.tem0.0.json" \
#    "outputs/$model/vl-guard/vl-guard.ocr.v1.0.n1.tem0.0.json"; do
#    python vllm_inference.py \
#      test_file="$caption_file" \
#      -cp conf/vllm/llama3_guard/ -cn ocr_guard_judge_template_v1_0
#  done
#done

#for model in "InternVL2-8B"; do
for model in "InternVL2-8B" "llama3-llava-next-8b-hf" "llava-1.5-13b-hf" "llava-1.5-7b-hf" "llava-v1.6-mistral-7b-hf" "Qwen2-VL-7B-Instruct"; do
#  for caption_file in "outputs/$model/fig-step/fig-step.ocr.v1.0.n1.tem0.0.json" \
#    "outputs/$model/vl-guard/vl-guard.ocr.v1.0.n1.tem0.0.json"; do
#  caption_file="outputs/$model/mm-safety/mm-safety.ocr.sd_typo.v1.0.n1.tem0.0.json"
#    caption_file="outputs/$model/fig-step/fig-step.attack.full.v1.0.n1.tem0.0.json"
#    caption_file="outputs/$model/mm-safety/mm-safety.attack.sd.rq-sd.v1.0.n1.tem0.0.json"
#    caption_file="outputs/$model/mm-safety/mm-safety.attack.sd-typo.rq.v1.0.n1.tem0.0.json"
#    caption_file="outputs/$model/mm-safety/mm-safety.attack.typo.rq.v1.0.n1.tem0.0.json"
#    caption_file="outputs/$model/vl-guard/vl-guard.attack.full.v1.0.n1.tem0.0.json"
    caption_file="outputs/$model/vl-safe/vl-safe.attack.full.v1.0.n1.tem0.0.json"
    python vllm_inference.py \
      test_file="$caption_file" gpu_memory_utilization=0.6 \
      -cp conf/vllm/vl_safe/attack/ -cn attack_guard_judge_template_v1_0
#  done
done

#mm_safety_file=mm-safety.attack.full.v1.0.n1.tem0.0.json
#for model in "InternVL2-8B" "llama3-llava-next-8b-hf" "llava-1.5-13b-hf" "llava-1.5-7b-hf" "llava-v1.6-mistral-7b-hf" "Qwen2-VL-7B-Instruct"; do
##  for caption_file in "outputs/$model/fig-step/fig-step.ocr.v1.0.n1.tem0.0.json" \
##    "outputs/$model/vl-guard/vl-guard.ocr.v1.0.n1.tem0.0.json"; do
#    caption_file="outputs/$model/mm-safety/mm-safety.ocr.sd_typo.v1.0.n1.tem0.0.json"
#    python vllm_inference.py \
#      test_file="$caption_file" \
#      -cp conf/vllm/mm-safety/attack/sd_rq_sd -cn attack_guard_judge_template_v1_0
##  done
#done
