import json
from datetime import datetime

import pandas as pd
import pytask

from src.config import DAT
from src.config import SRC
from src.data_management.compile_dataset import _compile_long_df

data_instructions = json.load(open(SRC / "data_specs" / "cps_data_instructions.json"))

surveys = ["basic_monthly", "supplement_asec", "supplement_tenure"]

task_instructions = {}
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
    file_names = [f"{prefix}_{file}.csv" for file in file_names]

    deps = [DAT / "cps" / survey_name / "formatted" / x for x in file_names]
    prod = DAT / "cps" / survey_name / "results" / f"cps_{survey_name}_extract.csv"

    @pytask.mark.task(kwargs={"survey": survey_name})
    @pytask.mark.depends_on(deps)
    @pytask.mark.produces(prod)
    def task_compile_data(depends_on, produces, survey):
        _compile_long_df(depends_on, produces, survey)
