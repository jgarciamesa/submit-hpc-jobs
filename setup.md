---
title: "Getting Set Up"
---

# Getting Set Up

## What you will need

- A laptop (MacOS or Linux, or Windows 10/11).
- An **Anvil account** with the workshop allocation attached. The workshop staff
  add registered attendees to the shared workshop allocation (`cis261672-gpu`);
  the GPU labs use it, so you do not need your own allocation.
- A web browser. You will get your shell from the **Open OnDemand**
  portal -- no software to install. (Already have an SSH key on Anvil? The
  SSH route in episode 2 works too.)

### Open a shell (recommended)

Log in to [Open OnDemand][ondemand] with your ACCESS credentials, then open
*Clusters - Shell access*. A terminal opens in your browser, and every command
in this lesson runs in it. You do not need to install or configure anything.

### Find your Anvil username

Your Anvil username is **not** your ACCESS username. It is derived from it and
starts with the prefix `x-`. For example, if your ACCESS name is `jdoe`, your
Anvil username is likely `x-jdoe`. You only need it for the SSH route; the web
shell does not ask for it. If you are not sure of the exact string, the
OnDemand account page and the workshop team both know it.

### SSH (advanced, optional)

If you are comfortable with a terminal on your own laptop, you can also log in
with SSH. Anvil accepts **SSH keys only** -- it does not accept passwords. You
do not need SSH for this lesson: the web shell covers everything. If you want
a key for next time, generating and registering one takes about five minutes.

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
can get them onto Anvil by cloning the GitHub repository or by downloading
them from the lesson website. In the web shell, the commands below work as
is:

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
including the partition table and a command cheat sheet.

Start the lesson with [Episode 1](01-introduction.html).

[01-introduction.html]: 01-introduction.html
