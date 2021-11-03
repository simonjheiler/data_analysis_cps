import json
import os
import re

import numpy as np
import pandas as pd

from src.config import BLD
from src.config import SRC
from src.data_management.format_one_dataset_supplement_asec import (
    _clean_one_dataset_yearly,
)
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

dtypes_dict = {
    "supplement_asec": {
        "year": int,
        "state": str,
        "sex": str,
        "age": int,
        "education": str,
        "labor_force_status": str,
        "race": str,
        "marital_status": str,
        "earnings_weekly": str,
        "hours_worked": str,
        "weight_personal": str,
        "weight_earnings": str,
        "weight_supplement": str,
    },
    "supplement_tenure": {
        "id": int,
        "year": int,
        "state": str,
        "sex": str,
        "age": int,
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

#####################################################
# FUNCTIONS
#####################################################


def _compile_long_df_supplement_tenure(in_data, out_path):

    survey_name = "supplement_tenure"

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
        "earnings_weekly_deflated",
        "hours_worked",
        "weight",
    ]
    cols_payments = ["earnings_weekly"]

    # initiate object to store data and iterable
    df = pd.DataFrame(columns=cols_analysis)

    for dataset in in_data:

        # get data specs
        filename = os.path.basename(dataset)
        specs_name = re.sub(".csv", ".json", filename)
        specs = json.load(
            open(SRC / "data_specs" / "data_specs" / survey_name / specs_name)
        )

        # get data types
        dtypes = {
            specs["var_dict"][var]: dtypes_dict[survey_name][var]
            for var in specs["var_dict"].keys()
        }

        # read in data set
        tmp_df = pd.read_csv(
            dataset,
            dtype=dtypes,
            index_col=specs["var_dict"]["id"],
        )

        # format data
        tmp_df = format_one_dataset(tmp_df, specs)

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
        df = df.append(tmp_df[cols_analysis])

    df.to_csv(out_path)

    return


def _compile_long_df_supplement_asec(in_data, out_path):

    survey_name = "supplement_asec"

    cols_out = [
        "year",
        "state",
        "age",
        "race",
        "marital_status",
        "education",
        "labor_force_status",
        "earnings_weekly",
        "hours_worked",
        "weight_personal",
        "weight_earnings",
        "weight_supplement",
    ]
    cols_payments = ["earnings_weekly"]

    df = pd.DataFrame(columns=cols_out)

    for dataset in in_data:

        # get data specs
        filename = os.path.basename(dataset)
        specs_name = re.sub(".csv", ".json", filename)
        specs = json.load(
            open(SRC / "data_specs" / "data_specs" / survey_name / specs_name)
        )

        # get data types
        dtypes = {
            specs["var_dict"][var]: dtypes_dict[survey_name][var]
            for var in specs["var_dict"].keys()
        }

        # read in data set
        tmp_df = pd.read_csv(
            dataset,
            dtype=dtypes,
            index_col=specs["var_dict"]["id"],
        )

        # format data
        tmp_df = _clean_one_dataset_yearly(tmp_df, specs)

        # deflate wages
        tmp_df = _deflate_payments(tmp_df, cols_payments, 2002)

        # store data
        df = df.append(tmp_df[cols_out])

    df.to_csv(out_path)

    return


def _compile_long_df(data, prod, survey):

    if survey == "basic_monthly":
        pass
        # _compile_long_df_basic_monthly(data, prod)
    elif survey == "supplement_asec":
        _compile_long_df_supplement_asec(data, prod)
    elif survey == "supplement_tenure":
        _compile_long_df_supplement_tenure(data, prod)
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

    infiles = os.listdir(BLD / "out" / "data" / survey_name)

    data = [
        BLD / "out" / "data" / survey_name / x
        for x in infiles
        if os.path.isfile(BLD / "out" / "data" / survey_name / x)
    ]
    prod = BLD / "out" / "data" / f"cps_{survey_name}_extract.csv"

    _compile_long_df(data, prod, survey_name)
