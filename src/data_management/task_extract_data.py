import json
import os
from pathlib import Path

import pytask

from src.config import BLD
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
            "do": Path("extract_data.do"),
            "deps": [
                spec_path,
                SRC / "original_data" / survey_name / f"{tmp['in_name']}.zip",
                SRC / "data_management" / survey_name / tmp["read_file"],
                SRC / "data_specs" / "data_dicts" / survey_name / tmp["data_dict"],
            ],
            "log_inner": BLD
            / "out"
            / "data"
            / survey_name
            / "log"
            / f"{tmp['out_name']}.log",
            "log_outer": BLD
            / "out"
            / "data"
            / "log"
            / f"extract_data_{survey_name}_{tmp['out_name']}.log",
            "in_file_name": in_file_name,
            "in_file_path": SRC
            / "original_data"
            / survey_name
            / f"{tmp['in_name']}.zip",
            "do_file_path": SRC / "data_management" / survey_name / tmp["read_file"],
            "dict_file_path": SRC
            / "data_specs"
            / "data_dicts"
            / survey_name
            / tmp["data_dict"],
            "path_out": BLD / "out" / "data" / survey_name,
            "result": BLD / "out" / "data" / survey_name / f"{tmp['out_name']}.csv",
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
                    s["in_file_name"],
                    s["log_inner"],
                    s["log_outer"],
                    s["in_file_path"],
                    s["do_file_path"],
                    s["dict_file_path"],
                    s["path_out"],
                    s["result"],
                    s["variables"],
                ]
            ],
            [s["do"], *s["deps"]],
            [s["log_inner"], s["log_outer"], s["result"]],
        )
        for s in stata_instructions
    ],
)
def task_extract_data():
    pass
