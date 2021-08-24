import json
import os
import re

import numpy as np
import pandas as pd

from src.config import BLD
from src.config import SRC
from src.data_management.format_one_dataset_supplement_tenure import format_one_dataset

#####################################################
# PARAMETERS
#####################################################

idx = pd.IndexSlice

cpi_deflator = pd.read_csv(
    SRC / "original_data" / "misc" / "cpi_to_1999_conversion.csv",
    names=["to_1999"],
    header=0,
)

data_instructions = json.load(open(SRC / "data_specs" / "cps_data_instructions.json"))

#####################################################
# FUNCTIONS
#####################################################


def _compile_long_monthly_df():

    date_start = data_instructions["supplement_tenure"]["date_start"]
    date_end = data_instructions["supplement_tenure"]["date_end"]

    periods_all = list(
        pd.date_range(start=date_start, end=date_end, freq="YS").strftime("%Y-%m")
    )
    datasets_all = [
        f
        for f in os.listdir(SRC / "data_specs" / "data_specs" / "supplement_tenure")
        if f.endswith(".json")
    ]
    datasets_all = [re.sub(r"cps\w_", "", f) for f in datasets_all]
    datasets_all = [re.sub(".json", "", f) for f in datasets_all]

    datasets_selected = [d for d in datasets_all if d in periods_all]

    cols_analysis = [
        "year",
        "state",
        "sex",
        "age",
        "age_group",
        "marital_status",
        "race",
        "education",
        "labor_force_status",
        "citizenship_status",
        "tenure",
        "earnings_weekly",
        "hours_worked",
        "weight",
    ]
    cols_payments = ["earnings_weekly"]

    # initiate object to store data and iterable
    analysis_df = pd.DataFrame(columns=cols_analysis)

    for dataset in datasets_selected:

        # read in data
        filename = "cpst_" + dataset + "_raw.csv"
        specs_name = "cpst_" + dataset + ".json"
        specs = json.load(
            open(SRC / "data_specs" / "data_specs" / "supplement_tenure" / specs_name)
        )
        tmp_df = pd.read_csv(
            BLD / "out" / "data" / "supplement_tenure" / filename,
            # dtype=data_types_cps_supplement_tenure,
            # index_col=specs["vardict"]["id"],
        )

        # format data
        tmp_df = format_one_dataset(tmp_df, specs)

        # drop observations with missing values in required field
        tmp_df.dropna(subset=["age"], inplace=True)
        tmp_df.dropna(subset=["labor_force_status_reduced"], inplace=True)

        # drop observations that are out of scope
        tmp_df = tmp_df[tmp_df.sex == "MALE"]
        tmp_df = tmp_df[tmp_df.age >= 16]
        tmp_df = tmp_df[tmp_df.age <= 64]

        # deflate wages
        tmp_df = _deflate_payments(tmp_df, cols_payments, 2002)

        # change column labels in accordance with output df
        tmp_df = tmp_df.rename(
            columns={
                "labor_force_status_reduced": "labor_force_status",
                "education_reduced": "education",
                "race_reduced": "race",
                "marital_status_reduced": "marital_status",
            }
        )

        # make sure all required columns exist, if not, fill with nan
        for col in cols_analysis:
            if col not in tmp_df.columns:
                tmp_df.loc[:, col] = np.nan

        # append current data to output df
        analysis_df = analysis_df.append(tmp_df[cols_analysis])

    return analysis_df


def _deflate_payments(df, cols, base):

    cpi_deflator["to_" + str(base)] = (
        cpi_deflator["to_1999"] / cpi_deflator.loc[base, "to_1999"]
    )

    df = pd.merge(df, cpi_deflator["to_" + str(base)], left_on="year", right_index=True)

    for col in [col for col in cols if "log" not in col]:
        df.loc[:, col + "_deflated"] = df[col] * df["to_" + str(base)]

    for col in [col for col in cols if "log" in col]:
        df.loc[:, col + "_deflated"] = df[col] + np.log(df["to_" + str(base)])

    df = df.drop(columns=["to_" + str(base)])

    return df


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    df = _compile_long_monthly_df()

    df.to_csv(BLD / "out" / "data" / "supplement_tenure.csv", index=False)
