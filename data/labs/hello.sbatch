#!/bin/sh -l
# hello.sbatch — Lab 2: your first batch job on Anvil
# Submit with:  sbatch hello.sbatch
# then:         squeue -u $USER ; cat slurm-<jobid>.out

#SBATCH -A cis261672-gpu        # MANDATORY on Anvil: workshop GPU allocation (confirm with `mybalance`)
#SBATCH -p gpu-debug             # workshop test queue: 30-min limit, 1 running job per user
#SBATCH --job-name=hello-ai4all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH --gres=gpu:1            # jobs on gpu/gpu-debug must ask for a GPU
#SBATCH -t 00:10:00             # 10 minutes of wall time
#SBATCH -o slurm-%j.out         # standard output file
#SBATCH -e slurm-%j.err         # error output file

module load conda               # Anaconda distribution (provides python3)

cd $SLURM_SUBMIT_DIR            # jobs start in the submit directory by default,
                                # but being explicit never hurts

python3 hello.py
