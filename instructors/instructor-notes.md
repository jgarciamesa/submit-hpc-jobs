---
title: "Instructor Notes"
---

# Instructor Notes

These notes are for whoever leads the session. They complement the **inline
instructor notes** embedded in each episode (visible only in the instructor
view of this site) -- the inline notes carry the per-episode beats, this page
carries the whole-session logistics.

- **Session:** "Submitting AI Jobs to the Anvil Supercomputer"
- **Where/when:** The Mill at MSU, Starkville, MS -- September 15, 2026,
  Beginner Track 1, 1:00--2:30 PM CT (90 minutes).
- **Instructor:** Juanjo Garcia Mesa (ASU Research Technology Office).
- **Audience:** Beginners -- faculty, students, staff from Mississippi research
  institutions; no HPC experience assumed. Some will have just finished the
  morning "Leveraging National Level AI and HPC Resources" talk -- open by
  connecting to it.

## Pre-session checklist (T-minus)

Do these **before** the workshop. Accounts are the number-one success factor.

- [ ] **Accounts provisioned.** Every registered attendee has an Anvil account
      with their ACCESS or NAIRR allocation attached. Confirm the Anvil
      username (the `x-`-prefixed one) for the pre-provisioned group.
- [ ] **Lab files staged.** Copy the site's [`data/labs/`](data/labs/) folder to a shared location on
      Anvil (e.g. `~/ai-workshop-submit-jobs` for a workshop user) *and* confirm
      the GitHub repo is public so attendees can `git clone` it.
- [ ] **GPU partition checked.** `showpartitions | grep gpu-debug` -- note how
      many A100 nodes are free. If saturated, plan to demo the GPU lab from the
      front and have attendees submit-and-check-later.
- [ ] **PyTorch module pinned.** On an Anvil login node run
      `module spider pytorch` and put the exact module line into
      `train-gpu.sbatch` (the commented line near the top). Until then the GPU
      script has a placeholder.
- [ ] **Dry-run each lab** on a `debug` / `gpu-debug` job as yourself so you
      know the real wall time and the exact output to show.

## The two open items to resolve before the session

1. **The account string.** Every lab's `.sbatch` has `#SBATCH -A <ACCOUNT>`.
   Do not hard-code one account into the published files -- attendees each use
   their own from `mybalance`. For the *instructor's* own demo jobs, note your
   account separately.
2. **The PyTorch module.** Pin the exact `module load <pytorch>` (or the
   Singularity/NGC container command) in `train-gpu.sbatch`. The script is
   written to load `conda` first, so a module-based PyTorch or a module-based
   Singularity both fit the existing structure.

## Timing (90 minutes: 15 framing / 60 hands-on / 15 wrap-up)

The lesson has eight episodes; the session walks through them as follows. Each
hands-on lab is **checkpointed** -- no one falls more than one lab behind, and
each lab ends on a visible success signal before you move on.

| Time | Episode | Activity | Checkpoint |
|------|---------|----------|------------|
| 1:00--1:15 (15m) | [01][ep1], [03][ep3] | Framing: why HPC, login/compute model, the partition table | Everyone sees the partition table |
| 1:15--1:27 (12m) | [02][ep2] | Lab 1: connect, `mybalance`, `showpartitions`, `sfeatures` | Everyone can name their account string |
| 1:27--1:39 (12m) | [04][ep4] | Lab 2: submit `hello.sbatch`, watch `squeue`, `cat` the output | Everyone has a `slurm-*.out` with their job ID |
| 1:39--1:57 (18m) | [05][ep5] | Lab 3: digits CPU training job | Everyone sees a test-accuracy number |
| 1:57--2:12 (15m) | [06][ep6] | Lab 4: GPU PyTorch job (`--gres=gpu:1`) | `nvidia-smi` shows `NVIDIA A100` |
| 2:12--2:15 (if 10m+ remain) | [07][ep7] | Stretch: job-array sweep | One array of 5 tasks submitted |
| 2:15--2:30 (15m) | [08][ep8] | Wrap-up: allocations, rules of the road, help, Q&A | Everyone leaves with the reference page |

## Fallbacks (when a lab runs long)

- **Cut line is Labs 3 and 4.** If you are more than five minutes behind at the
  start of Lab 3, convert it to a front-of-room demo: you submit and walk the
  output, attendees submit on their own and check the result after. **Never**
  cut Lab 2 (it is the core `sbatch` skill) or the wrap-up.
- **`debug` queue busy at 1 PM.** Every lab also runs on `shared` (the default
  partition) -- a one-line change to `-p shared`. Mention this so attendees are
  not blocked.
- **`gpu-debug` saturated.** Demo from the front; attendees submit and leave
  with a `PENDING` job plus instructions to check the output later. Frame it as
  the real HPC experience: *your job runs when the resource is free.*
- **SSH keys not set up (biggest time sink).** Route those people to the
  OnDemand browser shell; helpers roam. Do not spend the group's time on one
  person's key.

## Differentiation by audience

- **Never touched a terminal:** the OnDemand GUI runs every lab except the
  stretch; the setup page walks SSH-key creation for anyone who wants it.
- **Has a cluster account elsewhere:** "if you know Slurm, you know Anvil."
  Point them to the *Anvil-specific differences* section of the reference page
  (account string, `mybalance`, debug queues).
- **Fast finishers:** the job-array stretch, then explore `sacct` columns and
  the charge factors.

## Success criteria

- At least **80%** of attendees produce their own `slurm-*.out` (Lab 2).
- At least **60%** see A100 `nvidia-smi` output from their own GPU job (Lab 4).
- Every attendee leaves with the reference page and knows the two mandatory
  `#SBATCH` lines (`-A`, `-p`) by heart.

[ep1]: 01-introduction.html
[ep2]: 02-connecting-to-anvil.html
[ep3]: 03-meeting-anvils-queues.html
[ep4]: 04-your-first-job.html
[ep5]: 05-an-ai-job-on-cpu.html
[ep6]: 06-an-ai-job-on-a-gpu.html
[ep7]: 07-job-arrays.html
[ep8]: 08-wrap-up.html
