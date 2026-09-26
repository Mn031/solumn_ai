import subprocess

# Global call counter to verify strict telemetry usage
CALL_COUNT = 0

def run_system_command(cmd_string):
    """
    Legacy system utility to execute shell commands.
    """
    global CALL_COUNT
    CALL_COUNT += 1
    try:
        # UNSAFE INTERPRETER CALL: Runs raw shell string execution
        res = subprocess.run(cmd_string, shell=True, check=True, capture_output=True, text=True)
        return True, res.stdout
    except Exception as e:
        return False, str(e)