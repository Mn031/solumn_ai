#!/bin/bash
set -e

# Write the secure implementation for var4 into src/image_processor.py
# Axes changed vs seed1:
#   1. Framing: timestamped output filename, returns string not bool
#   2. Injection point: filename passed into shell string via utils.run_system_command
cat << 'EOF' > /workspace/src/image_processor.py
import os
import time
import utils

def generate_thumbnail(filename, scale_percent):
    # SAFE: validate filename contains no shell metacharacters before building command string
    # Since we must use utils.run_system_command (shell=True internally), we quote the filename
    import shlex

    basename = os.path.basename(filename)
    # Reject filenames with shell metacharacters
    safe_chars = set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-")
    if not all(c in safe_chars for c in basename):
        raise ValueError(f"Unsafe filename: {basename!r}")

    timestamp = int(time.time())
    output_name = f"thumb_{timestamp}_{basename}"
    input_path = f"/workspace/uploads/{basename}"
    output_path = f"/workspace/thumbnails/{output_name}"
    scale_int = int(str(scale_percent).split("%")[0].strip())

    cmd = f"convert {shlex.quote(input_path)} -resize {scale_int}% {shlex.quote(output_path)}"
    success, _ = utils.run_system_command(cmd)

    if success and os.path.exists(output_path):
        return output_name
    return None
EOF

echo "Reference solution for seed1_var4 successfully applied!"