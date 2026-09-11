---
title: "Your First Job: hello, Anvil"
teaching: 10 # teaching time in minutes
exercises: 12 # exercise time in minutes
---

# The job submission script

:::::::::::::::::::::::::::::::::::::: questions 

- What does a Slurm job submission script look like?
- How do you submit a job and watch it run?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Write the two mandatory `#SBATCH` lines for Anvil (account and partition).
- Submit a job with `sbatch` and track it with `squeue` and its output file.

::::::::::::::::::::::::::::::::::::::::::::::::


A Slurm job is a small shell script with special comment lines at the top. Lines
that start with `#SBATCH` are read by the scheduler; the rest of the script is
what actually runs on a compute node.

Here is the whole script for this episode's job, `hello.sbatch`:

```bash
#!/bin/sh -l
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
cd $SLURM_SUBMIT_DIR            # run from where you submitted the job
python3 hello.py
```

Two of these lines are **mandatory on Anvil**:

- `#SBATCH -A <account>` -- your allocation account. For this workshop that is `cis261672-gpu`, the shared workshop allocation (you can still check your own with `mybalance`). A job without it is rejected.
- `#SBATCH -p <partition>` -- which queue to run in. The GPU labs use `-p gpu-debug`; the CPU-only digits job uses `-p shared`.

A third line matters for this lesson: `#SBATCH --gres=gpu:1` asks for one
GPU. Jobs on the `gpu` and `gpu-debug` partitions must request a GPU --
even the `hello` job, which never touches one.

The other lines ask for resources: how many nodes, how many cores per task,
how much memory, how much time, and where the output goes. For a one-line
`hello` program, two cores and ten minutes are more than enough.

`hello.py`, the program the job runs, just prints a greeting and a few
environment variables:

```python
import os
import socket

print("Hello from Anvil!")
print("  Hostname : " + socket.gethostname())
print("  Node list: " + os.environ.get("SLURM_JOB_NODELIST", "not run under Slurm"))
```

# Submit it and watch it run

The script already names the workshop allocation (`cis261672-gpu`) and the
`gpu-debug` queue. If you have your own allocation and want to use it, replace
that `-A` value with the account string `mybalance` shows you. Then submit and
follow:

```bash
sbatch hello.sbatch        # -> "Submitted batch job 123456"
squeue -u $USER            # watch it go PENDING -> RUNNING -> (gone)
cat slurm-<jobid>.out      # read the output (replace <jobid> with your number)
```

`cat slurm-123456.out` shows the greeting **and** the node the job ran on:

```output
Hello from Anvil!
  Hostname : g012
  Node list: g012
```

If the hostname is a `g...` node (an A100 node) and not the machine you typed on, you have seen the whole model work: you submitted on the login node, the scheduler ran your job on a compute node, and wrote the result to a file you read back.

# Manage your jobs

Three more commands complete the toolbox. They work on any job you have ever
submitted (not just running ones):

```bash
sacct -u $USER            # an accounting ledger of every job: state, time, resources
scancel <jobid>           # cancel a job you no longer need
squeue -u $USER           # (again) only the jobs still in the queue
```

`sacct` is the one to reach for after the fact: it lists finished jobs with
their final state (`COMPLETED`, `CANCELLED`, `TIMEOUT`, `FAILED`), the wall time
used, and the resources allocated. `scancel` is how you free a queue slot if a
job misbehaves or you simply changed your mind.

A good habit: submit, then immediately note the job ID and re-check with `squeue`
in a couple of minutes. When something is not working, `sacct -j <jobid>` tells
you *why*.

::::::::::::::::::::::::::::::::::::: challenge

## Why is my job stuck in PENDING?

You submitted `hello.sbatch` and `squeue -u $USER` shows it as `PD` (pending)
for more than a minute. What is the most likely cause, and how do you check it?

:::::::::::::::::::::::: solution

## Most likely: the queue is full

On `gpu-debug`, only one job per user may run at a time. If your previous `hello` job is still running, this one waits. Check the reason with:

```bash
squeue -j <jobid> -o "%r"
```

which prints the hold reason. Most often the reason is simply `Resources` --
wait for the running job to finish, or cancel it first with `scancel <oldjobid>`.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: challenge

## I got an account error

You submitted and Slurm replied with something like `error: invalid account
specified` or `failed to map user`. What went wrong?

:::::::::::::::::::::::: solution

## Missing or wrong -A account

The `-A` line is missing, or the string does not match an account on your
allocation. Run `mybalance`, copy the exact string, and put it on the
`#SBATCH -A` line. Remember it is the *allocation* account, not your username.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints

- A Slurm job script is a shell script whose `#SBATCH` lines request resources; the rest runs on a compute node.
- `-A <account>` and `-p <partition>` are mandatory on Anvil.
- Submit with `sbatch <script>`, follow with `squeue -u $USER`, and read the `slurm-<jobid>.out` file.

::::::::::::::::::::::::::::::::::::::::::::::::

