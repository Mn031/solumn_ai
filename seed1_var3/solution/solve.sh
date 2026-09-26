#!/bin/bash
set -e

# Write the secure reference implementation into src/archiver.py
cat << 'EOF' > /workspace/src/archiver.py
import glob
import os
import subprocess

def archive_logs(log_pattern: str, archive_name: str) -> bool:
    try:
        # Strictly reject shell metacharacters
        forbidden_chars = [';', '&', '|', '`', '$', '(', ')', '<', '>', '\n', '\r', '#']
        if any(c in str(log_pattern) or c in str(archive_name) for c in forbidden_chars):
            return False

        safe_archive = str(archive_name).strip()
        if not safe_archive.endswith(".tar.gz"):
            safe_archive = f"{safe_archive}.tar.gz"
        safe_archive_name = os.path.basename(safe_archive)
        out_path = os.path.join("/workspace/archives", safe_archive_name)
        os.makedirs("/workspace/archives", exist_ok=True)

        pattern = str(log_pattern).strip()
        matches = glob.glob(pattern)
        if not matches:
            clean_rel = pattern.lstrip("/")
            if clean_rel.startswith("workspace/logs/"):
                clean_rel = clean_rel[len("workspace/logs/"):]
            elif clean_rel.startswith("logs/"):
                clean_rel = clean_rel[len("logs/"):]
            target = os.path.join("/workspace/logs", clean_rel)
            matches = glob.glob(target)
            if not matches and os.path.exists(target):
                matches = [target]

        if not matches:
            return False

        cmd = ["tar", "-czf", out_path] + matches
        res = subprocess.run(cmd, capture_output=True, check=True)
        return os.path.exists(out_path)
    except Exception:
        return False
EOF

echo "Reference solution for seed1_var3 applied successfully!"
