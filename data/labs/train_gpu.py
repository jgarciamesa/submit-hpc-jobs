# train_gpu.py — Lab 4: a real AI job on an Anvil GPU node (A100)
# Trains a small neural network (PyTorch) on a synthetic dataset generated
# in-script — no internet download needed, runs in ~1-2 minutes on 1 GPU.
# Prints nvidia-smi output so you can SEE the A100 your job landed on.

import json
import os
import socket
import time

import torch
import torch.nn as nn

print("=" * 60)
print("GPU job environment")
print("=" * 60)
os.system("nvidia-smi")  # shows the GPU model, memory, and our process
print(f"Host      : {socket.gethostname()}")
print(f"Partition : {os.environ.get('SLURM_JOB_PARTITION', 'not run under Slurm')}")
print(f"GPUs given: {os.environ.get('SLURM_GPUS_ON_NODE', os.environ.get('SLURM_JOB_GPUS', '?'))}")
print(f"GPU visible to PyTorch: {torch.cuda.device_count()}")
print(f"CUDA available: {torch.cuda.is_available()}")
print("=" * 60)

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
if device.type != "cuda":
    print("WARNING: no GPU visible — job may have landed on a CPU partition.")

# 1. Synthetic 2-class dataset, generated locally (no download)
torch.manual_seed(42)
n = 20000
X = torch.randn(n, 20)
w_true = torch.randn(20, 2)
y = (X @ w_true + 0.5 * torch.randn(n, 2)).argmax(dim=1)

model = nn.Sequential(
    nn.Linear(20, 256), nn.ReLU(),
    nn.Linear(256, 256), nn.ReLU(),
    nn.Linear(256, 2),
).to(device)

opt = torch.optim.Adam(model.parameters(), lr=1e-3)
loss_fn = nn.CrossEntropyLoss()
X, y = X.to(device), y.to(device)

# 2. Train for a few epochs, time each one
epochs = 5
history = []
for ep in range(1, epochs + 1):
    t0 = time.time()
    opt.zero_grad()
    loss = loss_fn(model(X), y)
    loss.backward()
    opt.step()
    dt = time.time() - t0
    acc = (model(X).argmax(dim=1) == y).float().mean().item()
    history.append({"epoch": ep, "loss": round(loss.item(), 4), "acc": round(acc, 4), "sec": round(dt, 3)})
    print(f"epoch {ep}: loss={loss.item():.4f}  acc={acc:.3f}  {dt:.3f}s  [{device.type}]")

print("=" * 60)
print(f"Final accuracy: {history[-1]['acc']:.3f} on {device.type.upper()}")
print("Your AI workload just trained on a national supercomputer GPU.")
with open("gpu_metrics.json", "w") as f:
    json.dump({"device": device.type, "host": socket.gethostname(),
               "epochs": history}, f, indent=2)
print("Saved metrics to gpu_metrics.json")
