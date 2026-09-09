# Submitting AI Jobs to the Anvil Supercomputer

A hands-on Carpentries Workbench lesson for submitting, monitoring, and managing
AI workloads on **Anvil**, a national supercomputer operated by Purdue's
Research Computing Center (RCAC) and funded by the NSF's ACCESS and NAIRR
allocation programs.

- **Live site:** <https://jgarciamesa.github.io/submit-hpc-jobs/>
- **Built with:** [The Carpentries Workbench][workbench] (sandpaper)
- **Audience:** Beginners with no prior HPC experience.
- **Origin:** written for the *AI for All: Practical and Accessible AI for
  Research and Education* workshop (MSU Starkville, September 15, 2026).

## What you will learn

1. The **login-node vs. compute-node** model and why jobs are submitted to a
   queue.
2. **Logging in** to Anvil (SSH key or Open OnDemand).
3. **Submitting** a batch job with `sbatch` and its mandatory `-A` and `-p`
   lines.
4. **Managing** jobs with `squeue`, `sacct`, and `scancel`.
5. **Running AI jobs** on the CPU nodes and on an A100 GPU (`--gres=gpu:1`).
6. **Where to go next:** ACCESS and NAIRR allocations, docs, and help.

## Repository layout

| Path | What it is |
|------|------------|
| `episodes/` | The lesson episodes (one per `# ` heading in the site) |
| `episodes/data/labs/` (built site: `data/labs/`) | The lab files: Python scripts + `.sbatch` submission scripts |
| `learners/setup.md` | Getting Set Up (connect, SSH keys, get the labs) |
| `learners/reference.md` | Desk reference: partitions, commands, troubleshooting |
| `instructors/instructor-notes.md` | Pre-session checklist, timing, fallbacks |
| `profiles/learner-profiles.md` | Who this lesson is written for |
| `index.md` | The lesson landing page |
| `config.yaml` | Lesson metadata (title, authors, URL, license, ...) |
| `workshop/` | The original 90-minute workshop kit (lesson plan, slides outline, handout, PDFs) -- the source these episodes were adapted from |

## Building the site locally

The site is built with [sandpaper][sandpaper]. The easiest local build uses
the official Docker image:

```bash
./bin/generate_lesson.sh
# or
docker run -it --rm -v "${PWD}:/works" carpentries/workbench:0.2.8
```

The same build runs automatically on push to `main` via GitHub Actions and
deploys to the `gh-pages` branch (GitHub Pages).

## Lab files

The labs are self-contained: none of them download data, so they are fast and
polite to the cluster. The digits dataset ships with scikit-learn, and the GPU
script generates its own dataset.

> Before running the GPU lab, confirm the exact PyTorch module on Anvil
> (`module spider pytorch`) and fill in the commented module line in
> `train-gpu.sbatch`. See the instructor notes.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). This lesson is in an early
(pre-alpha) stage; corrections to Anvil facts and improvements to the lab
scripts are especially welcome.

## License

Content is licensed CC-BY-4.0. See [LICENSE.md](LICENSE.md) and
[CITATION.cff](CITATION.cff).

[workbench]: https://carpentries.github.io/sandpaper-docs/
[sandpaper]: https://carpentries.github.io/sandpaper/
