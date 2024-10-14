
#for cp in "conf/vllm/vl_guard/ocr" "conf/vllm/fig_step/ocr"; do
##    for cn in "internvl_8b_ocr_v1_0" "next_llama3_8b_ocr_v1_0" "llava_v1.5_7b_ocr_v1_0" "llava_v1.6_mistral_7b_ocr_v1_0" \
##      "qwen2_vl_ocr_v1_0" "llava_v1.5_13b_ocr_v1_0"; do
#        cn=qwen2_vl_ocr_v1_0
#        python vllm_inference.py -cp $cp -cn $cn
##  done
#done


cp=conf/vllm/mm-safety/ocr/sd_typo
    for cn in "internvl_8b_ocr_v1_0" "next_llama3_8b_ocr_v1_0" "llava_v1.5_7b_ocr_v1_0" "llava_v1.6_mistral_7b_ocr_v1_0" \
      "qwen2_vl_ocr_v1_0" "llava_v1.5_13b_ocr_v1_0"; do
#        cn=qwen2_vl_ocr_v1_0
        python vllm_inference.py -cp $cp -cn $cn
    done
#done