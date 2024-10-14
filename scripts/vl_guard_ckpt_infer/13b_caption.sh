output_dir=../pretrained-models/llava-1.5-13b-posthoc


cp=conf/vllm/vl_guard/caption/
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/vl-guard.caption.v1.0.n1.tem1.0.json -cp $cp -cn llava_v1.5_13b_caption_v1_0
python vllm_inference.py output_dir=$output_dir output_file=$output_dir/vl-guard.caption.v1.1.n1.tem1.0.json -cp $cp -cn llava_v1.5_13b_caption_v1_1
python vllm_inference.py output_dir=$output_dir output_file=$output_dir/vl-guard.caption.v1.2.n1.tem1.0.json -cp $cp -cn llava_v1.5_13b_caption_v1_2

output_dir=../pretrained-models/llava-1.5-13b-mixed

cp=conf/vllm/vl_guard/caption/
#python vllm_inference.py output_dir=$output_dir output_file=$output_dir/vl-guard.caption.v1.0.n1.tem1.0.json -cp $cp -cn llava_v1.5_13b_caption_v1_0
python vllm_inference.py output_dir=$output_dir output_file=$output_dir/vl-guard.caption.v1.1.n1.tem1.0.json -cp $cp -cn llava_v1.5_13b_caption_v1_1
python vllm_inference.py output_dir=$output_dir output_file=$output_dir/vl-guard.caption.v1.2.n1.tem1.0.json -cp $cp -cn llava_v1.5_13b_caption_v1_2