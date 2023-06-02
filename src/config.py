import os
from pathlib import Path

username = os.getlogin()

ROOT = Path(__file__).parent.parent
SRC = Path(__file__).parent
BLD = ROOT / "bld"
if username == "user":
    DAT = Path.home() / "local_uni" / "data"  # replace with correct data directory
elif username == "simon":
    # DAT = Path.home() / "Documents" / "local_uni" / "data"
    DAT = Path("F:/data")
else:
    raise ValueError(
        "unknown user name; please specify path of raw data in 'config.py'"
    )
