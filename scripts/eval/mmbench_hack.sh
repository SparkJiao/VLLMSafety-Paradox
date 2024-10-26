#cp=conf/vllm/mmbench/hack
#cp=conf/vllm/fig_step/hack
#cp=conf/vllm/mm-vet/hack
cp=conf/vllm/mm-vet/vqa
for cn in "llava_v1.5_7b_vqa_v1_0" "llava_v1.6_mistral_7b_vqa_v1_0" "internvl_8b_vqa_v1_0"; do
        python vllm_inference.py -cp $cp -cn $cn
done