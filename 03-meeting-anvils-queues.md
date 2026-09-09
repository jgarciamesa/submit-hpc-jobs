---
title: "Meeting Anvil's Queues (Partitions)"
teaching: 10 # teaching time in minutes
exercises: 5 # exercise time in minutes
questions:
- What is a partition, and why are there so many of them?
- Which queues are best for short testing runs, like the ones in this lesson?
objectives:
- Explain what a Slurm partition is and how to read its limits.
- Choose the right partition for a testing run versus a production run.
---

# What is a partition?

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
| `debug`     | regular CPU    | 2             | 2 hrs    | 1                     | short tests -- our CPU labs use this |
| `gpu-debug` | GPU (A100)     | 1             | 0.5 hrs  | 1                     | short GPU tests -- our GPU lab uses this |
| `shared`    | regular CPU    | 1 (128 cores) | 96 hrs   | many                  | the **default** CPU queue |
| `wholenode` | regular CPU    | 16            | 96 hrs   | 64                    | node-exclusive CPU |
| `wide`      | regular CPU    | 56            | 12 hrs   | 5                     | wide multi-node CPU |
| `highmem`   | large-memory   | 1             | 48 hrs   | 2                     | ~1 TB RAM, charges 4x |
| `gpu`       | GPU (A100)     | --            | 48 hrs   | --                    | A100 production jobs |
| `ai`        | GPU (H100)     | --            | 48 hrs   | --                    | H100 production jobs |

::::::::::::::::::::::::::::::::::::: callout

## Debug queues are a class's best friend

The `debug` and `gpu-debug` partitions exist for exactly what you are doing:
quick tests with tight time limits and no cost. They are not for production
work, but for a lesson they are perfect.

::::::::::::::::::::::::::::::::::::::::::::::::


# Two rules that will save you time

1. **You must name a partition with `-p` in every job script.** If you do not,
   Slurm uses the default (`shared`). That is fine, but say it out loud in your
   head: *no `-p` means `shared`*, not *no queue*.
2. **The `debug` and `gpu-debug` queues only let one running job per user at a
   time.** If you submit a second job before the first finishes, it waits in
   `PENDING`. That is not an error -- it is the queue doing its job. We will
   use that waiting to learn how to read the queue.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Ask "how many of you have run anything on a cluster before?" here. If
most hands go up, skim the table and spend the time on the two rules. If most
hands go down, slow down on the table -- the partition concept is new. Either
way, do not exceed ten minutes.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints

- A partition is a named queue with its own machines and limits (max nodes, max time, max jobs per user).
- Use `debug` (CPU) and `gpu-debug` (A100) for short testing runs; use `shared`, `gpu`, or `ai` for production.
- Always name a partition with `-p`; if you omit it, Slurm uses the default `shared` partition.

::::::::::::::::::::::::::::::::::::::::::::::::

