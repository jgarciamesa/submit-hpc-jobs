# train_digits.py — Lab 3: a real (small) AI job on Anvil
# Trains a digits classifier with scikit-learn (ships with Anaconda's
# `conda` module on Anvil — no internet download needed).
# Prints test accuracy and writes metrics to digits_metrics.json.

import json
import os
import socket
import time

from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC

t0 = time.time()

# 1. Load the built-in digits dataset (1,797 8x8 images of handwritten digits)
digits = load_digits()
X, y = digits.data, digits.target

# 2. Split: 80% train / 20% test
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

# 3. Scale features (good ML hygiene, and it changes SVM results a lot)
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# 4. Train a support-vector classifier
clf = SVC(kernel="rbf", C=10.0, gamma=0.001)
clf.fit(X_train, y_train)

# 5. Evaluate
accuracy = clf.score(X_test, y_test)
elapsed = time.time() - t0

print("=" * 60)
print("Digits classifier — results")
print("=" * 60)
print(f"Host        : {socket.gethostname()}")
print(f"Partition   : {os.environ.get('SLURM_JOB_PARTITION', 'not run under Slurm')}")
print(f"CPUs per task: {os.environ.get('SLURM_CPUS_PER_TASK', '?')}")
print(f"Samples     : {len(X)} images (train {len(X_train)} / test {len(X_test)})")
print(f"Test accuracy: {accuracy:.3f}")
print(f"Elapsed     : {elapsed:.2f} s")
print("=" * 60)
print("You just trained and evaluated an AI model on a supercomputer.")

# 6. Save metrics — this is the file you fetch after the job finishes
metrics = {
    "host": socket.gethostname(),
    "partition": os.environ.get("SLURM_JOB_PARTITION"),
    "job_id": os.environ.get("SLURM_JOB_ID"),
    "n_samples": int(len(X)),
    "test_accuracy": round(float(accuracy), 4),
    "elapsed_seconds": round(elapsed, 2),
}
with open("digits_metrics.json", "w") as f:
    json.dump(metrics, f, indent=2)
print("Saved metrics to digits_metrics.json")
