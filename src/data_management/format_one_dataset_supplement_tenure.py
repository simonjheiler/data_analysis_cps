import datetime
import json
import sys

import numpy as np
import pandas as pd

from src.config import BLD
from src.config import SRC
from src.utilities.format_utils import _add_categorical_variables

#####################################################
# PARAMETERS
#####################################################

# CPS state codes
state_codes = pd.read_csv(SRC / "original_data" / "misc" / "cps_us_state_codes.csv")
state_codes_dict = {
    state_codes.iloc[i, 0]: state_codes.iloc[i, 1] for i in range(state_codes.shape[0])
}

cpi_deflator = pd.read_csv(
    SRC / "original_data" / "misc" / "cpi_to_1999_conversion.csv",
    names=["to_1999"],
    header=0,
)

children_codes_dict = {
    "NIU (Not a parent)": np.nan,
    "VALUE - NO CHANGE": np.nan,
    "BLANK - NO CHANGE": np.nan,
    "DON'T KNOW - NO CHANGE": np.nan,
    "REFUSED - NO CHANGE": np.nan,
    "VALUE TO VALUE": np.nan,
    "BLANK TO VALUE": np.nan,
    "DON'T KNOW TO VALUE": np.nan,
    "REFUSED TO VALUE": np.nan,
    "VALUE TO LONGITUDINAL VALUE": np.nan,
    "BLANK TO LONGITUDINAL VALUE": np.nan,
    "DON'T KNOW TO LONGITUDINAL VALUE": np.nan,
    "REFUSED TO LONGITUDINAL VALUE": np.nan,
    "VALUE TO ALLOCATED VALUE LONG.": np.nan,
    "BLANK TO ALLOCATED VALUE LONG.": np.nan,
    "DON'T KNOW TO ALLOCATED VALUE LONG.": np.nan,
    "REFUSED TO ALLOCATED VALUE LONG.": np.nan,
    "VALUE TO ALLOCATED VALUE": np.nan,
    "BLANK TO ALLOCATED VALUE": np.nan,
    "DON'T KNOW TO ALLOCATED VALUE": np.nan,
    "REFUSED TO ALLOCATED VALUE": np.nan,
    "VALUE TO BLANK": np.nan,
    "DON'T KNOW TO BLANK": np.nan,
    "REFUSED TO BLANK": np.nan,
}

mis_codes_dict = {
    "MIS 1": 1,
    "MIS 2": 2,
    "MIS 3": 3,
    "MIS 4": 4,
    "MIS 5": 5,
    "MIS 6": 6,
    "MIS 7": 7,
    "MIS 8": 8,
}


#####################################################
# FUNCTIONS
#####################################################


def format_one_dataset(df, specs):

    # define columns to be returned and data types
    cols_numeric = ["earnings_weekly", "hours_worked", "tenure", "weight"]
    cols_int = ["year"]
    cols_int8 = ["age"]
    cols_str = ["state", "sex"]
    cols_categorical = [
        "age_group",
        "labor_force_status_reduced",
        "education_reduced",
        "marital_status_reduced",
        "race_reduced",
        "citizenship_status_reduced",
    ]

    cols_out = cols_int + cols_str + cols_int8 + cols_categorical + cols_numeric

    var_dict = specs["var_dict"]
    var_dict = {v: k for k, v in var_dict.items()}

    # rename variables to uniform labels
    df.rename(columns=var_dict, inplace=True)

    # replace answer codes with values
    df = _clean_variables(df)

    # add variables
    df = _add_categorical_variables(df)

    # add flag for working spouses
    # df = _get_spousal_labor_force_status(df, specs)

    # set data types
    for col in cols_numeric:
        df.loc[:, col] = df[col].astype(float)

    for col in cols_int:
        df.loc[:, col] = df[col].astype(int)

    # for col in cols_int8:
    #     df.loc[:, col] = df[col].astype("Int8")

    for col in cols_categorical:
        df.loc[:, col] = df[col].astype("category")

    # drop unused columns
    df = df[cols_out]

    return df


