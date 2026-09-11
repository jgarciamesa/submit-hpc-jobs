---
title: "Meeting Anvil's Queues (Partitions)"
teaching: 10 # teaching time in minutes
exercises: 5 # exercise time in minutes
---

# What is a partition?

:::::::::::::::::::::::::::::::::::::: questions 

- What is a partition, and why are there so many of them?
- Which queues are best for short testing runs, like the ones in this lesson?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Explain what a Slurm partition is and how to read its limits.
- Choose the right partition for a testing run versus a production run.

::::::::::::::::::::::::::::::::::::::::::::::::


Slurm (Anvil's scheduler) groups compute resources into **partitions** -- the
technical name for a *queue*. Each partition has its own machines and its own
rules: how many nodes a job may use, how long it may run, and how many jobs
one person may run at once.

Why separate queues? Because different jobs need different things. Some need
GPUs, some need lots of memory, some only run for a minute. Keeping them in
separate queues lets the scheduler run the system efficiently and fairly.

You can see all of them with `showpartitions` (run it in the previous episode).
Here is what matters for this lesson:

| Partition   | Node type      | Max nodes/job | Max time | Max running jobs/user | Notes |
|-------------|----------------|---------------|----------|-----------------------|-------|
| `gpu-debug` | GPU (A100)     | 1             | 0.5 hrs  | 1                     | **workshop queue** -- every lab in this lesson runs here, including the CPU-only jobs |
| `gpu`       | GPU (A100)     | --            | 48 hrs   | --                    | A100 production jobs (your other queue) |
| `debug`     | regular CPU    | 2             | 2 hrs    | 1                     | CPU-only test queue (not on this allocation) |
| `shared`    | regular CPU    | 1 (128 cores) | 96 hrs   | many                  | the **default** CPU queue (not on this allocation) |
| `wholenode` | regular CPU    | 16            | 96 hrs   | 64                    | node-exclusive CPU (not on this allocation) |
| `wide`      | regular CPU    | 56            | 12 hrs   | 5                     | wide multi-node CPU (not on this allocation) |
| `highmem`   | large-memory   | 1             | 48 hrs   | 2                     | ~1 TB RAM, charges 4x (not on this allocation) |
| `ai`        | GPU (H100)     | --            | 48 hrs   | --                    | H100 production jobs (not on this allocation) |

The workshop allocation `cis261672-gpu` only reaches the two starred
partitions -- `gpu-debug` and `gpu`. Every lab in this lesson therefore runs on
`gpu-debug`, **including the CPU-only jobs** (they run on the CPU cores of an
A100 node without asking for a GPU). You will not hit "access denied" on a
queue in this lesson.

# Two rules that will save you time

1. **You must name a partition with `-p` in every job script.** The workshop labs
   always use `-p gpu-debug`.
2. **`gpu-debug` only lets one running job per user at a time.** Finish (or cancel)
   a job before you submit the next one -- a second submission just waits in
   `PENDING`.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Ask "how many of you have run anything on a cluster before?" here. If
most hands go up, skim the table and spend the time on the two rules. If most
hands go down, slow down on the table -- the partition concept is new. Either
way, do not exceed ten minutes.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints

- A partition is a named queue with its own machines and limits (max nodes, max time, max jobs per user).
- The workshop allocation reaches only `gpu-debug` (all labs) and `gpu` (production A100).
- `gpu-debug` runs one job per user at a time; name it with `-p` in every script.

::::::::::::::::::::::::::::::::::::::::::::::::

