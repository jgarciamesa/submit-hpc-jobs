# Learner Profiles

The learners below represent the range of experience this lesson was designed
for. Each profile states what the learner already knows, what they want to
achieve, and which parts of the lesson they are most likely to lean on.

## Dr. Amara Osei

**Who:** A plant-pathology researcher at a Mississippi public university.
Comfortable at a command line (she runs R and Python for data analysis) but new
to shared, multi-user systems.

**Wants to:** Submit her own model-training jobs to Anvil on a fair, repeatable
process -- and understand how the queue works so she is not surprised when a
job waits.

**Leans on:** The [login-node vs. compute-node model][01-introduction], the
[queue/partition table][03-meeting-anvils-queues], and the
[job-management commands][04-your-first-job]. She will find the "debug queue is
full" challenge familiar and useful.

## Marcus Bell

**Who:** A third-year computer-science PhD student. Writes a lot of Python and
has trained models on a laptop GPU. Has *heard* of Slurm but has never driven
it.

**Wants to:** Move his PyTorch training onto a real A100, and learn how to fan a
hyperparameter sweep out across many jobs.

**Leans on:** The [GPU episode][06-an-ai-job-on-a-gpu] and the
[job-arrays stretch][07-job-arrays]. For him, `--gres=gpu:1` and
`SLURM_ARRAY_TASK_ID` are the two lines worth memorising.

## Priya Raman

**Who:** A university administrator supporting a grant that just funded
access to national AI resources. Minimal technical background; she is here to
understand what her team is asking for and what "an allocation" actually is.

**Wants to:** Understand the login and submission flow well enough to talk to
her researchers, and know exactly where to direct them for help.

**Leans on:** The [setup page](index.html), the [wrap-up episode][08-wrap-up]
(access paths, rules of the road, where to get help), and the
[reference page](reference.html) as a desk reference she can keep.

## Dr. Lena Fischer

**Who:** A bioinformatician who has run jobs on a smaller campus cluster. Knows
Slurm basics but has never used Anvil specifically.

**Wants to:** Get up to speed on Anvil's particular quirks -- the account-string
format, `mybalance`, the debug partitions -- quickly, without re-learning the
whole model.

**Leans on:** The [connecting episode][02-connecting-to-anvil] and the
[Anvil-specific differences] called out in the reference page (account string,
`showpartitions`, debug queues). The "if you know Slurm, you know Anvil" note
in the [wrap-up][08-wrap-up] is written for her.

[01-introduction]: 01-introduction.html
[03-meeting-anvils-queues]: 03-meeting-anvils-queues.html
[04-your-first-job]: 04-your-first-job.html
[06-an-ai-job-on-a-gpu]: 06-an-ai-job-on-a-gpu.html
[07-job-arrays]: 07-job-arrays.html
[08-wrap-up]: 08-wrap-up.html
[02-connecting-to-anvil]: 02-connecting-to-anvil.html
[Anvil-specific differences]: reference.html
