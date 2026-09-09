# Slides Outline --- Submitting AI Jobs to the Anvil Supercomputer
~18 slides for the 15-min framing + live-demo anchors + 15-min wrap-up. Build in whichever deck tool you prefer; each slide below is one screen of content.

**Framing (1:00--1:15 PM)**

| # | Slide title | Content bullets | Anchor |
|---|---|---|---|
| 1 | Title | "Submitting AI Jobs to the Anvil Supercomputer" ; AI for All, Beginner Track 1 ; Sept 15 2026 ; your name/affiliation (ASU RTO) | --- |
| 2 | Who this is for | No HPC experience needed ; laptop + SSH/browser ; by 2:30 you'll have run a job on a national supercomputer | set expectations |
| 3 | Why a supercomputer for AI? | Your laptop vs. an A100/H100 ; training/inference scale ; connects to this morning's "Leveraging National Level AI and HPC Resources" talk | bridge from morning |
| 4 | Meet Anvil | Purdue ; NSF-funded ACCESS resource ; 1,000+ nodes ; 128 cores/node AMD EPYC ; 16x A100 nodes, 21x H100 nodes ; 5.3 PF | verified specs |
| 5 | Why queues? | Shared machine, fair share ; login node is not compute node ; running on the login node is against Anvil policy | say twice |
| 6 | Slurm in one slide | sbatch / squeue / scancel / sacct ; job = a shell script + a resource request ; the batch model: submit -> queue -> run -> output file | --- |
| 7 | Anvil's queues (partitions) | Table: debug / gpu-debug / shared / wholenode / wide / highmem / gpu / ai with limits ; debug queues are free-ish and short = perfect for a class | `showpartitions` demo screenshot |
| 8 | Anatomy of a job script | Annotated hello.sbatch (the actual lab file) ; **the two mandatory lines: `-A` account, `-p` partition** ; resource lines: nodes, tasks, cpus, mem, time, gres | --- |
| 9 | Today's roadmap | Lab 1 connect -> Lab 2 first job -> Lab 3 real AI job (CPU) -> Lab 4 GPU job -> stretch: job arrays | checkpoints marked |

**Live-demo anchors during labs (instructor screen)**

| # | Slide title | Content bullets | Anchor |
|---|---|---|---|
| 10 | Lab 1 --- Connect & look around | ssh command ; OnDemand browser fallback URL ; mybalance / showpartitions / sfeatures output (screenshot from pre-session run) | live typing |
| 11 | Lab 2 --- Your first job | sbatch -> job ID -> squeue -> cat output file ; highlight SLURM_JOB_NODELIST: it ran on a different machine | live typing |
| 12 | Lab 3 --- A real AI job | train_digits.py idea (no download) ; cpus-per-task=16 ; reading digits_metrics.json ; "what did this cost in SUs?" | live typing |
| 13 | Lab 4 --- Your first GPU job | --gres=gpu:1 ; gpu-debug partition (30 min, 2 GPUs) ; nvidia-smi in the output = the wow moment ; NGC containers mention | live typing |
| 14 | Stretch --- Job arrays | --array=0-4 ; SLURM_ARRAY_TASK_ID ; one script, five experiments | if time |

**Wrap-up (2:15--2:30 PM)**

| # | Slide title | Content bullets | Anchor |
|---|---|---|---|
| 15 | What you did today | connected; submitted; monitored; trained on CPU; trained on an A100 | checklist |
| 16 | Getting your own allocation | ACCESS credits -> transfer to Anvil (allocations.access-ci.org) ; NAIRR Pilot: allocation automatic on award (nairrpilot.org) ; ask your institution's research computing office | next steps |
| 17 | Rules of the road | Login-node etiquette ; debug queues for tests ; charge factors (highmem 4x; wholenode bills 128 cores even if you use 1) ; where to get help (rcac-help@purdue.edu, docs) | --- |
| 18 | Q&A + QR code | QR -> lab files + docs link ; stay through the break --- Beginner Track 2 (API to a model) starts 2:45 | close |
