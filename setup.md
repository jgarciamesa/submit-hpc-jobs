---
title: "Getting Set Up"
---

# Getting Set Up

## What you will need

- A laptop (MacOS or Linux, or Windows 10/11).
- An **Anvil account** with the workshop allocation attached. The workshop staff
  add registered attendees to the shared workshop allocation (`cis261672-gpu`);
  every lab in this lesson uses it, so you do not need your own allocation.
- A way to connect, one of:
  - **Open OnDemand in a browser** (preferred), or
  - **SSH** (requires additional setup).

### Find your Anvil username

Your Anvil username is **not** your ACCESS username. It is derived from it and
starts with the prefix `x-`. For example, if your ACCESS name is `jdoe`, your
Anvil username is likely `x-jdoe`. If you are not sure of the exact string,
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
can get them onto Anvil by cloning the GitHub repository or by downloading them
from the lesson website.

On Anvil:

```bash
git clone https://github.com/jgarciamesa/submit-hpc-jobs.git
cd submit-hpc-jobs/episodes/data/labs
ls
```

You should see `hello.py`, `hello.sbatch`, `train_digits.py`,
`train-digits-cpu.sbatch`, `train_gpu.py`, `train-gpu.sbatch`,
`train_sweep.py`, and `array.sbatch`.

## You are ready!

Additional information can be found in the [reference page](reference.html),
including the partition table (the workshop allocation reaches only the `gpu` and
`gpu-debug` partitions) and a command cheat sheet.

Start the lesson with [Episode 1](01-introduction.html).

[01-introduction.html]: 01-introduction.html
