---
title: "Getting Set Up"
---

# Getting Set Up

This lesson is **hands-on on a real supercomputer**. Everything you need is a
laptop, a way to reach Anvil, and the lab files. The single biggest factor in
finishing all four labs is having a working connection, so take a little time
here rather than getting stuck mid-lab.

## What you will need

- A laptop (macOS or Linux, or Windows 10/11).
- An **Anvil account**. If you registered for the workshop, your ACCESS or
  NAIRR allocation has been attached to an Anvil account for you. If you are
  here on your own, you will need an allocation first -- see the
  [wrap-up episode](08-wrap-up.html) for the ACCESS and NAIRR paths, or ask the
  workshop's HPC team.
- A way to connect, one of:
  - **SSH** from your terminal (fastest), or
  - **Open OnDemand in a browser** (the zero-install fallback -- every lab in
    this lesson also works in the OnDemand web shell).

## Connect with SSH (recommended)

SSH is the standard way to reach a Unix supercomputer. The connection string is
always:

```bash
ssh <your-anvil-username>@anvil.rcac.purdue.edu
```

### Find your Anvil username

Your Anvil username is **not** your ACCESS username. It is derived from it and
starts with the prefix `x-`. For example, if your ACCESS name is `jdoe`, your
Anvil name is something like `x-jdoe`. If you are not sure of the exact string,
the OnDemand account page and the workshop team both know it.

### No SSH key yet? Create one (five minutes)

Anvil accepts **SSH keys only** -- it does not accept passwords. If you have
never generated a key, do it now; you will want one for every cluster you ever
use.

On macOS or Linux:

```bash
ssh-keygen -t ed25519 -C "my-laptop"
```

Press **Return** at each prompt (an empty passphrase is fine for a workshop).
Then show the public half of the key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy that whole line. On a new Anvil account, register it through **Open
OnDemand** (your account page has an "Add SSH Key" field) or ask the workshop
team to register it for you. You only need to do this once per account.

On Windows, use **Git Bash** (included with Git for Windows) or **Windows
PowerShell**, which ships with an OpenSSH client on Windows 10 and later. The
same `ssh-keygen` commands work.

## Get the lab files

Each lab is two files: a Python script and a `.sbatch` submission script. You
have three ways to get them onto Anvil:

1. **They are already there.** If you were given a pre-staged directory
   (typically `~/ai-workshop-submit-jobs`), just `cd` into it. This is the
   fastest path and the one the workshop uses.
2. **Clone the repository.** On Anvil:

   ```bash
   git clone https://github.com/jgarciamesa/submit-hpc-jobs.git
   cd submit-hpc-jobs/episodes/data/labs
   ```

3. **Copy from your laptop** with `scp`, if you have the files locally:

   ```bash
   scp <file> <your-anvil-username>@anvil.rcac.purdue.edu:~/
   ```

Whichever way you get them, confirm you can see them:

```bash
ls
```

You should see `hello.py`, `hello.sbatch`, `train_digits.py`,
`train-digits-cpu.sbatch`, `train_gpu.py`, `train-gpu.sbatch`,
`train_sweep.py`, and `array.sbatch`.

## You are ready

Open a second tab to the [reference page](reference.html) -- the partition table
and the command cheat sheet are the two things you will look up most. Then
start with [Episode 1][01-introduction.html].

[01-introduction.html]: 01-introduction.html
