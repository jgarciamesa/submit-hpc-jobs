---
title: "Scale: One Script, Many Experiments (Job Arrays)"
teaching: 5 # teaching time in minutes
exercises: 10 # exercise time in minutes
---

# A hyperparameter sweep in one command

:::::::::::::::::::::::::::::::::::::: questions 

- How do you run the same experiment with many settings in one submission?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Submit a Slurm job array and read each task's output separately.

::::::::::::::::::::::::::::::::::::::::::::::::


Real research rarely runs one setting. You sweep a hyperparameter -- a learning
rate, a regularization strength -- and compare. A **job array** is how you do
that in one submission: one script, many near-identical jobs.

The sweep script, `train_sweep.py`, trains the digits classifier with a
different `C` value per array task:

```python
task_id = int(os.environ.get("SLURM_ARRAY_TASK_ID", "0"))
c_values = [0.01, 0.1, 1.0, 10.0, 100.0]
C = c_values[task_id % len(c_values)]
```

`SLURM_ARRAY_TASK_ID` tells each task which experiment it is (0, 1, 2, 3, 4).
Its script, `array.sbatch`, writes one output file per task:

```bash
#!/bin/sh -l
#SBATCH -A cis261672-gpu        # MANDATORY on Anvil: workshop GPU allocation (confirm with `mybalance`)
#SBATCH -p gpu-debug             # 1 running job per user: the 5 array tasks run in turn
#SBATCH --job-name=ai-sweep
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --gres=gpu:1            # jobs on gpu/gpu-debug must ask for a GPU
#SBATCH -t 00:20:00
#SBATCH -o slurm-array_%A_%a.out   # %A = job ID, %a = array task ID
#SBATCH -e slurm-array_%A_%a.err   # one error file per task, to match

module load conda
cd $SLURM_SUBMIT_DIR
python3 train_sweep.py
```

Submit the whole sweep with the `--array` flag:

```bash
sbatch --array=0-4 array.sbatch
ls slurm-array_*_*.out            # one output file per task
```

`gpu-debug` allows one running job per user, so the five tasks usually run in turn -- you can watch them appear one by one in `squeue`. Each task runs the same script with a different `C` and writes its own `sweep_<task>.json`. One command gives you five experiments and five results to compare -- the same pattern you will use for your own sweeps. When a sweep grows beyond 30 minutes per task, the same script works on `-p gpu` with a longer time limit.

::::::::::::::::::::::::::::::::::::: challenge 

## How do I tell which result came from which setting?

Five `sweep_*.json` files land in your directory. How do you match each
result to the `C` value that produced it?

:::::::::::::::::::::::: solution 

## Read the task ID

Each file is named `sweep_<task>.json`, where `<task>` is the array task ID
(00-04), and the file itself records the `C` it used. So `sweep_02.json` is
task 2, which trained with `C=1.0`. Open one to confirm, then compare the
accuracies across the five `C` values to see which setting worked best.

:::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints

- A job array runs the same script many times in one submission; `--array=0-4` creates five tasks.
- `SLURM_ARRAY_TASK_ID` tells each task which experiment it is.
- Name output files with `%A` (job ID) and `%a` (task ID) so each task writes its own file.

::::::::::::::::::::::::::::::::::::::::::::::::

