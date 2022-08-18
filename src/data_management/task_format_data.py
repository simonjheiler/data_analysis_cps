import json
import os

import pandas as pd
import pytask

from src.config import BLD
from src.config import SRC
from src.data_management.format_one_dataset_basic_monthly import (
    _clean_one_dataset_monthly,
)

NO_RAW_FILES = False

for survey_name in ["basic_monthly"]:

    # load data specs and file names
    in_path = BLD / "out" / "data" / survey_name / "raw"
    in_files = list(in_path.glob("cps*_*_raw.csv"))
    in_names = [
        os.path.basename(file).split(".")[0].replace("_raw", "") for file in in_files
    ]

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
            for file_name in in_names
        ],
    )
    def task_format_data(depends_on, produces, spec_path):
        df_in = pd.read_csv(depends_on, dtype=str)
        data_specs = json.load(open(spec_path))
        df_out = _clean_one_dataset_monthly(df_in, data_specs)
        df_out.to_csv(produces, index=True)
