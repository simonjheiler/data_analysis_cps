"""Create data specs from data description and instructions.


"""
import json
import re
from datetime import datetime
from os import listdir

import pytask

from src.config import SRC
from src.data_specs._get_data_specs import _write_data_specs_cps

cps_data_instructions = json.load(
    open(SRC / "data_specs" / "cps_data_instructions.json")
)

prefixes = {}
datasets = {}
for survey in ["basic_monthly", "supplement_tenure"]:

    # load info from data instructions
    date_start = datetime.strptime(cps_data_instructions[survey]["date_start"], "%Y-%m")
    date_end = datetime.strptime(cps_data_instructions[survey]["date_end"], "%Y-%m")
    var_list = cps_data_instructions[survey]["variables"]
    prefixes[survey] = cps_data_instructions[survey]["prefix"]

    # filter selected files from list of all files
    datasets_all = list(listdir(SRC / "original_data" / survey))
    datasets_all = [re.sub(r"cps\w_", "", f) for f in datasets_all]
    datasets_all = [re.sub(".zip", "", f) for f in datasets_all]
    datasets_all = [datetime.strptime(f, "%Y-%m") for f in datasets_all]

    datasets_selected = []
    for dataset in datasets_all:
        if dataset >= date_start and dataset <= date_end:
            datasets_selected.append(dataset)

    # store list of selected files in dict
    datasets[survey] = [
        datetime.strftime(dataset, "%Y-%m") for dataset in datasets_selected
    ]


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
                dataset: SRC
                / "data_specs"
                / "data_specs"
                / survey
                / f"{prefixes[survey]}_{dataset}.json"
                for dataset in datasets[survey]
            },
            survey,
        )
        for survey in ["basic_monthly", "supplement_tenure"]
    ],
)
def task_get_data_specs(depends_on, produces, survey_name):

    # get data specs
    instructions = json.load(open(depends_on["instructions"]))[survey_name]
    description = json.load(open(depends_on["description"]))

    data_specs = _write_data_specs_cps(survey_name, instructions, description)

    # write individual specification files to build directory
    for dataset in data_specs:
        with open(produces[dataset], "w") as outfile:
            json.dump(data_specs[dataset], outfile, ensure_ascii=False, indent=2)
