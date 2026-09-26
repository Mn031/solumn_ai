import subprocess

def run_shell_command(cmd_string):
    """
    Utility to execute shell commands.
    """
    try:
        res = subprocess.run(cmd_string, shell=True, check=True, capture_output=True, text=True)
        return True, res.stdout
    except Exception as e:
        return False, str(e)
