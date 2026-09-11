#!/bin/sh -l
# train-digits-cpu.sbatch — Lab 3: a CPU-only AI job (no GPU requested)
# It runs on the CPU cores of an A100 node, because the workshop allocation
# (cis261672-gpu) only reaches the gpu and gpu-debug partitions.
# Trains a digits classifier (scikit-learn, part of the Anaconda `conda` module).
# Runs in ~1 minute even on 1 core; we request several cores to show resource asks.
# Submit with:  sbatch train-digits-cpu.sbatch

#SBATCH -A cis261672-gpu        # MANDATORY on Anvil: workshop GPU allocation (confirm with `mybalance`)
#SBATCH -p gpu-debug             # workshop test queue: 30-min limit, 1 running job per user
#SBATCH --job-name=digits-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16      # 16 cores: shows how to ask for more than 1
#SBATCH --mem=16G
#SBATCH -t 00:30:00             # 30 minutes wall time
#SBATCH -o digits-cpu_%j.out    # name the output file ourselves

module load conda               # Anaconda distribution (scikit-learn included)

cd $SLURM_SUBMIT_DIR
python3 train_digits.py
