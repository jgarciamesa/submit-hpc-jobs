---
layout: lesson
---

# Submitting AI Jobs to the Anvil Supercomputer

You will learn to submit, monitor, and manage artificial-intelligence workloads
on **Anvil**, a national supercomputer operated by Purdue's Research Computing
Center (RCAC) and funded by the NSF's ACCESS and NAIRR allocation programs.

This lesson was written for the **"AI for All: Practical and Accessible AI for
Research and Education"** workshop (MSU Starkville, September 15, 2026). It is a
90-minute, hands-on, beginner session: no prior HPC experience is assumed, and
by the end you will have run your own AI job on a supercomputer -- on both CPU
and GPU nodes.

## What you will be able to do

1. Explain the **login-node vs. compute-node** model and why jobs are submitted
   to a queue instead of run interactively.
2. **Log in** to Anvil using an SSH key, or through Open OnDemand in a browser.
3. **Submit** a batch job with `sbatch` using a correct submission script
   (account, partition, time, resources).
4. **Monitor and manage** jobs with `squeue`, `sacct`, and `scancel`, and read
   the output files they produce.
5. **Escalate to an AI workload**: run a machine-learning training job on the
   CPU nodes, then a PyTorch job on an A100 GPU, requesting GPUs with `--gres`.
6. **Know where to go next**: ACCESS and NAIRR allocations, documentation, and
   the support channels.

## How this lesson is organised

The lesson is a sequence of short episodes, each built around doing something
real. The two you will use constantly are:

- **The lab files** live in the repo's `episodes/data/labs/` folder -- each
  lab is a small Python script plus a `.sbatch` submission script. They are
  copied to the `data/labs/` folder of the built site.
- **The reference page** ([learners/reference.md](learners/reference.md)) holds
  the partition table, a command cheat sheet, and a troubleshooting table.
  Keep it open in a second tab.

> [!NOTE]
> If you are an instructor, see the
> [instructor notes](instructors/instructor-notes.md) for the pre-session
> checklist, minute-by-minute timing, and fallbacks for when a lab runs long.

Let's begin with [why a supercomputer for AI][01-introduction].
