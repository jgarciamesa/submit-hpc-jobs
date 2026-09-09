---
title: "Introduction: AI Workloads on a Supercomputer"
teaching: 10 # teaching time in minutes
exercises: 0 # exercise time in minutes
questions:
- Why do researchers submit jobs to a queue instead of running programs directly on a supercomputer?
- What is the difference between a login node and a compute node?
objectives:
- Explain the login-node and compute-node model, and why work is submitted to a queue.
- Describe what Anvil is and the hardware it offers for AI workloads.
---

# Why a supercomputer for AI?

Your laptop is a fine machine, but it holds one (or a few) chips and a few tens
of gigabytes of memory. Training or serving a modern AI model can take hundreds
of gigabytes of memory and many hours of arithmetic. **Anvil** is a
supercomputer built for exactly that kind of work, and in this lesson you will
submit your own AI jobs to it.

Anvil is operated by Purdue's [Research Computing
Center][rcac] and is an NSF-funded [ACCESS][access] resource. By the numbers:

- 1,000+ compute nodes, each with 128 AMD EPYC cores.
- 16 nodes carrying 4x NVIDIA A100 GPUs each.
- 21 nodes carrying 4x NVIDIA H100 GPUs each.

The hardware is the easy part. What makes a supercomputer *work* is the **job
scheduler** that shares it fairly among hundreds of users at once. That is what
you will learn to drive.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

You are connecting to the morning session on national-level AI and HPC
resources. A one-line bridge earns a lot of attention: "This is the machine that
talk was about, and by 2:30 you will have run your own job on it." Keep this
episode to ten minutes -- the partition table in the next episode is reference,
not a lecture, so do not over-explain.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Login nodes and compute nodes

When you log in to Anvil you land on a **login node**. A login node is a small
front desk: it is where you edit files, check on jobs, and submit work. It is
*not* where heavy work is done.

Every user shares the same handful of login nodes. If you ran a training job
right there, you would slow down every other person using the machine, so
**running jobs on a login node is against Anvil policy.**

Instead, you write your work out as a job and submit it to the scheduler. The
scheduler places your job on a **compute node** -- a full server with 128
cores, or a GPU server -- and runs it when the resources you asked for become
available.

::::::::::::::::::::::::::::::::::::: callout

## The whole model in one sentence

You do the small stuff on the login node; you *submit* the heavy stuff to a
queue, and the scheduler runs it on a compute node for you.

::::::::::::::::::::::::::::::::::::::::::::::::


# What you will be able to do

By the end of this lesson you will have:

1. Logged in to Anvil (by SSH key, or through the browser if you do not have a key).
2. Submitted a first batch job and watched it run.
3. Run a real AI job on the CPU nodes.
4. Run an AI job on an A100 GPU.
5. Seen how one script can become many experiments with a *job array*.

In the next episode you will connect to the machine and look around.

::::::::::::::::::::::::::::::::::::: keypoints

- Anvil is an NSF-funded ACCESS supercomputer: ~1,000 CPU nodes, 16 A100 GPU nodes, 21 H100 GPU nodes.
- You log in to a login node; you submit jobs to a scheduler, which runs them on compute nodes.
- Running heavy work directly on the login node is against Anvil policy.

::::::::::::::::::::::::::::::::::::::::::::::::

