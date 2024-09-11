#for cn in "internvl_8b_caption_v1_0" "llava_v1.5_7b_caption_v1_0" "llava_v1.5_13b_caption_v1_0" "llava_v1.6_mistral_7b_caption_v1_0" "next_llama3_8b_caption_v1_0" "qwen2_vl_caption_v1_0";
#for cn in "llava_v1.5_13b_caption_v1_0" "next_llama3_8b_caption_v1_0" "qwen2_vl_caption_v1_0";
#do
#  python vllm_inference.py -cp conf/vllm/fig_step/caption -cn $cn
#done

#python vllm_inference.py -cp conf/vllm/fig_step/caption -cn llava_v1.5_13b_caption_v1_0


#for cn in "internvl_8b_caption_v1_0" "llava_v1.5_7b_caption_v1_0" "llava_v1.5_13b_caption_v1_0" "llava_v1.6_mistral_7b_caption_v1_0" "next_llama3_8b_caption_v1_0" "qwen2_vl_caption_v1_0";
#do
#  python vllm_inference.py -cp conf/vllm/mm-safety/caption/sd -cn $cn
#done

#python vllm_inference.py -cp conf/vllm/mm-safety/caption/sd -cn llava_v1.5_13b_caption_v1_0

#cp=conf/vllm/mm-safety/caption/sd_typo
#for cp in "conf/vllm/mm-safety/caption/sd_typo" "conf/vllm/mm-safety/caption/typo" "conf/vllm/vl_guard/caption" "conf/vllm/vl_safe/caption";
#do
#  for cn in "internvl_8b_caption_v1_0" "llava_v1.5_7b_caption_v1_0" "llava_v1.5_13b_caption_v1_0" "llava_v1.6_mistral_7b_caption_v1_0" "next_llama3_8b_caption_v1_0" "qwen2_vl_caption_v1_0";
#  do
#    python vllm_inference.py -cp $cp -cn $cn
#  done
#done

#for cp in "conf/vllm/mm-safety/caption/sd_typo" "conf/vllm/mm-safety/caption/typo";
#for cp in "conf/vllm/vl_guard/caption" "conf/vllm/vl_safe/caption/";
#for cp in "conf/vllm/fig_step/caption" ;
#for cp in "conf/vllm/mm-safety/caption/sd" "conf/vllm/mm-safety/caption/sd_typo" "conf/vllm/vl_guard/caption/" "conf/vllm/vl_safe/caption";
#for cp in "conf/vllm/mm-safety/caption/typo" "conf/vllm/mm-safety/caption/sd";
for cp in "conf/vllm/fig_step/attack" "conf/vllm/fig_step/caption";
do
#  cn=internvl_8b_caption_v1_0
#  cn=next_llama3_8b_caption_v1_0
#  cn=llava_v1.5_7b_caption_v1_0
#  cn=llava_v1.6_mistral_7b_caption_v1_0
  cn=qwen2_vl_caption_v1_0
  python vllm_inference.py -cp $cp -cn $cn
done