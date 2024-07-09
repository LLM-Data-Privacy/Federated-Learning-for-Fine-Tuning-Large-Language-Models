#!/bin/bash
#SBATCH --job-name=federated_learning
#SBATCH --nodes=1
#SBATCH --gres=gpu:5
#SBATCH -o output_log/output.log
#SBATCH -e output_log/error.log
#SBATCH -t 2:00:00
#SBATCH --ntasks=4
#SBATCH --chdir=/gpfs/u/home/FNAI/FNAIhrnb/barn/DP-LoRA/Federated_Learning

# Activate the Conda Environment
source $(conda info --base)/etc/profile.d/conda.sh
conda activate DPLoRA

# Setup NO_PROXY to bypass proxy for local communication
export NO_PROXY=127.0.0.1,localhost

# Set the environment variable before running the script
# export TRANSFORMERS_CACHE=/gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface
export HF_DATASETS_CACHE=/gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface
export HF_HOME=/gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface

# Create the cache directory if doesn't exist
mkdir -p /gpfs/u/home/FNAI/FNAIhrnb/scratch/huggingface

echo "Start Simulation"

chmod +x run-lora.sh

srun ./run-lora.sh  
