import json
from datetime import datetime

import pandas as pd

import pytask

from src.config import BLD
from src.config import DAT
from src.config import SRC
from src.data_management.compile_dataset import _compile_long_df

data_instructions = json.load(open(SRC / "data_specs" / "cps_data_instructions.json"))

surveys = ["supplement_asec", "supplement_tenure"]

for survey_name in surveys:

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
    file_names = [f"{prefix}_{file}_raw.csv" for file in file_names]

    deps = [DAT / "cps" / survey_name / "temp" / x for x in file_names]
    prod = BLD / "datasets" / f"cps_{survey_name}_extract.csv"

    @pytask.mark.task
    @pytask.mark.parametrize(
        "depends_on, produces, survey_name",
        [
            (
                deps,
                prod,
                survey_name,
            )
        ],
    )
    def task_compile_data(depends_on, produces, survey_name):
        _compile_long_df(depends_on, produces, survey_name)
