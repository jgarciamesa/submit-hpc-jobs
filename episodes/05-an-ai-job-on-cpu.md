---
title: "A Real AI Job on the CPU Nodes"
teaching: 10 # teaching time in minutes
exercises: 18 # exercise time in minutes
questions:
- How do you run a Python machine-learning job on Anvil's CPU nodes?
- How do you ask for more cores and more memory?
objectives:
- Submit a scikit-learn training job on the CPU nodes.
- Request more cores and memory with `--cpus-per-task` and `--mem`.
- Read the job's output and the metrics file it writes.
---

# Train a digit classifier

This is the first *real* AI job: a small machine-learning program that trains a
classifier on 1,797 images of handwritten digits and reports test accuracy. It
uses [scikit-learn][sklearn], which is already part of the `conda` module on
Anvil, and the digit dataset ships with the library -- **nothing is
downloaded**, so the job is fast and polite to the cluster.

The program, `train_digits.py`, does five things:

1. Loads the built-in digits dataset.
2. Splits it 80/20 into training and test sets.
3. Scales the features.
4. Trains a support-vector machine.
5. Prints test accuracy and writes a `digits_metrics.json` file.

Its job script, `train-digits-cpu.sbatch`, asks for more than the `hello` job
did:

```bash
#!/bin/sh -l
#SBATCH -A <ACCOUNT>            # MANDATORY: your allocation account
#SBATCH -p debug
#SBATCH --job-name=digits-cpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16      # ask for 16 cores
#SBATCH --mem=16G               # ask for 16 GB of memory
#SBATCH -t 00:30:00
#SBATCH -o digits-cpu_%j.out    # name the output file ourselves

module load conda
cd $SLURM_SUBMIT_DIR
python3 train_digits.py
```

`%j` in the output filename is replaced by the job ID, so each submission gets
its own `digits-cpu_<jobid>.out`.

# Submit and read the result

```bash
sbatch train-digits-cpu.sbatch
squeue -u $USER                  # watch it run (about a minute on 16 cores)
cat digits-cpu_123456.out        # test accuracy ~ 0.98
cat digits_metrics.json          # the machine-readable results
```

When it finishes, the output ends with a line like:

```output
Test accuracy: 0.980
```

and `digits_metrics.json` holds the accuracy, the node, the partition, and the
elapsed time. You have now trained and evaluated a model on a supercomputer.
::::::::::::::::::::::::::::::::::::: callout

## What did this cost?

Run `mybalance` before and after the job. The difference is the number of
Service Units (SU) the run consumed. This is exactly how a national allocation
is spent, one job at a time. Ask for 16 cores and the job costs more than the
same job on two cores -- resources are not free.

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: challenge 

## Try a different core count

Change `--cpus-per-task=16` to `8` in `train-digits-cpu.sbatch`, resubmit,
and compare the elapsed time in the two output files. What changed, and why
might fewer cores be *faster* here?
:::::::::::::::::::::::: solution 

## Fewer cores can be faster

This particular model does not parallelize cleanly, so adding cores does not
speed it up and can add overhead. The lesson is not "more is always better" --
it is that you choose resources to fit the workload. A production job that does
parallelize (an MPI code, a large data-parallel run) would scale with cores
instead.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

If you are running more than five minutes behind schedule at the start
of this episode, convert it to a front-of-room demo: you submit and walk the
output, attendees submit on their own and check the result after. Never cut the
previous episode (your first job) or the final allocation discussion.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints

- A CPU AI job is just a Python program run under `sbatch`; load `conda` in the script for scikit-learn and numpy.
- Ask for more cores with `--cpus-per-task` and more memory with `--mem`.
- Name the output file with `%j` (job ID) so repeated submissions do not overwrite each other.

::::::::::::::::::::::::::::::::::::::::::::::::

