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


def _compile_long_df_supplement_tenure(in_data, out_path):

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
    analysis_df = pd.DataFrame(columns=cols_analysis)

    for dataset in in_data:

        # read in data
        filename = os.path.basename(dataset)
        specs_name = re.sub(".csv", ".json", filename)
        specs = json.load(
            open(SRC / "data_specs" / "data_specs" / "supplement_tenure" / specs_name)
        )

        dtypes = {
            specs["var_dict"]["year"]: int,
            specs["var_dict"]["state"]: str,
            specs["var_dict"]["sex"]: str,
            specs["var_dict"]["age"]: int,
            specs["var_dict"]["education"]: str,
            specs["var_dict"]["labor_force_status"]: str,
            specs["var_dict"]["race"]: str,
            specs["var_dict"]["marital_status"]: str,
            specs["var_dict"]["citizenship_status"]: str,
            specs["var_dict"]["tenure"]: str,
            specs["var_dict"]["earnings_weekly"]: float,
            specs["var_dict"]["hours_worked"]: str,
            specs["var_dict"]["weight"]: float,
        }

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
                "citizenship_status_reduced": "citizenship_status",
            }
        )

        # make sure all required columns exist, if not, fill with nan
        for col in cols_analysis:
            if col not in tmp_df.columns:
                tmp_df.loc[:, col] = np.nan

        # append current data to output df
        analysis_df = analysis_df.append(tmp_df[cols_analysis])

    analysis_df.to_csv(out_path)

    return


def _compile_long_df_supplement_asec(in_data, out_path):

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
    analysis_df = pd.DataFrame(columns=cols_analysis)

    for dataset in in_data:

        # read in data
        filename = os.path.basename(dataset)
        specs_name = re.sub(".csv", ".json", filename)
        specs = json.load(
            open(SRC / "data_specs" / "data_specs" / "supplement_tenure" / specs_name)
        )

        dtypes = {
            specs["var_dict"]["year"]: int,
            specs["var_dict"]["state"]: str,
            specs["var_dict"]["sex"]: str,
            specs["var_dict"]["age"]: int,
            specs["var_dict"]["education"]: str,
            specs["var_dict"]["labor_force_status"]: str,
            specs["var_dict"]["race"]: str,
            specs["var_dict"]["marital_status"]: str,
            specs["var_dict"]["citizenship_status"]: str,
            specs["var_dict"]["tenure"]: str,
            specs["var_dict"]["earnings_weekly"]: float,
            specs["var_dict"]["hours_worked"]: str,
            specs["var_dict"]["weight"]: float,
        }

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
                "citizenship_status_reduced": "citizenship_status",
            }
        )

        # make sure all required columns exist, if not, fill with nan
        for col in cols_analysis:
            if col not in tmp_df.columns:
                tmp_df.loc[:, col] = np.nan

        # append current data to output df
        analysis_df = analysis_df.append(tmp_df[cols_analysis])

    analysis_df.to_csv(out_path)

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
        BLD / "out" / "data" / "supplement_tenure" / x
        for x in infiles
        if os.path.isfile(BLD / "out" / "data" / survey_name / x)
    ]
    prod = BLD / "out" / "data" / "supplement_tenure.csv"

    _compile_long_df(data, prod, survey_name)
