#!/bin/bash
# hello.sbatch - Lab 2: your first batch job on ASU Sol
# Submit with:  sbatch hello.sbatch
# then:         squeue -u $USER ; cat slurm.<jobid>.out

#SBATCH -p public              # Sol public partition: RC-owned CPU/GPU nodes
#SBATCH -q debug               # quick syntax/pre-compute test QoS
#SBATCH --job-name=hello-ai4all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH -t 00:10:00
#SBATCH -o slurm.%j.out
#SBATCH -e slurm.%j.err
#SBATCH --export=NONE          # start from a clean batch environment

module purge
module load mamba/latest       # ASU's supported Python environment manager
source activate scicomp        # public scientific Python environment

cd "$SLURM_SUBMIT_DIR"
python3 hello.py
