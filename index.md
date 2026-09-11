---
layout: lesson
---

# Submitting AI Jobs to the Anvil Supercomputer

You will learn to submit, monitor, and manage artificial-intelligence workloads
on **Anvil**, a national supercomputer operated by Purdue's Research Computing
Center and funded by the NSF's [ACCESS](https://access-ci.org/) program.

This lesson was written for the **"AI for All: Practical and Accessible AI for
Research and Education"** workshop (MSU Starkville, September 15, 2026). It is a
hands-on, beginner session: no prior HPC experience is assumed, and
by the end you will have run an AI job on a supercomputer.

## What you will be able to do

1. Understand the **login-node vs. compute-node** model and why jobs are submitted
   to a queue instead of run interactively.
2. **Log in** to Anvil using an SSH key, or through Open OnDemand in a browser.
3. **Submit** a batch job with `sbatch` using a submission script
   (account, partition, time, resources).
4. **Monitor and manage** jobs with `squeue`, `sacct`, and `scancel`, and read
   the output files they produce.
5. **Escalate to an AI workload**: run a machine-learning training job on the
   CPU nodes, then a PyTorch job on an A100 GPU.
6. **Know where to go next**: ACCESS and NAIRR allocations, documentation, and
   the support channels.
