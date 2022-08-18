import json
import os

import pytask

from src.config import ROOT
from src.config import SRC

stata_instructions = []
for survey_name in ["basic_monthly", "supplement_asec", "supplement_tenure"]:

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
                SRC / "original_data" / survey_name / f"{tmp['in_dir']}.zip",
                SRC / "data_management" / survey_name / tmp["read_file"],
                SRC / "data_specs" / "data_dicts" / survey_name / tmp["data_dict"],
            ],
            "in_dir": tmp["in_dir"],
            "in_file": tmp["in_file"],
            "path_project": str(ROOT) + "/",
            "path_log": "/".join(["bld", "out", "data", survey_name, "log"]) + "/",
            "path_data": "/".join(["src", "original_data", survey_name]) + "/",
            "path_do": "/".join(
                ["src", "data_management", survey_name, tmp["read_file"]]
            ),
            "path_dict": "/".join(
                ["src", "data_specs", "data_dicts", survey_name, tmp["data_dict"]]
            ),
            "path_out": "/".join(["bld", "out", "data", survey_name, "raw"]) + "/",
            "variables": "-".join(list(tmp["var_dict"].values()) + tmp["identifier"]),
        }
        stata_instructions.append(tmp_instructions)


for s in stata_instructions:

    @pytask.mark.task
    @pytask.mark.stata(
        script=s["do"],
        options=[
            str(x)
            for x in [
                s["in_dir"],
                s["in_file"],
                s["path_project"],
                s["path_log"],
                s["path_data"],
                s["path_do"],
                s["path_dict"],
                s["path_out"],
                s["variables"],
            ]
        ],
    )
    @pytask.mark.depends_on([s["do"], *s["deps"]])
    @pytask.mark.produces(
        [
            ROOT / s["path_log"] / f"{s['in_dir']}.log",
            ROOT / s["path_out"] / f"{s['in_dir']}_raw.csv",
        ]
    )
    def task_extract_data():
        pass
