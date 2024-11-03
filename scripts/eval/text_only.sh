#cp=conf/vllm/fig_step/question_only
#cp=conf/vllm/fig_step/question_w_description
#for cp in "conf/vllm/mm-safety/question_only/rq" "conf/vllm/mm-safety/question_only/rq_sd" "conf/vllm/mm-safety/question_w_description/sd_rq_sd" \
#  "conf/vllm/mm-safety/question_w_description/sd_typo_rq" "conf/vllm/mm-safety/question_w_description/typo_rq"; do \
#for cp in "conf/vllm/vl_guard/question_only" "conf/vllm/vl_guard/question_w_description"; do
#cp=conf/vllm/vl_guard/question_w_description
#python vllm_inference.py -cp $cp -cn qwen2.5_text_v1_0

#for cp in "conf/vllm/vl_guard/question_w_description" "conf/vllm/vl_safe/question_only" "conf/vllm/vl_safe/question_w_description"; do
#cp=conf/vllm/vl_safe/question_w_description
#for cp in "conf/vllm/fig_step/question_only"  "conf/vllm/fig_step/question_w_description"; do
#for cp in "conf/vllm/mm-safety/question_only/rq" "conf/vllm/mm-safety/question_only/rq_sd" "conf/vllm/mm-safety/question_w_description/sd_rq_sd" \
#  "conf/vllm/mm-safety/question_w_description/sd_typo_rq" "conf/vllm/mm-safety/question_w_description/typo_rq" \
#  "conf/vllm/vl_guard/question_only" "conf/vllm/vl_guard/question_w_description" "conf/vllm/vl_safe/question_only" "conf/vllm/vl_safe/question_w_description"; do
#for cn in "llama3.1_text_v1_0" "mistral0.2_text_v1_0" "qwen2.5_text_v1_0"; do
##        cn="qwen2.5_text_v1_0"
#        python vllm_inference.py -cp $cp -cn $cn
#done
#done
# python vllm_inference.py -cp $cp -cn qwen2.5_text_v1_0


#for cp in "conf/vllm/mm-safety/question_w_description/sd_rq_sd" \
#  "conf/vllm/mm-safety/question_w_description/sd_typo_rq" "conf/vllm/mm-safety/question_w_description/typo_rq" \
#  "conf/vllm/vl_guard/question_w_description" "conf/vllm/vl_safe/question_w_description"; do
#cp=conf/vllm/fig_step/question_w_description
#for cn in "llama3.1_text_llava_v1_0" "mistral0.2_text_llava_v1_0" "qwen2.5_text_llava_v1_0"; do
##        cn="qwen2.5_text_v1_0"
#        python vllm_inference.py -cp $cp -cn $cn
#done
#done

for cp in "conf/vllm/fig_step/question_only" "conf/vllm/mm-safety/question_only/rq" "conf/vllm/mm-safety/question_only/rq_sd" \
  "conf/vllm/vl_guard/question_only"; do
    for cn in "llama3.1_text_sys_prompt_v1_0" "mistral0.2_text_sys_prompt_v1_0" "qwen2.5_text_sys_prompt_v1_0"; do
        python vllm_inference.py -cp $cp -cn $cn
    done
done
