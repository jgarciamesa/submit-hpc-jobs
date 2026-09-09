# Submitting AI Jobs to the Anvil Supercomputer
### Beginner Track 1 --- AI for All Workshop, Sept 15 2026, The Mill at MSU Starkville

90-minute hands-on session (1:00--2:30 PM CT). Attendees learn to submit and monitor
AI jobs on the Anvil supercomputer (Purdue/ACCESS/NAIRR) using Slurm.

## Contents
| File | What it is |
|---|---|
| `lesson-plan.md` | Primary deliverable: minute-by-minute 90-min plan |
| `slides-outline.md` | Slide-by-slide outline (~18 slides) |
| `handout.md` | Attendee lab guide (follows the 4 labs) |
| `instructor-notes.md` | Pre-session checklist, timing cues, pitfalls, fallbacks |
| `labs/hello.py` + `labs/hello.sbatch` | Lab 1: first job, inspect the Slurm environment |
| `labs/train_digits.py` + `labs/train-digits-cpu.sbatch` | Lab 2: real AI job (scikit-learn digits, CPU, no download) |
| `labs/train-gpu.py` + `labs/train-gpu.sbatch` | Lab 3: PyTorch GPU job (gpu-debug partition) |
| `labs/array.sbatch` | Lab 4 (stretch): job arrays |

## Ground truth (verified from RCAC docs, Sept 2026)
- Anvil: 1,000 nodes, 2x 64-core AMD EPYC Milan per node (128 cores), Slurm scheduler,
  16 nodes x 4x NVIDIA A100 (partition `gpu`), 21 nodes x 4x H100 (partition `ai`).
- Login: `ssh <user>@anvil.rcac.purdue.edu` (SSH keys only; username is `x-<ACCESSname>`)
  or Open OnDemand: https://ondemand.anvil.rcac.purdue.edu
- Mandatory sbatch fields: `#SBATCH -A <account>` (find via `mybalance`) and
  `#SBATCH -p <partition>` (default is `shared` if omitted).
- Partitions: `debug` (2 hrs, quick tests), `gpu-debug` (30 min, 2 GPUs),
  `shared` (default, 128 cores, 96 hrs), `wholenode`, `wide`, `highmem`, `gpu`, `ai`.
- Software: Lmod modules (`module load conda` -> Anaconda 2021.05), Singularity,
  NGC containers on GPU nodes.
- Docs: https://docs.rcac.purdue.edu/userguides/anvil/ (Job Submission: .../jobs/)

## Adaptation decisions still open (see instructor-notes.md)
1. Which account string attendees use (ACCESS credit transfer vs. NAIRR allocation
   vs. a workshop-provided allocation) --- confirm with Preston Smith / RCAC before the session.
2. Exact GPU PyTorch module or NGC container for Lab 3 --- run `module spider pytorch`
   on Anvil login node during pre-session prep.
