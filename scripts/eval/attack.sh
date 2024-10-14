


cp=conf/vllm/vl_safe/attack
#    for cn in "llava_v1.5_7b_attack_v1_0" "llava_v1.5_13b_attack_v1_0" "llava_v1.6_mistral_7b_attack_v1_0" "next_llama3_8b_attack_v1_0"; do
#        cn=qwen2_vl_ocr_v1_0
        cn=internvl_8b_attack_v1_0
        python vllm_inference.py gpu_memory_utilization=0.6 -cp $cp -cn $cn
#    done
#done