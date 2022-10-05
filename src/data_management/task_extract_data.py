import json
import os
from datetime import datetime

import pandas as pd
import pytask

from src.config import DAT
from src.config import ROOT
from src.config import SRC

NO_RAW_FILES = False

data_instructions = json.load(open(SRC / "data_specs" / "cps_data_instructions.json"))

stata_instructions = []
for survey_name in ["basic_monthly", "supplement_asec", "supplement_tenure"]:

    date_start = datetime.strptime(
        data_instructions[survey_name]["date_start"],
        data_instructions[survey_name]["date_format"],
    )
    date_end = datetime.strptime(
        data_instructions[survey_name]["date_end"],
        data_instructions[survey_name]["date_format"],
    )
    frequency = data_instructions[survey_name]["frequency"]
    prefix = data_instructions[survey_name]["prefix"]

    file_names = pd.date_range(date_start, date_end, freq=frequency).strftime(
        data_instructions[survey_name]["date_format"]
    )
    file_names = [f"{prefix}_{file}" for file in file_names]

    # load data specs and file names
    in_path = SRC / "data_specs" / "data_specs" / survey_name
    in_specs = list(in_path.glob("cps*_*.json"))
    in_names = [os.path.basename(spec) for spec in in_specs]

    # compile stata instructions
    for file_name in file_names:

        spec_path = (
            SRC / "data_specs" / "data_specs" / survey_name / f"{file_name}.json"
        )

        tmp = json.load(open(spec_path))
        tmp_instructions = {
            "do": SRC / "data_management" / "extract_data.do",
            "deps": [
                spec_path,
                DAT / "cps" / survey_name / "rawdata" / f"{tmp['in_dir']}.zip",
                SRC / "data_management" / survey_name / tmp["read_file"],
                SRC / "data_specs" / "data_dicts" / survey_name / tmp["data_dict"],
            ],
            "in_dir": tmp["in_dir"],
            "in_file": tmp["in_file"],
            "path_project": str(ROOT).replace("\\", "/") + "/",
            "path_data": str(DAT).replace("\\", "/") + "/",
            "path_do": "/".join(
                ["src", "data_management", survey_name, tmp["read_file"]]
            ),
            "path_dict": "/".join(
                ["src", "data_specs", "data_dicts", survey_name, tmp["data_dict"]]
            ),
            "path_in": "/".join(["cps", survey_name, "rawdata"]) + "/",
            "path_log": "/".join(["cps", survey_name, "formatted", "log"]) + "/",
            "path_out": "/".join(["cps", survey_name, "temp"]) + "/",
            "variables": "-".join(list(tmp["var_dict"].values()) + tmp["identifier"]),
        }
        stata_instructions.append(tmp_instructions)


for s in stata_instructions:

    @pytask.mark.task
    @pytask.mark.skipif(
        NO_RAW_FILES, reason="Skip extraction from and formatting of raw data files."
    )
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
                s["path_in"],
                s["path_out"],
                s["variables"],
            ]
        ],
    )
    @pytask.mark.depends_on([s["do"], *s["deps"]])
    @pytask.mark.produces(
        [
            DAT / s["path_log"] / f"{s['in_dir']}.log",
            DAT / s["path_out"] / f"{s['in_dir']}_raw.csv",
        ]
    )
    def task_extract_data():
        pass
