#!/bin/sh -l
# array.sbatch — Scale: a Slurm job array (5 experiments, one submission)
# Submit with:  sbatch --array=0-4 array.sbatch
# Watch with:   squeue -u $USER
# Output lands in: slurm-array_%A_%a.out  (%A = job ID, %a = array task ID)

#SBATCH -A cis261672-gpu        # MANDATORY on Anvil: workshop GPU allocation (confirm with `mybalance`)
#SBATCH -p gpu-debug             # 1 running job per user: the 5 array tasks run in turn
#SBATCH --job-name=ai-sweep
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --gres=gpu:1            # jobs on gpu/gpu-debug must ask for a GPU
#SBATCH -t 00:20:00
#SBATCH -o slurm-array_%A_%a.out   # one output file per array task
#SBATCH -e slurm-array_%A_%a.err   # one error file per array task

module load conda
cd $SLURM_SUBMIT_DIR
python3 train_sweep.py
