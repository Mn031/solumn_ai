import subprocess

# Global call counter to verify strict helper usage
CALL_COUNT = 0

def run_system_command(cmd_string):
    """Legacy system utility for telemetry logging."""
    global CALL_COUNT
    CALL_COUNT += 1
    try:
        res = subprocess.run(cmd_string, shell=True, check=True, capture_output=True, text=True)
        return True, res.stdout
    except Exception as e:
        return False, str(e)
