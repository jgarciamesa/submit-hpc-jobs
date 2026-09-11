---
title: "Reference"
---

# Reference: Anvil Commands and Queues

This page is the desk reference for the whole lesson. Keep it open in a second
tab while you work through the labs.

## The partitions (queues)

Run `showpartitions` on Anvil to see the live version of these tables. The
columns that matter most for a class are **max time**, **max running
jobs/user**, and **GPU**. The workshop allocation `cis261672-gpu` reaches
`gpu-debug` and `gpu`; the CPU-only digits job in episode 5 runs on `shared`.

The partitions you will use:

| Partition   | Node type  | Max time | Max running jobs/user | GPUs | Notes |
|-------------|------------|----------|-----------------------|------|-------|
| `gpu-debug` | GPU (A100) | 0.5 hrs  | 1                     | 2 max| **workshop queue** -- every GPU lab runs here |
| `gpu`       | GPU (A100) | 48 hrs   | -                     | 4    | A100 production jobs (your other queue) |

The other partitions on Anvil:

| Partition   | Node type    | Max time | Max running jobs/user | GPUs | Notes |
|-------------|--------------|----------|-----------------------|------|-------|
| `debug`     | regular CPU  | 2 hrs    | 1                     | -    | Short CPU tests (not on this allocation) |
| `shared`    | regular CPU  | 96 hrs   | many                  | -    | The **default** CPU partition -- the episode 5 digits job runs here |
| `wholenode` | regular CPU  | 96 hrs   | 64                    | -    | Node-exclusive CPU, bills all 128 cores (not on this allocation) |
| `wide`      | regular CPU  | 12 hrs   | 5                     | -    | Wide multi-node CPU (not on this allocation) |
| `highmem`   | large-memory | 48 hrs   | 2                     | -    | ~1 TB RAM, charges 4x (not on this allocation) |
| `ai`        | GPU (H100)   | 48 hrs   | -                     | 4    | H100 production jobs (not on this allocation) |

**Node type codes (from `sfeatures`):** `a[000-999]` are the AMD CPU nodes,
`g[000-015]` carry NVIDIA A100 GPUs, and `h[000-020]` carry NVIDIA H100 GPUs.
If your job's node name starts with `g`, you are on an A100; `h` means H100.

## Command cheat sheet

```bash
# --- connect ---
# Preferred: log in to Open OnDemand (https://ondemand.rcac.purdue.edu) and
# open Clusters - Shell access. With an SSH key set up:
ssh <x-username>@anvil.rcac.purdue.edu

# --- your account and the queues ---
mybalance          # your allocation account string (the -A value)
showpartitions     # all partitions, free cores, time limits
sfeatures          # node types: a* CPU, g* A100, h* H100

# --- submit and manage ---
sbatch <script>            # submit a job -> prints the job ID
squeue -u $USER            # your jobs currently in the queue
sacct -u $USER             # accounting ledger of all your jobs (past + present)
scancel <jobid>            # cancel a running or pending job

# --- read results ---
cat slurm-<jobid>.out      # the job's standard output
```

### The two mandatory `#SBATCH` lines

Every Anvil job script needs these or it is rejected:

```bash
#SBATCH -A cis261672-gpu   # workshop allocation (or your own: `mybalance`)
#SBATCH -p gpu-debug        # workshop test queue (30-min limit, 1 job per user)
```

A job without `-A` fails with `error: invalid account specified` or
`failed to map user`. That is the number-one first-submission mistake.

## Anvil-specific differences (if you know Slurm)

Most of this is standard Slurm. The Anvil quirks worth knowing:

- **Account string from `mybalance`, not your username.** You pass the
  *allocation* account with `-A`, not your login name. Run `mybalance` to see
  it.
- **`-A` and `-p` are both mandatory in practice.** Other clusters may let you
  omit the partition; on Anvil, name it.
- **`gpu-debug` is per-user single-job.** Only one running job per user at a
  time (the queue this lesson uses). A second submission waits in `PENDING` --
  that is expected, not an error.
- **Node-exclusive and memory partitions cost more.** `wholenode` bills all
  128 cores even if you use one; `highmem` charges 4x. Do not reach for these
  to make a job "faster" -- ask for the size that fits.
- **GPUs via `--gres`.** Every job on a `gpu`/`gpu-debug` partition asks for a
  GPU with `--gres=gpu:1` (or `:2`), even if the program never uses one. A
  CPU-only job goes to a CPU partition such as `shared` and omits the line.

## Lab file index

All lab files are in the flat [`data/labs/`](data/labs/) folder of this site. Each is a
self-contained Python script plus its `.sbatch` submission script. None of them
download data -- the datasets are built into the libraries or generated in the
script, so they are fast and polite to the cluster.

| File | What it does | Episode |
|------|--------------|---------|
| `hello.py` / `hello.sbatch` | Prints a greeting and the Slurm environment (which node you ran on) | [Your first job](04-your-first-job.html) |
| `train_digits.py` / `train-digits-cpu.sbatch` | Trains an SVM digit classifier, reports test accuracy | [A real AI job on the CPU](05-an-ai-job-on-cpu.html) |
| `train_gpu.py` / `train-gpu.sbatch` | Trains a small PyTorch net on a GPU, prints `nvidia-smi` | [An AI job on a GPU](06-an-ai-job-on-a-gpu.html) |
| `train_sweep.py` / `array.sbatch` | Hyperparameter sweep as a 5-task job array | [Job arrays](07-job-arrays.html) |

## Troubleshooting

| Symptom | Likely cause | Fix |
|---------|--------------|-----|
| `failed to map user <you>@access-ci.org` on `ssh` | Allocation not attached to Anvil yet | Use Open OnDemand; flag for the allocation episode |
| `error: invalid account specified` | Missing or wrong `-A` line | Run `mybalance`, copy the exact string into `#SBATCH -A` |
| `sbatch: error: Invalid partition name` | Typo in `-p` | Use the partition the lab names: `shared` for the CPU lab, `gpu-debug` for the GPU labs |
| Job sits in `PD` (pending) | Queue full, or a prior job of yours is still running | `scancel <oldjobid>` or wait; check reason with `squeue -j <id> -o "%r"` |
| `nvidia-smi` missing / output says `[cpu]` | Job landed on a CPU node | Add `--gres=gpu:1` and use a `gpu` partition |
| `No module named 'torch'` | PyTorch not loaded in the script | Add the confirmed PyTorch module line (see instructor notes) |
| `slurm-<id>.out` is empty | Job still running, or wrote to a different file | Check `sacct -j <id>` for state and the `StdOut` path |

## Where to get help

- **Documentation:** the Anvil user guide, <https://docs.rcac.purdue.edu/userguides/anvil/>.
- **Support desk:** `rcac-help@purdue.edu` -- the right first stop for
  allocation and account questions.
- **This site:** the setup page, the episodes, and this reference page.

[04-your-first-job.html]: 04-your-first-job.html
[05-an-ai-job-on-cpu.html]: 05-an-ai-job-on-cpu.html
[06-an-ai-job-on-a-gpu.html]: 06-an-ai-job-on-a-gpu.html
[07-job-arrays.html]: 07-job-arrays.html
