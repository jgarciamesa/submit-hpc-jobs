---
title: "An AI Job on an A100 GPU"
teaching: 10 # teaching time in minutes
exercises: 15 # exercise time in minutes
questions:
- How do you ask a Slurm job for a GPU?
- How can you tell your job actually ran on a GPU and not a CPU?
objectives:
- Request a GPU with `--gres` and submit a PyTorch job to the `gpu-debug` partition.
- Confirm GPU use from the job's `nvidia-smi` output.
---

# Ask for a GPU

So far every job has run on CPU nodes. To run on a GPU you do two new things in
the script: name a GPU partition and request a GPU with `--gres`.

Here is the new script, `train-gpu.sbatch`. It trains a small neural network
with PyTorch on a dataset generated inside the script (again, **nothing is
downloaded**) and prints the `nvidia-smi` report so you can see the GPU it
landed on:

```bash
#!/bin/sh -l
#SBATCH -A <ACCOUNT>            # MANDATORY: your allocation account
#SBATCH -p gpu-debug            # GPU test queue: 30 min, up to 2 GPUs
#SBATCH --job-name=digits-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --gres=gpu:1            # <-- ask for ONE GPU
#SBATCH -t 00:25:00             # fits inside the 30-min gpu-debug limit

module load conda
# module load <pytorch-module>   # <- confirmed before the session; see instructor notes
cd $SLURM_SUBMIT_DIR
python3 train_gpu.py
```

`--gres=gpu:1` is the line that matters: each A100 node carries four GPUs, and
you are asking for one of them. The `gpu-debug` partition is made for exactly
this -- a 30-minute limit and up to two GPUs, so a class of people can all test
a GPU job without tying up production hardware.

# Submit and confirm you got a GPU

```bash
sbatch train-gpu.sbatch
squeue -u $USER                 # the node name starts with "g" = A100 node
cat slurm-<jobid>.out           # nvidia-smi + per-epoch training times
```

Two things in the output confirm you are on a GPU:

- `nvidia-smi` prints a line with `NVIDIA A100` and the GPU's memory.
- Each training line is tagged `[cuda]`, and the final line says it trained on
  `CUDA`.

```output
epoch 1: loss=0.6931  acc=0.502  0.210s  [cuda]
...
Final accuracy: 0.987 on CUDA
```

That is the payoff of the whole lesson: your AI workload just trained on
a national supercomputer GPU.

::::::::::::::::::::::::::::::::::::: callout

## No GPU in the output?

If `nvidia-smi` is missing or the output says `[cpu]`, the job landed on a CPU
node. The usual causes: the script is missing `--gres=gpu:1`, or it named a CPU
partition. Check both and resubmit; the next run will report a GPU.

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: challenge 

## The queue is busy

You submit the GPU job and it sits in `PENDING` because `gpu-debug` has no
free node. What do you do?

:::::::::::::::::::::::: solution 

## Submit-and-check-later is the real HPC experience

There is nothing wrong with the job -- the queue is just full. Leave it
submitted and it will run when a GPU node frees up. Note the job ID, and check
the output later with `squeue -j <jobid>` and `cat slurm-<jobid>.out`. This is
exactly how research jobs work on a shared machine: you submit, and the job
runs when the resource is available.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

This is the highlight of the session -- protect ten minutes for it. If `gpu-debug` is
saturated (check before the session), demo from the front and let attendees
submit and check later, framed as "the real HPC experience." The `<pytorch-module>`
line in the script is confirmed in the pre-session dry run; pin the exact module
or container there before the workshop.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints

- Request a GPU with `--gres=gpu:<n>` and submit to a GPU partition such as `gpu-debug`.
- A `g` node name and an `nvidia-smi` / `[cuda]` line in the output confirm the job ran on a GPU.
- If the GPU queue is full, the job waits in PENDING and runs when a node frees up -- that is normal on a shared cluster.

::::::::::::::::::::::::::::::::::::::::::::::::

