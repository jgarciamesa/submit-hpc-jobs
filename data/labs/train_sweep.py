# train_sweep.py — Scale lab: one script, many experiments (job arrays)
# Each array task trains the digits classifier with a different C value
# (the "hyperparameter sweep" pattern — the #1 real use of job arrays).

import json
import os
import sys

import numpy as np
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC

# SLURM_ARRAY_TASK_ID tells each task which experiment it is (0, 1, 2, ...)
task_id = int(os.environ.get("SLURM_ARRAY_TASK_ID", "0"))
c_values = [0.01, 0.1, 1.0, 10.0, 100.0]
C = c_values[task_id % len(c_values)]

digits = load_digits()
X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, test_size=0.2, random_state=42, stratify=digits.target
)
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

clf = SVC(kernel="rbf", C=C, gamma=0.001)
clf.fit(X_train, y_train)
acc = clf.score(X_test, y_test)

print(f"[array task {task_id}] C={C:<7} test accuracy = {acc:.3f}  host={os.environ.get('SLURMD_NODENAME','?')}")
with open(f"sweep_{task_id:02d}.json", "w") as f:
    json.dump({"task_id": task_id, "C": C, "accuracy": round(float(acc), 4)}, f)

sys.exit(0)
