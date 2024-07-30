#!/bin/bash

module load gcc/8.4.0/1  cuda/10.2
module load openmpi/4.0.3/1
module load python


# Activate the Conda Environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate DPLoRA

# Set the environment variable before running the script
# export TRANSFORMERS_CACHE=/gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface
export HF_DATASETS_CACHE=/gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface
export HF_HOME=/gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface

# Create the cache directory if doesn't exist
mkdir -p /gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface

#Unset Proxy
unset http_proxy
unset https_proxy

#Set NO_PROXY to bypass proxy for local communication
export NO_PROXY=127.0.0.1,localhost
echo "NO_PROXY=$NO_PROXY"

echo "Starting Server"
mpirun -np 1 python server.py --num_clients 4 --rank 0 &
server_pid=$!
echo "Server PID: $server_pid"

sleep 10

for rank in {1..4}; do
  echo "Starting Client $rank"
  mpirun -np 1 python lora-client.py --num_clients 4 --rank $rank &
done

# Wait for all processes to complete
wait $server_pid 