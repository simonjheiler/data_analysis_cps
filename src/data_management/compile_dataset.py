import json
from datetime import datetime

import numpy as np
import pandas as pd

from src.config import DAT
from src.config import SRC
from src.data_management.compile_monthly_data_cps import _compile_long_monthly_df

#####################################################
# PARAMETERS
#####################################################

idx = pd.IndexSlice

cpi_deflator = pd.read_csv(
    DAT / "misc" / "cpi_to_1999_conversion.csv",
    names=["to_1999"],
    header=0,
)

data_instructions = json.load(open(SRC / "data_specs" / "cps_data_instructions.json"))

dtypes_dict = {
    "supplement_asec": {
        "id": int,
        "year": int,
        "state": str,
        "sex": str,
        "age": int,
        "education": str,
        "grade_completed": str,
        "labor_force_status": str,
        "race": str,
        "marital_status": str,
        "citizenship_status": str,
        "earnings_weekly": float,
        "hours_worked": float,
        "weight_personal": float,
        "weight_earnings": float,
        "weight_supplement": float,
    },
    "supplement_tenure": {
        "year": int,
        "state": str,
        "sex": str,
        "age": float,
        "education": str,
        "labor_force_status": str,
        "race": str,
        "marital_status": str,
        "citizenship_status": str,
        "tenure": str,
        "earnings_weekly": float,
        "hours_worked": str,
        "weight": float,
    },
}

cols_analysis = {
    "supplement_asec": [
        "year",
        "age",
        "state",
        "sex",
        "education",
        "marital_status",
        "race",
        "labor_force_status",
        "weight_personal",
        "weight_earnings",
        "weight_supplement",
        "hours_worked",
        "earnings_weekly",
    ],
    "supplement_tenure": [
        "year",
        "state",
        "age",
        "age_group",
        "sex",
        "race",
        "marital_status",
        "education",
        "labor_force_status",
        "tenure",
        "earnings_weekly",
        "hours_worked",
        "weight",
    ],
}

#####################################################
# FUNCTIONS
#####################################################


def _compile_long_df_supplement(in_data, out_path, survey_name):

    base_year = 2002
    cols_out = cols_analysis[survey_name]
    cols_payments = ["earnings_weekly"]
    cols_out += [col + "_deflated" for col in cols_payments]

    # initiate object to store data and iterable
    df = pd.DataFrame(columns=cols_out)

    if type(in_data) is dict:
        in_data = [*in_data.values()]

    for dataset in in_data:

        # read in data set
        tmp_df = pd.read_csv(
            dataset, dtype=dtypes_dict[survey_name], index_col="match_identifier"
        )

        # deflate wages
        tmp_df = _deflate_payments(tmp_df, cols_payments, base_year)

        # append data
        df = pd.concat([df, tmp_df[cols_out]], axis=0)

    # store data
    df.to_csv(out_path)

    return


def _compile_long_df_supplement_asec(in_data, out_path):

    survey_name = "supplement_asec"

    base_year = 2002
    cols_out = cols_analysis[survey_name]
    cols_payments = ["earnings_weekly"]
    cols_out += [col + "_deflated" for col in cols_payments]

    # initiate object to store data and iterable
    df = pd.DataFrame(columns=cols_out)

    if type(in_data) is dict:
        in_data = [*in_data.values()]

    for dataset in in_data:

        # read in data set
        tmp_df = pd.read_csv(
            dataset, dtype=dtypes_dict[survey_name], index_col="match_identifier"
        )

        # deflate wages
        tmp_df = _deflate_payments(tmp_df, cols_payments, base_year)

        # append data
        df = pd.concat([df, tmp_df[cols_out]], axis=0)

    # store data
    df.to_csv(out_path)

    return


def _compile_long_df(data, prod, survey):

    if survey == "basic_monthly":
        _compile_long_monthly_df(data, prod)
    elif survey in ["supplement_asec", "supplement_tenure"]:
        _compile_long_df_supplement(data, prod, survey)
    else:
        raise ValueError(
            f"survey name {survey} unknown;"
            " please choose one of ['basic_monthly', 'supplement_asec', 'supplement_tenure']"
        )

    return


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

    survey_name = "supplement_tenure"

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

    _compile_long_df(deps, prod, survey_name)
