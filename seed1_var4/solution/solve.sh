#!/bin/bash
set -e

# Write the secure reference implementation into src/video_processor.py
cat << 'EOF' > /workspace/src/video_processor.py
import os
import subprocess

def extract_frame(video_filename: str, timestamp_sec: int, output_filename: str = None) -> bool:
    try:
        safe_video = os.path.basename(str(video_filename).strip())
        input_path = os.path.join("/workspace/videos", safe_video)
        if not os.path.exists(input_path):
            return False

        # Validate numeric timestamp
        try:
            ts = float(timestamp_sec)
        except (ValueError, TypeError):
            return False

        if output_filename is None:
            safe_output = f"frame_{int(ts)}.png"
        else:
            safe_output = os.path.basename(str(output_filename).strip())

        output_path = os.path.join("/workspace/frames", safe_output)
        os.makedirs("/workspace/frames", exist_ok=True)

        # SAFE: Use explicit subprocess argument list array
        cmd = [
            "ffmpeg",
            "-y",
            "-ss",
            str(ts),
            "-i",
            input_path,
            "-frames:v",
            "1",
            output_path,
        ]

        res = subprocess.run(cmd, capture_output=True, check=True)
        return os.path.exists(output_path)
    except Exception:
        return False
EOF

echo "Reference solution for seed1_var4 applied successfully!"
