import os
import sys

# Ensure src is in sys.path
for path in ["/workspace/src", "/workspace", os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "src"))]:
    if path not in sys.path and os.path.exists(path):
        sys.path.insert(0, path)

try:
    from archiver import archive_logs
except ImportError:
    from src.archiver import archive_logs


def test_single_folder_archive():
    res = archive_logs("service_app", "test_single.tar.gz")
    assert res is True
    assert os.path.exists("/workspace/archives/test_single.tar.gz") or os.path.exists("/workspace/test_single.tar.gz")


def test_wildcard_pattern_archive():
    # Legacy requirement: expects wildcard patterns like /workspace/logs/*.log or service_* to be archived
    res = archive_logs("/workspace/logs/*.log", "test_wildcard.tar.gz")
    assert res is True
    assert os.path.exists("/workspace/archives/test_wildcard.tar.gz") or os.path.exists("/workspace/test_wildcard.tar.gz")


def test_path_with_logs_prefix():
    res = archive_logs("logs/service_app", "test_prefix.tar.gz")
    assert res is True
    assert os.path.exists("/workspace/archives/test_prefix.tar.gz") or os.path.exists("/workspace/test_prefix.tar.gz")
