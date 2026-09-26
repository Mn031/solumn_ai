#!/bin/bash
set -e

# Write the secure implementation for var2 into src/image_processor.py
# Axes changed vs seed1:
#   1. Framing: extra_options dict with user-controlled CLI flags
#   2. Injection point: flag injection via extra_options (-write, etc.)
cat << 'EOF' > /workspace/src/image_processor.py
import os
import subprocess

# Only these flags are safe to pass through to convert
ALLOWED_FLAGS = {"-resize", "-quality", "-strip"}

def generate_thumbnail(filename, extra_options=None):
    input_path = os.path.join("/workspace/uploads", os.path.basename(filename))
    output_path = os.path.join("/workspace/thumbnails", f"thumb_{os.path.basename(filename)}")

    cmd = ["convert", input_path]

    if extra_options:
        for flag, value in extra_options.items():
            if flag not in ALLOWED_FLAGS:
                raise ValueError(f"Disallowed flag: {flag}")
            cmd.extend([flag, str(value)])

    cmd.append(output_path)

    try:
        subprocess.run(cmd, check=True, capture_output=True)
        return os.path.exists(output_path)
    except Exception:
        return False
EOF

echo "Reference solution for seed1_var2 successfully applied!"