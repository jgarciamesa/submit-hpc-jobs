#!/bin/sh -l
# train-gpu.sbatch — Lab 4: an AI job on an Anvil A100 GPU node
# Submit with:  sbatch train-gpu.sbatch
# Two new ideas vs. the CPU lab: --gres (asking for a GPU) and gpu-debug (the
# GPU test partition: 30-minute limit, 2 GPUs max — designed for exactly this).

#SBATCH -A cis261672-gpu        # MANDATORY on Anvil: workshop GPU allocation (confirm with `mybalance`)
#SBATCH -p gpu-debug            # GPU test queue: 30 min, up to 2 GPUs, 1 job
#SBATCH --job-name=digits-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --gres=gpu:1            # <-- ask for ONE GPU (each A100 node has 4, shared)
#SBATCH -t 00:25:00             # fits inside the 30-min gpu-debug limit
#SBATCH -o slurm-%j.out         # standard output file
#SBATCH -e slurm-%j.err         # error output file

module purge
module load conda                # then PyTorch — see instructor-notes.md: verify the
                                 # exact module (e.g. `module spider pytorch`) or use an
                                 # NGC container before the session, then pin it here:
# module load pytorch            # <- confirm exact module name pre-session
# OR container route (reproducible):
# module load singularity
# singularity exec --nv /path/to/pytorch_24.09-py3.sif python3 train_gpu.py

cd $SLURM_SUBMIT_DIR
python3 train_gpu.py
