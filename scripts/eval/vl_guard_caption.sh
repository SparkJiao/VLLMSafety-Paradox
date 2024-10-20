cp=conf/vllm/vl_guard/caption
for cn in "internvl_8b_system_prompt_caption_v1_0" "llava_v1.5_7b_system_prompt_caption_v1_0" "llava_v1.5_13b_system_prompt_caption_v1_0" \
    "llava_v1.6_mistral_7b_system_prompt_caption_v1_0" "next_llama3_8b_system_prompt_caption_v1_0" "qwen2_vl_system_prompt_caption_v1_0"; do
        python vllm_inference.py -cp $cp -cn $cn
done