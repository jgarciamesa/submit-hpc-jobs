#!/bin/bash
# train-gpu.sbatch - Lab 4: an AI job on a Sol GPU allocation
# Submit with:  sbatch train-gpu.sbatch
# Uses the public partition with debug QoS for a short GPU smoke test. For a
# longer run, switch to `#SBATCH -q public` and adjust the wall time.

#SBATCH -p public
#SBATCH -q debug
#SBATCH --job-name=digits-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --gres=gpu:1
#SBATCH -t 00:15:00
#SBATCH -o slurm.%j.out
#SBATCH -e slurm.%j.err
#SBATCH --export=NONE

module purge
module load mamba/latest
# ASU keeps public, read-only Python environments under /packages/envs.
# Confirm the current PyTorch environment on Sol with:
#   module load mamba/latest
#   mamba info --envs | grep -i pytorch
source activate pytorch-1.8.2

cd "$SLURM_SUBMIT_DIR"
python3 train_gpu.py
