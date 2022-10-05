import json
from datetime import datetime

import pandas as pd
import pytask

from src.config import DAT
from src.config import SRC
from src.data_management.format_one_dataset_basic_monthly import (
    _clean_one_dataset_monthly,
)
from src.data_management.format_one_dataset_supplement_asec import (
    _clean_one_dataset_yearly,
)
from src.data_management.format_one_dataset_supplement_tenure import (
    format_one_dataset,
)

NO_RAW_FILES = False

data_instructions = json.load(open(SRC / "data_specs" / "cps_data_instructions.json"))

for survey_name in ["basic_monthly", "supplement_asec", "supplement_tenure"]:

    date_start = datetime.strptime(
        data_instructions[survey_name]["date_start"], "%Y-%m"
    )
    date_end = datetime.strptime(data_instructions[survey_name]["date_end"], "%Y-%m")
    frequency = data_instructions[survey_name]["frequency"]
    prefix = data_instructions[survey_name]["prefix"]

    file_names = pd.date_range(date_start, date_end, freq=frequency).strftime("%Y-%m")
    file_names = [f"{prefix}_{file}" for file in file_names]

    @pytask.mark.task
    @pytask.mark.skipif(
        NO_RAW_FILES, reason="Skip extraction from and formatting of raw data files."
    )
    @pytask.mark.parametrize(
        "depends_on, produces, survey_name, spec_path",
        [
            (
                DAT / "cps" / survey_name / "temp" / f"{file_name}_raw.csv",
                DAT / "cps" / survey_name / "formatted" / f"{file_name}.csv",
                survey_name,
                SRC / "data_specs" / "data_specs" / survey_name / f"{file_name}.json",
            )
            for file_name in file_names
        ],
    )
    def task_format_data(depends_on, produces, survey_name, spec_path):
        df_in = pd.read_csv(depends_on, dtype=str)
        data_specs = json.load(open(spec_path))

        if survey_name == "basic_monthly":
            df_out = _clean_one_dataset_monthly(df_in, data_specs)
        elif survey_name == "supplement_asec":
            df_out = _clean_one_dataset_yearly(df_in, data_specs)
        elif survey_name == "supplement_tenure":
            df_out = format_one_dataset(df_in, data_specs)
        else:
            raise ValueError(
                "survey name unknown; please select one of "
                "['basic_monthly', 'supplement_asec', 'supplement_tenure']"
            )

        df_out.to_csv(produces, index=True)
