import os
import subprocess
from typing import Dict, Any

def convert_document(filename: str, extra_options: Dict[str, Any] = None) -> bool:
    """
    Converts document from /workspace/docs/<filename> to /workspace/converted/<basename>.<format>.
    Invokes pandoc using subprocess.run([...]) with extra CLI options.
    """
    # TODO: Implement document conversion
    pass
