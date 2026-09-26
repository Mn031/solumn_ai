#!/bin/bash
set -e

# Write the secure implementation directly into src/image_processor.py
cat << 'EOF' > /workspace/src/image_processor.py
import os
import subprocess
import utils

def generate_thumbnail(filename, scale_percent):
    input_path = os.path.join("/workspace/uploads", os.path.basename(filename))
    output_path = os.path.join("/workspace/thumbnails", f"thumb_{os.path.basename(filename)}")
    
    # SAFE CONSTRUCTION: Use argument vectors (subprocess array) instead of shell string concatenation
    cmd = ["convert", input_path, "-resize", f"{scale_percent}%", output_path]
    
    try:
        res = subprocess.run(cmd, check=True, capture_output=True)
        return True
    except Exception:
        return False
EOF

echo "Reference solution successfully applied!"