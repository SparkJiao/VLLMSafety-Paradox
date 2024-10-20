#for cp in "conf/vllm/fig_step/attack" "conf/vllm/mm-safety/attack/sd_rq_sd" "conf/vllm/mm-safety/attack/sd_typo_rq" "conf/vllm/mm-safety/attack/typo_rq" \
#  "conf/vllm/vl_safe/attack"; do
#    python vllm_inference.py output_dir=../pretrained-models/llava-1.5-7b-posthoc -cp $cp -cn llava_v1.5_7b_attack_v1_0
#done

output_dir=../pretrained-models/llava-1.5-7b-mixed

#cp=conf/vllm/fig_step/attack
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/fig-step.attack.full.v1.0.n1.tem1.0.json -cp $cp -cn llava_v1.5_7b_attack_v1_0
#
#cp=conf/vllm/mm-safety/attack/sd_rq_sd
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety.attack.sd_rq_sd.full.v1.0.n1.tem1.0.json -cp $cp -cn llava_v1.5_7b_attack_v1_0
#
#cp=conf/vllm/mm-safety/attack/sd_typo_rq
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety.attack.sd_typo_rq.full.v1.0.n1.tem1.0.json -cp $cp -cn llava_v1.5_7b_attack_v1_0
#
#cp=conf/vllm/mm-safety/attack/typo_rq
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety.attack.typo_rq.full.v1.0.n1.tem1.0.json -cp $cp -cn llava_v1.5_7b_attack_v1_0
#
#cp=conf/vllm/vl_safe/attack
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/vl-safe.attack.full.v1.0.n1.tem1.0.json -cp $cp -cn llava_v1.5_7b_attack_v1_0

#cp=conf/vllm/vl_guard/llava/
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/vl-guard.attack.full.v1.0.n1.tem1.0.json -cp $cp -cn v1.5_7b_attack_v1_0

#cp=conf/vllm/mmbench/attack
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mmbench/mmbench.attack.full.v1.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_attack_v1_0

#cp=conf/vllm/seed_bench/attack
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/seed-bench/seed-bench.single-image.attack.full.v1.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_attack_v1_0

cp=conf/vllm/mm-safety/attack/rq
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety/mm-safety.attack.text.rq.v1.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_text_attack_v1_0
python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety/mm-safety.attack.text.rq.v2.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_text_attack_v2_0

#python vllm_inference.py -cp $cp -cn llava_v1.5_7b_text_attack_v1_0

cp=conf/vllm/mm-safety/attack/rq_sd
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety/mm-safety.attack.text.rq-sd.v1.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_text_attack_v1_0
python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety/mm-safety.attack.text.rq-sd.v1.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_text_attack_v2_0

#python vllm_inference.py -cp $cp -cn llava_v1.5_7b_text_attack_v1_0

output_dir=../pretrained-models/llava-1.5-7b-posthoc

#cp=conf/vllm/mmbench/attack
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mmbench/mmbench.attack.full.v1.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_attack_v1_0
#cp=conf/vllm/seed_bench/attack
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/seed-bench/seed-bench.single-image.attack.full.v1.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_attack_v1_0

cp=conf/vllm/mm-safety/attack/rq
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety/mm-safety.attack.text.rq.v1.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_text_attack_v1_0
python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety/mm-safety.attack.text.rq.v2.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_text_attack_v2_0

cp=conf/vllm/mm-safety/attack/rq_sd
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety/mm-safety.attack.text.rq-sd.v1.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_text_attack_v1_0
python vllm_inference.py output_dir=$output_dir output_file=$output_dir/mm-safety/mm-safety.attack.text.rq-sd.v2.0.n1.tem0.0.json -cp $cp -cn llava_v1.5_7b_text_attack_v2_0

