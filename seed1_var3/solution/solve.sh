#!/bin/bash
set -e

# Write the secure implementation for var3 into src/image_processor.py
# Axes changed vs seed1:
#   1. Framing: user-supplied filename with path traversal prevention requirement
#   2. Injection point: filename containing ../ path traversal + semicolons
cat << 'EOF' > /workspace/src/image_processor.py
import os
import subprocess

def generate_thumbnail(filename, scale_percent):
    # SAFE: reject path traversal components before building paths
    if ".." in filename or filename.startswith("/"):
        raise ValueError(f"Invalid filename: {filename!r}")

    basename = os.path.basename(filename)
    input_path = os.path.join("/workspace/uploads", basename)
    output_path = os.path.join("/workspace/thumbnails", f"thumb_{basename}")

    # SAFE: argument list, no shell=True
    cmd = ["convert", input_path, "-resize", f"{int(scale_percent)}%", output_path]

    try:
        subprocess.run(cmd, check=True, capture_output=True)
        return os.path.exists(output_path)
    except Exception:
        return False
EOF

echo "Reference solution for seed1_var3 successfully applied!"