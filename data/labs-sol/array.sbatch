#!/bin/bash
# array.sbatch - Scale: a Slurm job array (5 experiments, one submission)
# Submit with:  sbatch --array=0-4 array.sbatch
# Watch with:   squeue -u $USER
# Output lands in: slurm-array_<jobid>_<taskid>.out

#SBATCH -p htc
#SBATCH -q public
#SBATCH --job-name=ai-sweep
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH -t 00:20:00
#SBATCH -o slurm-array_%A_%a.out
#SBATCH -e slurm-array_%A_%a.err
#SBATCH --export=NONE

module purge
module load mamba/latest
source activate scicomp

cd "$SLURM_SUBMIT_DIR"
python3 train_sweep.py
