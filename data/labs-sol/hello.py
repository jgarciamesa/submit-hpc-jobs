# hello.py - Lab 1: first job on Sol
# Prints a greeting plus the Slurm environment the job ran in,
# so you can SEE that this ran on a compute node, not the login node.

import os
import socket

print("Hello from Sol!")
print(f"  Hostname : {socket.gethostname()}")
print(f"  Job ID   : {os.environ.get('SLURM_JOB_ID', 'not run under Slurm')}")
print(f"  Partition: {os.environ.get('SLURM_JOB_PARTITION', 'not run under Slurm')}")
print(f"  Node list: {os.environ.get('SLURM_JOB_NODELIST', 'not run under Slurm')}")
print(f"  CPUs     : {os.environ.get('SLURM_CPUS_PER_TASK', '?')}")
print(f"  Submit dir: {os.environ.get('SLURM_SUBMIT_DIR', os.getcwd())}")
print()
print("If you can see this in slurm.<jobid>.out, your first HPC job worked.")
