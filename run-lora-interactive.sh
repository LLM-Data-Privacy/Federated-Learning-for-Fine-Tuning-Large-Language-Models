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
python server.py --num_clients 16 --rank 0 &
server_pid=$!
echo "Server PID: $server_pid"

sleep 10

echo "Starting Client 1"
python lora-client.py --num_clients 16 --rank 1 &
client1_pid=$!
echo "Client 1 PID: $client1_pid"

echo "Starting Client 2"
python lora-client.py --num_clients 16 --rank 2 &
client2_pid=$!
echo "Client 2 PID: $client2_pid"

echo "Starting Client 3"
python lora-client.py --num_clients 16 --rank 3 &
client3_pid=$!
echo "Client 3 PID: $client3_pid"

echo "Starting Clinet 4"
python lora-client.py --num_clients 16 --rank 4 &
client4_pid=$!
echo "Client 4 PID: $client4_pid"

echo "Starting Client 5"
python lora-client.py --num_clients 16 --rank 5 &
client5_pid=$!
echo "Client 5 PID: $client5_pid"

echo "Starting Client 6"
python lora-client.py --num_clients 16 --rank 6 &
client6_pid=$!
echo "Client 6 PID: $client6_pid"

echo "Starting Client 7"
python lora-client.py --num_clients 16 --rank 7 &
client7_pid=$!
echo "Client 7 PID: $client7_pid"

echo "Starting Client 8"
python lora-client.py --num_clients 16 --rank 8 &
client8_pid=$!
echo "Client 8 PID: $client8_pid"

echo "Starting Client 9"
python lora-client.py --num_clients 16 --rank 9 &
client9_pid=$!
echo "Client 9 PID: $client9_pid"

echo "Starting Client 10"
python lora-client.py --num_clients 16 --rank 10 &
client10_pid=$!
echo "Client 10 PID: $client10_pid"

echo "Starting Client 11"
python lora-client.py --num_clients 16 --rank 11 &
client11_pid=$!
echo "Client 11 PID: $client11_pid"

echo "Starting Clinet 12"
python lora-client.py --num_clients 16 --rank 12 &
client12_pid=$!
echo "Client 12 PID: $client12_pid"

echo "Starting Client 13"
python lora-client.py --num_clients 16 --rank 13 &
client13_pid=$!
echo "Client 13 PID: $client13_pid"

echo "Starting Client 14"
python lora-client.py --num_clients 16 --rank 14 &
client14_pid=$!
echo "Client 14 PID: $client14_pid"

echo "Starting Client 15"
python lora-client.py --num_clients 16 --rank 15 &
client15_pid=$!
echo "Client 15 PID: $client15_pid"

echo "Starting Client 16"
python lora-client.py --num_clients 16 --rank 16 &
client16_pid=$!
echo "Client 16 PID: $client16_pid"


# Wait for all processes to complete
wait $server_pid $client1_pid $client2_pid $client3_pid $client4_pid $client5_pid $client6_pid $client7_pid $client8_pid $client9_pid $client10_pid $client11_pid $client12_pid $client13_pid $client14_pid $client15_pid $client16_pid

