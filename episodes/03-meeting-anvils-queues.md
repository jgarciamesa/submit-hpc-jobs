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
Here are the partitions you will use in this lesson:

| Partition   | Node type   | Max time | Max running jobs/user | GPUs | Notes |
|-------------|-------------|----------|-----------------------|------|-------|
| `debug`     | regular CPU | 2 hrs    | 1                     | --   | Short CPU tests |
| `shared`    | regular CPU | 96 hrs   | many                  | --   | Default CPU partition -- episode 5 runs here |
| `gpu-debug` | GPU (A100)  | 0.5 hrs  | 1                     | 2 max| **workshop queue** -- the GPU labs run here |
| `gpu`       | GPU (A100)  | 48 hrs   | --                    | 4    | A100 production jobs (your other queue) |

Everything else on Anvil is listed on the [reference page](reference.html) --
you will not need it in this lesson.

Two things to remember about the queues in this lesson:

1. **Jobs on `gpu` or `gpu-debug` must ask for a GPU** -- with
   `--gres=gpu:1` -- even if the program never uses one. (That is why even the
   `hello` job carries the line.) CPU-only jobs go to `shared` and skip it.
2. **`gpu-debug` only lets one running job per user at a time.** Finish (or
   cancel) a job before you submit the next one -- a second submission just
   waits in `PENDING`. `shared` does not have that single-job workshop cap.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Ask "how many of you have run anything on a cluster before?" here. If
most hands go up, skim the tables and move on. If most hands go down, slow
down on the first table -- the partition concept is new. Either way, do not
exceed ten minutes.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints

- A partition is a named queue with its own machines and limits (max time, max nodes, max jobs per user).
- The lesson uses `debug` and `shared` for CPU work, plus `gpu-debug` and `gpu` for A100 work.
- `gpu-debug` runs one job per user at a time; jobs on `gpu` or `gpu-debug` must ask for a GPU with `--gres`.

::::::::::::::::::::::::::::::::::::::::::::::::
