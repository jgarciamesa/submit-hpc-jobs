---
title: "Wrap-Up: Allocations, Rules, and Where to Go Next"
teaching: 12 # teaching time in minutes
exercises: 5 # exercise time in minutes
questions:
- How do you get your own allocation on Anvil?
- What are the rules of the road on a shared supercomputer?
objectives:
- Explain the ACCESS and NAIRR allocation paths.
- State the etiquette that keeps a shared supercomputer usable.
- Locate the documentation and support channels for follow-up.
---

# What you did today

You connected to a national supercomputer, read your allocation, and drove its
scheduler. You have now:

- Logged in to Anvil and found your allocation account with `mybalance`.
- Submitted a batch job with `sbatch` and watched it go `PENDING` to `RUNNING`.
- Managed jobs with `squeue`, `sacct`, and `scancel`.
- Trained a machine-learning model on the CPU nodes.
- Trained a neural network on an A100 GPU (`nvidia-smi` in the output).
- (Stretch) Fanned one script out into a five-task job array.

Each of those is a repeatable HPC skill. The two lines that make all of it work
are the ones you have used all session: `#SBATCH -A <account>` and
`#SBATCH -p <partition>`.

# Your next job is the hard one: getting your own allocation

Running on Anvil is free for testing, but real research work needs an
**allocation** -- a slice of the machine's time, paid for by a funding source.
The paths most relevant to a Mississippi researcher:

- **ACCESS** -- the NSF-funded allocation program that backs Anvil's CPU and A100
  resources. You request credits and transfer them to Anvil under your own name.
- **NAIRR** -- the AI-focused NSF allocation that provides automatic-approval
  access to Anvil's H100 nodes and to other national AI resources.

Both are documented at [ACCESS][access] and [NAIRR][nairr]. Ask your department's
research computing contact, or the workshop's HPC team, to help submit the first
request -- it is a form and an email, not a research proposal.

::::::::::::::::::::::::::::::::::::: callout

## Where to get help

- **Documentation:** the Anvil user guide, <https://docs.rcac.purdue.edu/userguides/anvil/>.
- **Email:** `rcac-help@purdue.edu` -- the RCAC support desk, and the right first
  stop for allocation and account questions.
- **This lesson:** the reference page in this site has the partition table and
  every command in one place. Save it.

::::::::::::::::::::::::::::::::::::::::::::::::


# Rules of the road

A few norms keep a shared machine pleasant for everyone:

1. **Do not run heavy work on the login node.** Edit and submit there; compute
   nodes do the computing.
2. **Use `debug` / `gpu-debug` for testing**, and the production partitions
   (`shared`, `gpu`, `ai`) for the real work.
3. **Ask for what you need, not more.** A job that requests 128 cores and uses 2
   holds 126 cores hostage for the whole run. `highmem` nodes charge 4x and
   node-exclusive queues bill all 128 cores even if you use one.
4. **Cancel what you do not need.** A forgotten job at the head of the queue is
   blocking a colleague's afternoon.

These are not rules to memorize and forget -- they are the same etiquette you
already use in a shared lab or office.

::::::::::::::::::::::::::::::::::::: keypoints

- Testing is free on `debug`/`gpu-debug`; real work needs an ACCESS or NAIRR allocation.
- Get help from the Anvil docs, `rcac-help@purdue.edu`, or the reference page on this site.
- Be a good citizen: no heavy work on login nodes, request only the resources you need, and cancel jobs you no longer need.

::::::::::::::::::::::::::::::::::::::::::::::::

