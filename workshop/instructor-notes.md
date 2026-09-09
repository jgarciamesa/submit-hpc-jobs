# Instructor Notes --- Submitting AI Jobs to the Anvil Supercomputer
### Beginner Track 1 - AI for All - Sept 15 2026 - 1:00-2:30 PM CT

## Pre-session checklist (T-minus --- do these BEFORE the workshop)

**Accounts (the #1 success factor):**
- [ ] Every attendee has an ACCESS ID (access-ci.org) and it's added to the workshop allocation on Anvil --- confirm the allocation + user list with Preston Smith / RCAC (rcac-help@purdue.edu) at least 2 weeks out
- [ ] Confirm the account type: ACCESS credit transfer vs. NAIRR Pilot allocation (NAIRR = automatic on approval, no transfer step --- affects the "getting your own allocation" slide wording)
- [ ] SSH keys: attendees without keys use the **OnDemand browser path** (ondemand.anvil.rcac.purdue.edu -> set up SSH key from OnDemand) --- put this URL on slide 10 and in the handout; do NOT budget lab time for key generation
- [ ] Get the Anvil username format right in the handout: `x-<ACCESS username>` (not the ACCESS username itself)

**Lab staging:**
- [ ] Stage `labs/` on Anvil in a world-readable directory (e.g. `/anvil/projects/<workshop-project>/ai-workshop-submit-jobs`) and a short URL/QR code on slide 10 and 18
- [ ] On the Anvil login node, run and CAPTURE (screenshot for slides):
  - `showpartitions` --- verify `debug` and `gpu-debug` have idle capacity at 1 PM CT on a recent weekday (if `gpu-debug` idle is 0 at 1 PM historically, plan the front-of-room demo fallback)
  - `sfeatures` --- g[000-015] A100 / h[000-020] H100 node names
  - `module spider pytorch` --- **pin the exact PyTorch module or container for Lab 4** (train-gpu.sbatch has TODO comments at both lines; fill in the verified one)
  - `module load conda; python3 -c "import sklearn; print(sklearn.__version__)"` --- verify Lab 3's import works in the default conda module; if not, capture the venv/pip fallback commands
- [ ] Dry-run ALL FOUR labs on Anvil itself (submit each .sbatch, check outputs) --- this catches partition, account, and module problems while there's still time to fix them
- [ ] Verify the workshop allocation's `-A` account string exactly (`mybalance` on the login node) --- pre-fill it in the staged copies of the .sbatch files so attendees' first submission works without editing (leave `<ACCOUNT>` in the handout copies as a teaching moment)

**Room/logistics:**
- [ ] Projector + your own SSH session pre-logged-in and font-size bumped (16pt+)
- [ ] Wi-Fi for attendees; know the room's fallback if SSH is blocked (OnDemand browser path)
- [ ] Helper-to-attendee ratio ~1:10; brief helpers on the troubleshooting table in handout.md
- [ ] Attendees arrive at 1:00 from lunch --- start with the why (slides 2--3), not housekeeping

## Timing plan (90 min)

| Clock | Segment | Watch for |
|---|---|---|
| 1:00--1:15 | Framing, slides 1--9 | Don't overrun slide 4 (partition table) --- it's reference, not lecture |
| 1:15--1:27 | Lab 1: connect, mybalance, showpartitions | SSH-key people eat the budget --- route them to OnDemand immediately |
| 1:27--1:39 | Lab 2: first sbatch | Checkpoint: everyone's `slurm-*.out` exists. This is the never-cut lab |
| 1:39--1:57 | Lab 3: CPU AI job (digits) | If >5 min behind at start, convert to front-of-room demo + they submit-and-check-later |
| 1:57--2:12 | Lab 4: GPU job (PyTorch) | The wow moment (nvidia-smi shows A100). Protect 10 min for it |
| 2:12--2:15 | Stretch: job array | Only if on schedule; fast finishers only |
| 2:15--2:30 | Wrap-up, slides 15--18, Q&A | Getting-your-own-allocation slide is the #1 question --- have allocations.access-ci.org and nairrpilot.org ready |

## Fallbacks (decide thresholds BEFORE the session)

| Situation | Fallback |
|---|---|
| Attendee can't SSH (no key, blocked port) | OnDemand browser: ondemand.anvil.rcac.purdue.edu -> Clusters -> Shell access --- everything except the stretch lab works there |
| `debug` queue full at 1 PM | Scripts run unchanged on `shared` (the default partition) --- `-p debug` -> `-p shared`; say it once, everyone moves |
| `gpu-debug` saturated | Instructor demos Lab 4 from front; attendees submit and get a PENDING job + "check your output after the session" --- frame as the real HPC experience |
| sklearn/torch missing from default conda module | pip-in-venv fallback (capture the exact commands pre-session); or switch Lab 4 to the NGC container line (already in train-gpu.sbatch) |
| Running >10 min behind at 2:00 | Cut Lab 3's "try different cpus-per-task" extension and the stretch; NEVER cut Lab 2 or the allocation slide |

## Known pitfalls (from verified RCAC docs)

- **Missing `-A` account is the #1 first-submission error** ("failed to map user" / "invalid account specified") --- it's in the handout troubleshooting table and slide 8 says it twice.
- **Anvil username is not ACCESS username**: it's `x-<ACCESSname>`. The handout says this at the SSH step.
- **No partition specified -> `shared` (default)**: fine for Lab 3's script but say it explicitly --- people assume "no `-p` = no queue".
- **Password auth is rejected on Anvil** --- SSH keys or OnDemand only.
- **`gpu-debug` limits: 30 minutes, 2 GPUs, 1 running job per user** --- train-gpu.sbatch asks `-t 00:25:00` and `--gres=gpu:1` to stay safely inside.
- **`debug` limits: 2 nodes, 2 hrs, 1 running job per user** --- fine for all CPU labs; attendees who resubmit before their first finishes will sit PENDING (that's a teaching moment for `squeue`'s reason column, not an error).
- **Charging**: node-exclusive partitions (wholenode/wide) bill 128 cores even if you request 1 --- one slide-17 bullet, prevents confused `mybalance` questions later.
- **GRES on GPU nodes**: `sfeatures` shows `gpu:4` per g/h node --- request `--gres=gpu:1`, not "a GPU node" in the script name.

## Lab files map (what's in labs/)

| File | Lab | Verifies |
|---|---|---|
| hello.py + hello.sbatch | 2 | syntax-checked locally; runs on plain python3 |
| train_digits.py + train-digits-cpu.sbatch | 3 | **executed locally in a venv**: 0.989 test accuracy, metrics JSON written |
| train_gpu.py + train-gpu.sbatch | 4 | syntax-checked; requires torch + GPU node --- dry-run on Anvil pre-session (see checklist) |
| train_sweep.py + array.sbatch | stretch | **executed locally** with SLURM_ARRAY_TASK_ID=2: works, writes sweep_02.json |

## After the session

- Collect `sacct -j <jobid>` outputs from anyone whose GPU job didn't finish in time
- Share the lab repo URL + handout PDF with the closing session (4:20 PM) crowd
- Debrief with Preston Smith: gpu-debug capacity at session time, whether a dedicated workshop queue is possible next year
