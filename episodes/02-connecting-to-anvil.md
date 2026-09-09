---
title: "Connecting to Anvil"
teaching: 10 # teaching time in minutes
exercises: 12 # exercise time in minutes
questions:
- How do you log in to Anvil?
- How do you find the account string you will need to submit jobs?
objectives:
- Log in to Anvil using an SSH key, or through Open OnDemand in a browser.
- Read your allocation account and the list of available queues.
---

# Log in with SSH

If you have set up an SSH key, you can log in straight from your laptop's
terminal:

```bash
ssh <your-anvil-username>@anvil.rcac.purdue.edu
```

Two things trip people up at this step, so check both before you move on:

- Your **Anvil username is not your ACCESS username**. It is derived from it and
  starts with `x-`. For example, if your ACCESS name is `jdoe`, your Anvil name
  is something like `x-jdoe`.
- Anvil does **not** accept passwords. Only SSH keys. If you do not have a key
  yet, use the browser path below -- do not spend lab time generating one.

::::::::::::::::::::::::::::::::::::: callout

## No SSH key? Use the browser.

Log in to [Open OnDemand][ondemand], then open *Clusters - Shell access*.
Everything in this lesson works in that web terminal too, and from OnDemand you
can also register an SSH key for next time.

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

If someone's `ssh` says `failed to map user <you>@access-ci.org`, their
allocation is not attached to Anvil yet. Route them to the browser path and flag
them for the "getting your own allocation" episode. Do not let the group wait on
one connection problem.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


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

`showpartitions` and `sfeatures` show you the queues and the machines behind
them. You do not need to memorize this now -- the next episode walks through
the table. Just notice that the `g` nodes are A100s and the `h` nodes are H100s.

::::::::::::::::::::::::::::::::::::: challenge 

## Can you find your account?

Run `mybalance` in your terminal. What is the account string it prints?
You will paste this into every job script in this lesson.

:::::::::::::::::::::::: solution 

## Your account string

It is the name that starts with your project, for example
`ACCESS-2026-ai-for-all` (the exact string varies per allocation). Copy it
exactly -- a missing dash or capital letter is the most common
first-submission mistake. If `mybalance` prints nothing, your allocation is not
attached yet; ask an instructor.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints

- Log in with `ssh <x-username>@anvil.rcac.purdue.edu`, or use Open OnDemand's web shell if you have no SSH key.
- Your Anvil username starts with `x-` and is not your ACCESS username.
- `mybalance` prints the account string you will pass with `-A` in every job script.

::::::::::::::::::::::::::::::::::::::::::::::::