def _clean_variables(df):

    for col in df.columns:
        df.loc[:, col].replace("Blank", np.nan, inplace=True)
        df.loc[:, col].replace("No Response", np.nan, inplace=True)
        df.loc[:, col].replace("No response", np.nan, inplace=True)
        df.loc[:, col].replace("not in universe", np.nan, inplace=True)
        df.loc[:, col].replace("NOT IN UNIVERSE", np.nan, inplace=True)
        df.loc[:, col].replace("NIU", np.nan, inplace=True)
        df.loc[:, col].replace("Don't Know", np.nan, inplace=True)
        df.loc[:, col].replace("-1", np.nan, inplace=True)
        df.loc[:, col].replace("-2", np.nan, inplace=True)
        df.loc[:, col].replace("-3", np.nan, inplace=True)

    # clean age variable
    df.loc[:, "age"] = df.loc[:, "age"].replace(
        {"80-84 years of age": "82", "85+ years of age": "88"}
    )
    df.loc[:, "age"] = pd.to_numeric(df.loc[:, "age"]).astype("Int8")

    # clean state codes
    df.loc[:, "state"] = df.loc[:, "state"].replace(state_codes_dict)

    # clean tenure topcoding
    df.loc[:, "tenure"] = df.loc[:, "tenure"].replace({"3900 or more (topcoded)": 3900})

    # clean hours topcoding
    df.loc[:, "hours_worked"] = df.loc[:, "hours_worked"].replace(
        {"45 or more (topcoded)": 45}
    )

    return df


def _get_spousal_labor_force_status(df, specs):

    cols_out = list(df.columns) + ["working_spouse", "spousal_status"]

    identifier_self = specs["identifier"]
    identifier_spouse = specs["identifier"][:-1] + ["spouse_id"]

    df.loc[:, "match_identifier"] = df.index

    df = pd.merge(
        df,
        df[identifier_spouse + ["labor_force_status_reduced"]],
        left_on=identifier_self,
        right_on=identifier_spouse,
        suffixes=["", "_spouse"],
        how="left",
    )

    df.set_index("match_identifier", inplace=True)

    df.loc[df["spouse_id"] == np.nan, "spousal_status"] = np.nan
    df.loc[df["spouse_id"] == "NONE", "spousal_status"] = "no partner"
    df.loc[
        df["labor_force_status_reduced_spouse"] == "employed", "spousal_status"
    ] = "working partner"
    df.loc[
        df["labor_force_status_reduced_spouse"] == "unemployed", "spousal_status"
    ] = "unemployed partner"
    df.loc[
        df["labor_force_status_reduced_spouse"] == "not in labor force",
        "spousal_status",
    ] = "non-working partner"

    df.loc[pd.isna(df["spouse_id"]), "working_spouse"] = np.nan
    df.loc[df["spouse_id"] == "NONE", "working_spouse"] = False
    df.loc[
        df["labor_force_status_reduced_spouse"] == "employed", "working_spouse"
    ] = True
    df.loc[
        df["labor_force_status_reduced_spouse"] == "unemployed", "working_spouse"
    ] = False
    df.loc[
        df["labor_force_status_reduced_spouse"] == "not in labor force",
        "working_spouse",
    ] = False

    df.loc[
        df[pd.isna(df.labor_force_status_reduced_spouse)].index, "working_spouse"
    ] = np.nan

    return df[cols_out]


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    try:
        dataset = sys.argv[1]
    except IndexError:
        dataset = "cpsb_1989-01"

    try:
        name_in = dataset + "_raw.csv"
        name_out = dataset + ".csv"
        df_in = pd.read_csv(BLD / "out" / "data" / name_in, dtype=str)
        data_specs = json.load(
            open(
                SRC / "data_specs" / "specs" / "cps",
                "specs",
                "monthly",
                dataset + ".json",
            )
        )
        df_out = format_one_dataset(df_in, data_specs)
        df_out.to_csv(BLD / "out" / "data" / name_out, index=True)
        log = dataset + ": " + str(datetime.datetime.now()) + " - OK! \n"
    except FileNotFoundError:
        log = (
            dataset
            + ": "
            + str(datetime.datetime.now())
            + " - Error! File not Found. \n"
        )

    try:
        logfile = open(BLD / "out" / "data" / "format_data_cps_monthly_log.txt")
        entries = logfile.readlines()
    except FileNotFoundError:
        entries = []

    in_log = False
    for idx, line in enumerate(entries):
        if dataset in line:
            entries[idx] = log
            in_log = True

    if not in_log:
        entries.append(log)

    entries = [entry for entry in entries if entry != " \n"]

    logfile = open(BLD / "out" / "data" / "format_data_cps_monthly_log.txt", "w")
    for line in entries:
        logfile.write(f"{line}")
