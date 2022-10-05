"""Create data specs from data description and instructions.


"""
import json
from datetime import datetime

import pandas as pd
import pytask

from src.config import SRC
from src.data_specs._get_data_specs import _write_data_specs_cps

cps_data_instructions = json.load(
    open(SRC / "data_specs" / "cps_data_instructions.json")
)

surveys = ["basic_monthly", "supplement_asec", "supplement_tenure"]

RERUN_DATA_SPECS = True

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


@pytask.mark.skipif(
    RERUN_DATA_SPECS, reason="Skip creation of specifications for data extraction."
)
@pytask.mark.parametrize(
    "depends_on, produces, survey_name",
    [
        (
            {
                "instructions": SRC / "data_specs" / "cps_data_instructions.json",
                "description": SRC
                / "data_specs"
                / f"cps_data_description_{survey}.json",
            },
            {
                file: SRC
                / "data_specs"
                / "data_specs"
                / survey
                / f"{cps_data_instructions[survey]['prefix']}_{file}.json"
                for file in file_lists[survey]
            },
            survey,
        )
        for survey in surveys
    ],
)
def task_get_data_specs(depends_on, produces, survey_name):

    # get data specs
    instructions = json.load(open(depends_on["instructions"]))[survey_name]
    description = json.load(open(depends_on["description"]))

    data_specs = _write_data_specs_cps(instructions, description)

    # write individual specification files to build directory
    for dataset in data_specs:
        with open(produces[dataset], "w") as outfile:
            json.dump(data_specs[dataset], outfile, ensure_ascii=False, indent=2)
