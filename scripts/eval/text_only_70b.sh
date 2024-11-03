
model=Meta-Llama-3.1-70B-Instruct
port=8000

for cp in "conf/vllm/fig_step/question_only" "conf/vllm/mm-safety/question_only/rq" "conf/vllm/mm-safety/question_only/rq_sd" \
   "conf/vllm/vl_guard/question_only" "conf/vllm/vl_safe/question_only"; do
#        cn="llama3.1_text_v1_0"
        cn=llama3.1_text_sys_prompt_v1_0
        python service_api_caller_v1.py model=$model port=$port read_tensor.service_based=True read_tensor.service_processor.top_p=1.0 -cp $cp -cn $cn
done



