import json
from datetime import datetime

import pandas as pd
import pytask

from src.config import BLD
from src.config import SRC
from src.data_management.format_one_dataset_basic_monthly import (
    _clean_one_dataset_monthly,
)

NO_RAW_FILES = True

data_instructions = json.load(open(SRC / "data_specs" / "cps_data_instructions.json"))

for survey_name in ["basic_monthly"]:

    date_start = datetime.strptime(
        data_instructions[survey_name]["date_start"], "%Y-%m"
    )
    date_end = datetime.strptime(data_instructions[survey_name]["date_end"], "%Y-%m")
    frequency = data_instructions[survey_name]["frequency"]
    prefix = data_instructions[survey_name]["prefix"]

    file_names = pd.date_range(date_start, date_end, freq=frequency).strftime("%Y-%m")
    file_names = [f"{prefix}_{file}" for file in file_names]

    @pytask.mark.skipif(
        NO_RAW_FILES, reason="Skip extraction from and formatting of raw data files."
    )
    @pytask.mark.parametrize(
        "depends_on, produces, spec_path",
        [
            (
                BLD / "out" / "data" / survey_name / "raw" / f"{file_name}_raw.csv",
                BLD / "out" / "data" / survey_name / f"{file_name}.csv",
                SRC / "data_specs" / "data_specs" / survey_name / f"{file_name}.json",
            )
            for file_name in file_names
        ],
    )
    def task_format_data(depends_on, produces, spec_path):
        df_in = pd.read_csv(depends_on, dtype=str)
        data_specs = json.load(open(spec_path))
        df_out = _clean_one_dataset_monthly(df_in, data_specs)
        df_out.to_csv(produces, index=True)
