import json
import os

import pytask

from src.config import ROOT
from src.config import SRC

stata_instructions = []
for survey_name in ["supplement_tenure", "supplement_asec"]:

    # load data specs and file names
    in_path = SRC / "data_specs" / "data_specs" / survey_name
    in_specs = list(in_path.glob("cps*_*.json"))
    in_names = [os.path.basename(spec) for spec in in_specs]

    # compile stata instructions
    for spec_path in in_specs:

        in_file = os.path.basename(spec_path)
        in_file_name = os.path.splitext(in_file)[0]

        tmp = json.load(open(spec_path))
        tmp_instructions = {
            "do": SRC / "data_management" / "extract_data.do",
            "deps": [
                spec_path,
                SRC / "original_data" / survey_name / f"{tmp['in_name']}.zip",
                SRC / "data_management" / survey_name / tmp["read_file"],
                SRC / "data_specs" / "data_dicts" / survey_name / tmp["data_dict"],
            ],
            "file_name": in_file_name,
            "path_project": str(ROOT) + "/",
            "path_log_inner": "/".join(["bld", "out", "data", survey_name, "log"])
            + "/",
            "path_log_outer": "/".join(["bld", "out", "data", "log"]) + "/",
            "path_data": "/".join(["src", "original_data", survey_name]) + "/",
            "path_do": "/".join(
                ["src", "data_management", survey_name, tmp["read_file"]]
            ),
            "path_dict": "/".join(
                ["src", "data_specs", "data_dicts", survey_name, tmp["data_dict"]]
            ),
            "path_out": "/".join(["bld", "out", "data", survey_name]) + "/",
            "variables": "-".join(list(tmp["var_dict"].values())),
        }
        stata_instructions.append(tmp_instructions)


@pytask.mark.parametrize(
    "stata, depends_on, produces",
    [
        (
            [
                str(x)
                for x in [
                    s["file_name"],
                    s["path_project"],
                    s["path_log_inner"],
                    s["path_log_outer"],
                    s["path_data"],
                    s["path_do"],
                    s["path_dict"],
                    s["path_out"],
                    s["variables"],
                ]
            ],
            [s["do"], *s["deps"]],
            [
                ROOT / s["path_log_inner"] / f"{s['file_name']}.log",
                ROOT
                / s["path_log_outer"]
                / f"extract_data_{survey_name}_{s['file_name']}.log",
                ROOT / s["path_out"] / f"{s['file_name']}.csv",
            ],
        )
        for s in stata_instructions
    ],
)
def task_extract_data():
    pass
