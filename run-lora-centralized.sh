#!/bin/bash

# Activate the Conda Environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate DPLoRA

# Set the environment variable before running the script
# export TRANSFORMERS_CACHE=/gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface
export HF_DATASETS_CACHE=/gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface
export HF_HOME=/gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface

# Create the cache directory if doesn't exist
mkdir -p /gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface

# Unset Proxy
unset http_proxy
unset https_proxy

# Set NO_PROXY to bypass proxy for local communication
export NO_PROXY=127.0.0.1,localhost
echo "NO_PROXY=$NO_PROXY"

echo "Starting Server"
python server.py --num_clients 1 --rank 0 &
server_pid=$!
echo "Server PID: $server_pid"

sleep 10

echo "Starting Client 1"
python lora-client.py --num_clients 1 --rank 1 &
client1_pid=$!
echo "Client 1 PID: $client1_pid"

# Wait for all processes to complete
wait $server_pid $client1_pid

