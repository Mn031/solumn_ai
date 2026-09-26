#!/bin/bash
set -e

# Write the secure reference implementation into src/audio_processor.py
cat << 'EOF' > /workspace/src/audio_processor.py
import os
import shlex
import subprocess
from utils import run_system_command

def transcode_audio(input_file: str, codec: str, bitrate: str = "128k") -> bool:
    try:
        # Strictly sanitize inputs against shell metacharacters
        forbidden_chars = [';', '&', '|', '`', '$', '(', ')', '<', '>', '\n', '\r']
        if any(c in str(input_file) or c in str(codec) or c in str(bitrate) for c in forbidden_chars):
            return False

        safe_input_name = os.path.basename(input_file.strip())
        input_path = os.path.join("/workspace/audios", safe_input_name)
        if not os.path.exists(input_path):
            return False

        base_name = os.path.splitext(safe_input_name)[0]
        safe_codec = os.path.basename(codec.strip())
        output_path = os.path.join("/workspace/transcoded", f"{base_name}.{safe_codec}")
        os.makedirs("/workspace/transcoded", exist_ok=True)

        # Quoting arguments safely for the legacy wrapper
        cmd = f"ffmpeg -y -i {shlex.quote(input_path)} -c:a {shlex.quote(safe_codec)} -b:a {shlex.quote(bitrate)} {shlex.quote(output_path)}"
        success = run_system_command(cmd)
        return bool(success and os.path.exists(output_path))
    except Exception:
        return False
EOF

echo "Reference solution for seed1_var1 applied successfully!"
