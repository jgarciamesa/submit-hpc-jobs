---
title: "Connecting to Anvil"
teaching: 10 # teaching time in minutes
exercises: 12 # exercise time in minutes
---

# Get a shell on Anvil

:::::::::::::::::::::::::::::::::::::: questions 

- How do you log in to Anvil?
- How do you find the account string you will need to submit jobs?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Log in to Anvil through Open OnDemand's web shell (or with SSH, if you already have a key set up).
- Read your allocation account and the list of available queues.

::::::::::::::::::::::::::::::::::::::::::::::::


## The web shell (recommended)

Log in to [Open OnDemand][ondemand] with your ACCESS credentials, then open
*Clusters - Shell access*. A terminal opens in your browser -- no software to
install -- and everything in this lesson runs in it.

## SSH (advanced, optional)

If you already have an SSH key registered on Anvil, you can log in from your
own laptop's terminal instead:

```bash
ssh <your-anvil-username>@anvil.rcac.purdue.edu
```

Two things to pay attention to:

- Your **Anvil username is not your ACCESS username**. It is derived from it
  and starts with `x-`. For example, if your ACCESS name is `jdoe`, your Anvil
  name is something like `x-jdoe`.
- Anvil does **not** accept passwords. Only SSH keys. If you do not have a key
  yet, use the web shell above -- do not spend lab time generating one.

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

If someone's `ssh` says `failed to map user <you>@access-ci.org`, their
allocation is not attached to Anvil yet. Have them continue in the web shell
and flag them for the "getting your own allocation" episode. Do not let the
group wait on one connection problem.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# A quick word about the shell

The terminal you just opened -- the web shell or an SSH session -- is running
a program called a **shell** (sometimes called a terminal or command line).
The shell is the text-based window between you and the operating system: you
type a command and press Return, and the shell runs it and shows you the
output. Anvil's shell is the same tool you would use in a terminal on your
own laptop, and every command in this lesson is one you would type there.

If you have never used a shell, no worries -- this lesson covers everything
you need. If you would like to go deeper,
[The Unix Shell](https://swcarpentry.github.io/shell-novice/) is a free,
self-paced lesson from The Carpentries, a non-profit organization that
teaches computational skills worldwide, and it makes a great follow-up.


# Look around: your account and the queues

Once you are logged in, three commands tell you everything you need to know to
submit your first job. Run each one and keep the output handy:

```bash
mybalance        # your allocation account string -- this becomes the -A value
showpartitions   # every queue, with free cores and time limits
sfeatures        # the node types: a* CPU, g* A100, h* H100
```

`mybalance` prints one or more account names. **That account string is the
`-A <account>` value every job script will need.** Anvil is strict about it:
submit a job without the right account and it is rejected.

For this workshop the team attached the shared allocation
`cis261672-gpu` to every account, so that is the string `mybalance` will
print -- and it is the `-A` value in every lab script in this lesson.

`showpartitions` and `sfeatures` show you the queues and the machines behind
them. You do not need to memorize this now -- the next episode walks through
the tables. Just notice that the `g` nodes are A100s and the `h` nodes are H100s.

::::::::::::::::::::::::::::::::::::: challenge

## Can you find your account?

Run `mybalance` in your terminal. It should print `cis261672-gpu` -- the
workshop allocation. That is the `-A` value in every job script in this lesson.

:::::::::::::::::::::::: solution

## Your account string

It should be `cis261672-gpu`, the workshop allocation the team attached to
your account. Copy it exactly -- a missing dash or capital letter is the most
common first-submission mistake. If `mybalance` prints nothing, your account is
not attached to the allocation yet; ask an instructor.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints

- Open a shell through Open OnDemand (*Clusters - Shell access*); SSH is the advanced alternative.
- Your Anvil username starts with `x-` and is not your ACCESS username (needed only for SSH).
- `mybalance` prints the account string you pass with `-A` in every job script (here: `cis261672-gpu`).

::::::::::::::::::::::::::::::::::::::::::::::::

