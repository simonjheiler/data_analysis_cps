import datetime
import json
import sys

import numpy as np
import pandas as pd

from src.config import BLD
from src.config import DAT
from src.config import SRC
from src.utilities.format_utils import _add_categorical_variables

#####################################################
# PARAMETERS
#####################################################

# CPS state codes
state_codes = pd.read_csv(DAT / "cps" / "misc" / "cps_us_state_codes.csv")
state_codes_dict = {
    state_codes.iloc[i, 0]: state_codes.iloc[i, 1] for i in range(state_codes.shape[0])
}

cpi_deflator = pd.read_csv(
    DAT / "misc" / "cpi_to_1999_conversion.csv",
    names=["to_1999"],
    header=0,
)

#####################################################
# FUNCTIONS
#####################################################


def _clean_variables(df, specs):

    # clean answer codes
    for col in df.columns:
        df.loc[:, col].replace("NONE", np.nan, inplace=True)
        df.loc[:, col].replace("Blank", np.nan, inplace=True)
        df.loc[:, col].replace("not in universe", np.nan, inplace=True)
        df.loc[:, col].replace("NOT IN UNIVERSE", np.nan, inplace=True)
        df.loc[:, col].replace("Not in universe", np.nan, inplace=True)
        df.loc[:, col].replace("NIU", np.nan, inplace=True)
        df.loc[:, col].replace("-1", np.nan, inplace=True)
        df.loc[:, col].replace("-2", "I don't know", inplace=True)
        df.loc[:, col].replace("-3", "refuse to answer", inplace=True)
        df.loc[:, col].replace("Yes", "YES", inplace=True)
        df.loc[:, col].replace("No", "NO", inplace=True)

    for col in [var for var in specs["var_dict"] if "weight_" in var] + [
        "earnings_weekly",
        "hours_worked",
    ]:
        df.loc[:, col] = (
            df[col]
            .replace(
                {
                    "Not in universe or children or Armed Forces": np.nan,
                    "Not in universe or children and Armed Forces": np.nan,
                    "Not in universe or children and": np.nan,
                    "Not in universe or children": np.nan,
                    "Children and Armed Forces": np.nan,
                    "Supplemental spanish sample": np.nan,
                    "Supplemental Spanish sample": np.nan,
                }
            )
            .astype("float")
        )

    # clean year variable
    dicts_year_1 = [
        "cpsy_1989.dct",
        "cpsy_1990.dct",
        "cpsy_1991.dct",
        "cpsy_1992.dct",
        "cpsy_1993.dct",
        "cpsy_1994.dct",
        "cpsy_1995.dct",
        "cpsy_1996.dct",
        "cpsy_1997.dct",
        "cpsy_1998.dct",
    ]
    dicts_year_2 = []

    if specs["data_dict"] in dicts_year_1:
        df.loc[:, "year"] = specs["out_name"][5:8] + df.loc[:, "year"].astype(str)
    elif specs["data_dict"] in dicts_year_2:
        df.loc[:, "year"] = specs["out_name"][5:7] + df.loc[:, "year"].astype(str)

    # clean age variable
    df.loc[:, "age"] = df.loc[:, "age"].replace(
        {"80-84 years of age": "82", "85+ years of age": "88"}
    )
    df.loc[:, "age"] = pd.to_numeric(df.loc[:, "age"]).astype("Int8")

    # clean state codes
    df.loc[:, "state"] = df.loc[:, "state"].replace(state_codes_dict)

    return df


def _clean_one_dataset_yearly(df, specs):

    # define columns to be returned and data types
    cols_numeric = [var for var in specs["var_dict"] if "weight_" in var] + [
        "earnings_weekly",
        "hours_worked",
    ]
    cols_int = ["year"]
    cols_int8 = ["age"]
    cols_str = ["state", "sex"]
    cols_categorical = [
        "education",
        "marital_status",
        "race",
        "labor_force_status",
    ]

    cols_out = cols_int + cols_int8 + cols_str + cols_categorical + cols_numeric

    # read in columns used to construct match identifier
    cols_match = specs["identifier"]

    # create longitudinal match identifier
    df.loc[:, "match_identifier"] = df.loc[:, cols_match[0]].astype(str)
    for col in cols_match[1:]:
        df.loc[:, "match_identifier"] += df.loc[:, col].astype(str)

    # set identifier as index
    df.set_index("match_identifier", inplace=True)

    # rename variables to uniform labels
    var_dict = specs["var_dict"]
    var_dict = {v: k for k, v in var_dict.items()}
    df.rename(columns=var_dict, inplace=True)

    # clean variables
    df = _clean_variables(df, specs)

    # add variables
    df = _add_categorical_variables(df)

    # drop observations other than males aged 16-64
    df = df[df.sex == "Male"]
    df = df[df.age >= 16]
    df = df[df.age <= 64]

    df.dropna(subset=["earnings_weekly"], inplace=True)

    # reduce educational attainment to four categories
    df.loc[:, "education_reduced"] = df["education_reduced"].replace(
        {
            "Less than 5th Grade": "Less than a High School Diploma",
            "5th Grade to 12th Grade without Diploma": "Less than a High School Diploma",
        }
    )

    # drop unused columns
    df = df.drop(columns=["education", "marital_status", "race", "labor_force_status"])

    # rename columns
    df = df.rename(
        columns={
            "education_reduced": "education",
            "marital_status_reduced": "marital_status",
            "race_reduced": "race",
            "labor_force_status_reduced": "labor_force_status",
        }
    )

    # add column for grade completed if missing
    if "grade_completed" not in df.columns:
        df.loc[:, "grade_completed"] = np.nan

    # set data types
    for col in cols_numeric:
        df.loc[:, col] = df[col].astype("float")

    for col in cols_int:
        df.loc[:, col] = df[col].astype("int")

    for col in cols_str:
        df.loc[:, col] = df[col].astype(str)

    for col in cols_categorical:
        df.loc[:, col] = df[col].astype("category")

    # drop unused columns
    df = df[cols_out]

    return df


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    try:
        dataset = sys.argv[1]
    except IndexError:
        dataset = "cpsa_1989-03"

    try:
        name_in = dataset + "_raw.csv"
        name_out = dataset + ".csv"
        df_in = pd.read_csv(
            BLD / "out" / "data" / "supplement_asec" / name_in, dtype=str
        )
        data_specs = json.load(
            open(SRC / "data_specs" / "supplement_asec" / f"{dataset}.json")
        )
        df_out = _clean_one_dataset_yearly(df_in, data_specs)
        df_out.to_csv(BLD / "out" / "data" / "supplement_asec" / name_out, index=False)
        log = dataset + ": " + str(datetime.datetime.now()) + " - OK! \n"
    except FileNotFoundError:
        log = (
            dataset
            + ": "
            + str(datetime.datetime.now())
            + " - Error! File not Found. \n"
        )

    try:
        logfile = open(
            BLD / "out" / "data" / "supplement_asec" / "format_data_cps_yearly_log.txt"
        )
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

    logfile = open(BLD / "out" / "data" / "format_data_cps_yearly_log.txt", "w")
    for line in entries:
        logfile.write(f"{line}")
