"""Create data specs from data description and instructions."""
import json
from datetime import datetime
from pathlib import Path

import pandas as pd
import pytask

from src.config import SRC
from src.data_specs._get_data_specs import _write_data_specs_cps

with Path.open(SRC / "data_specs" / "cps_data_instructions.json") as file:
    cps_data_instructions = json.load(file)

surveys = ["basic_monthly", "supplement_asec", "supplement_tenure"]

DONT_RERUN_DATA_SPECS = False

prefixes = {}
file_lists = {}
for survey in surveys:
    # load info from data instructions
    date_start = datetime.strptime(
        cps_data_instructions[survey]["date_start"],
        cps_data_instructions[survey]["date_format"],
    )
    date_end = datetime.strptime(
        cps_data_instructions[survey]["date_end"],
        cps_data_instructions[survey]["date_format"],
    )
    var_list = cps_data_instructions[survey]["variables"]
    prefixes[survey] = cps_data_instructions[survey]["prefix"]

    file_list = (
        pd.date_range(
            start=date_start,
            end=date_end,
            freq=cps_data_instructions[survey]["frequency"],
        )
        .strftime(cps_data_instructions[survey]["date_format"])
        .tolist()
    )

    # store list of selected files in dict
    file_lists[survey] = file_list

    # compile kwargs
    kwargs = {
        "depends_on": {
            "instructions": SRC / "data_specs" / "cps_data_instructions.json",
            "description": SRC / "data_specs" / f"cps_data_description_{survey}.json",
        },
        "produces": {
            file: SRC
            / "data_specs"
            / "data_specs"
            / survey
            / f"{cps_data_instructions[survey]['prefix']}_{file}.json"
            for file in file_lists[survey]
        },
        "survey_name": survey,
    }

    @pytask.mark.skipif(
        DONT_RERUN_DATA_SPECS,
        reason="Skip creation of specifications for data extraction.",
    )
    @pytask.mark.data_prep
    @pytask.mark.task(id=survey, kwargs=kwargs)
    def task_get_data_specs(depends_on, produces, survey_name):
        """Task file to generate data specification files."""
        # get data specs
        with Path.open(depends_on["instructions"]) as file:
            instructions_all = json.load(file)
        instructions = instructions_all[survey_name]

        with Path.open(depends_on["description"]) as file:
            description = json.load(file)

        data_specs = _write_data_specs_cps(instructions, description)

        # write individual specification files to build directory
        for dataset in data_specs:
            with Path.open(produces[dataset], "w") as outfile:
                json.dump(data_specs[dataset], outfile, ensure_ascii=False, indent=2)
