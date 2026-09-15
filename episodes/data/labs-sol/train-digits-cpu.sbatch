#!/bin/bash
# train-digits-cpu.sbatch - Lab 3: a CPU-only AI job on Sol
# Runs on the public CPU/GPU partition with public QoS. No --gres line is used
# because this program never touches a GPU.
# Trains a digits classifier with scikit-learn from the scicomp environment.
# Submit with:  sbatch train-digits-cpu.sbatch

#SBATCH -p public
#SBATCH -q public
#SBATCH --job-name=digits-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=16G
#SBATCH -t 00:30:00
#SBATCH -o digits-cpu_%j.out
#SBATCH -e digits-cpu_%j.err
#SBATCH --export=NONE

module purge
module load mamba/latest
source activate scicomp

cd "$SLURM_SUBMIT_DIR"
python3 train_digits.py
