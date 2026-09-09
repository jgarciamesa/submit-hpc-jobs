#!/bin/sh -l
# array.sbatch — Stretch: a Slurm job array (5 experiments, one submission)
# Submit with:  sbatch --array=0-4 array.sbatch
# Watch with:   squeue -u $USER
# Output lands in: slurm-array_%A_%a.out  (%A = job ID, %a = array task ID)

#SBATCH -A <ACCOUNT>            # MANDATORY on Anvil: allocation account (from `mybalance`)
#SBATCH -p debug
#SBATCH --job-name=ai-sweep
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH -t 00:20:00
#SBATCH -o slurm-array_%A_%a.out   # one output file per array task

module load conda
cd $SLURM_SUBMIT_DIR
python3 train_sweep.py
