#!/bin/bash
dir=$PWD
month_day=$(date +"%b_%d")
time=$(date +%s)
echo "run job "$time
mkdir -p cl_job_output/${month_day}
touch ./cl_job_output/${month_day}/log_${time}.out
cd /local/scratch-3/yz709/DART

python3 cli.py \
    --data_dir data/k-shot/SST-2/16-13 \
    --model_type roberta \
    --model_name_or_path roberta-base \
    --cache_dir pretrain/roberta-base \
    --task_name sst-2 \
    --output_dir output/sst-2-inner \
    --do_eval \
    --do_train \
    --pet_per_gpu_eval_batch_size 8 \
    --pet_per_gpu_train_batch_size 16 \
    --pet_gradient_accumulation_steps 1 \
    --pet_max_seq_length 128 \
    --pet_max_steps 250 \
    --pattern_ids 2 \
    --learning_rate 1e-4 \
    --eval_set "test" \
    --prompt_encoder_type "inner" \
    1> ${dir}/cl_job_output/${month_day}/log_${time}.out 2>&1