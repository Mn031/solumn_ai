#!/bin/bash
set -e

# Write the secure reference implementation into src/doc_processor.py
cat << 'EOF' > /workspace/src/doc_processor.py
import os
import subprocess
from typing import Dict, Any

ALLOWED_FLAGS = {"standalone", "toc", "number-sections", "table-of-contents", "wrap"}

def convert_document(filename: str, extra_options: Dict[str, Any] = None) -> bool:
    try:
        if extra_options is None:
            extra_options = {}

        safe_filename = os.path.basename(filename.strip())
        input_path = os.path.join("/workspace/docs", safe_filename)
        if not os.path.exists(input_path):
            return False

        base_name = os.path.splitext(safe_filename)[0]
        fmt = str(extra_options.get("format", "html")).strip()
        if not fmt.isalnum():
            return False

        output_path = os.path.join("/workspace/converted", f"{base_name}.{fmt}")
        os.makedirs("/workspace/converted", exist_ok=True)

        cmd = ["pandoc", input_path, "-o", output_path]

        # Filter and validate extra options against an allowlist to prevent argument/flag injection
        for k, v in extra_options.items():
            if k == "format":
                continue
            clean_k = str(k).lstrip("-").strip()
            if clean_k not in ALLOWED_FLAGS:
                continue
            if isinstance(v, bool):
                if v:
                    cmd.append(f"--{clean_k}")
            else:
                cmd.extend([f"--{clean_k}", str(v)])

        res = subprocess.run(cmd, capture_output=True, check=True)
        return os.path.exists(output_path)
    except Exception:
        return False
EOF

echo "Reference solution for seed1_var2 applied successfully!"
