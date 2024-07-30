#!/bin/bash
#SBATCH --job-name=superlink
#SBATCH --nodes=1
#SBATCH --ntasks=6  # 1 for superlink, 1 for server, 4 for clients
#SBATCH --time=01:30:00


cd barn/DP-LoRA/Federated_Learning

source $(conda info --base)/etc/profile.d/conda.sh
conda activate DPLoRA

module load gcc/8.4.0/1  cuda/10.2
module load openmpi/4.0.3/1
module load python

# Run flower-superlink
mpirun -np 1 flower-superlink --insecure > superlink.log 2>&1 &

# Run flower-client-app for 4 clients
for i in {0..3}; do
  mpirun -np 1 flower-client-app client:app --insecure > client_$i.log 2>&1 &
done

# Run flower-server-app
mpirun -np 1 flower-server-app server:app --insecure > server.log 2>&1 &

wait