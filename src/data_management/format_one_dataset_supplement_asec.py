"""Format CPS ASEC supplement raw data."""
import json
import sys
from pathlib import Path

import numpy as np
import pandas as pd

from src.config import BLD, DAT, SRC
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


def _clean_variables(df_in, specs):
    # clean answer codes
    for col in df_in.columns:
        df_in.loc[:, col] = df_in.loc[:, col].replace(
            {
                "NONE",
                np.nan,
                "Blank",
                np.nan,
                "not in universe",
                np.nan,
                "NOT IN UNIVERSE",
                np.nan,
                "Not in universe",
                np.nan,
                "NIU",
                np.nan,
                "-1",
                np.nan,
                "-2",
                "I don't know",
                "-3",
                "refuse to answer",
                "Yes",
                "YES",
                "No",
                "NO",
            },
        )

    for col in [var for var in specs["var_dict"] if "weight_" in var] + [
        "earnings_weekly",
        "hours_worked",
        "unemployment_comp",
        "unemployment_duration",
    ]:
        df_in.loc[:, col] = (
            df_in[col]
            .replace(
                {
                    "None or not in universe": np.nan,
                    "Not in universe or children or Armed Forces": np.nan,
                    "Not in universe or children and Armed Forces": np.nan,
                    "Not in universe or children and": np.nan,
                    "Not in universe or children": np.nan,
                    "Children and Armed Forces": np.nan,
                    "Children or Armed Forces": np.nan,
                    "Supplemental spanish sample": np.nan,
                    "Supplemental Spanish sample": np.nan,
                },
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
        df_in.loc[:, "year"] = specs["out_name"][5:8] + df_in.loc[:, "year"].astype(str)
    elif specs["data_dict"] in dicts_year_2:
        df_in.loc[:, "year"] = specs["out_name"][5:7] + df_in.loc[:, "year"].astype(str)

    # clean age variable
    df_in.loc[:, "age"] = df_in.loc[:, "age"].replace(
        {"80-84 years of age": "82", "85+ years of age": "88"},
    )
    df_in.loc[:, "age"] = pd.to_numeric(df_in.loc[:, "age"]).astype("Int8")

    # clean state codes
    df_in.loc[:, "state"] = df_in.loc[:, "state"].replace(state_codes_dict)

    return df_in


def _clean_one_dataset_yearly(df_in, specs):
    # define columns to be returned and data types
    cols_numeric = [var for var in specs["var_dict"] if "weight_" in var] + [
        "earnings_weekly",
        "hours_worked",
        "unemployment_comp",
        "unemployment_duration",
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

    df_out = df_in
    # clean year variable
    if specs["in_dir"][5:8] == "198":
        df_out.loc[:, specs["var_dict"]["year"]] = (
            "198" + df_out.loc[:, specs["var_dict"]["year"]]
        )
    elif specs["in_dir"][5:8] == "199" and specs["in_dir"][5:9] != "1999":
        df_out.loc[:, specs["var_dict"]["year"]] = (
            "199" + df_out.loc[:, specs["var_dict"]["year"]]
        )

    # create longitudinal match identifier
    df_out.loc[:, "match_identifier"] = df_out.loc[:, cols_match[0]].astype(str)
    for col in cols_match[1:]:
        df_out.loc[:, "match_identifier"] += df_out.loc[:, col].astype(str)

    # set identifier as index
    df_out = df_out.set_index("match_identifier")

    # rename variables to uniform labels
    var_dict = specs["var_dict"]
    var_dict = {v: k for k, v in var_dict.items()}
    df_out = df_out.rename(columns=var_dict)

    # clean variables
    df_out = _clean_variables(df_out, specs)

    # add variables
    df_out = _add_categorical_variables(df_out)

    # drop observations other than males aged 16-64
    age_min = 20
    age_max = 64
    df_out = df_out[df_out.sex == "Male"]
    df_out = df_out[df_out.age >= age_min]
    df_out = df_out[df_out.age <= age_max]

    df_out = df_out.dropna(subset=["earnings_weekly"])

    # reduce educational attainment to three categories
    df_out.loc[:, "education_reduced"] = df_out["education_reduced"].replace(
        {
            "Less than 5th Grade": "High School Dropouts",
            "5th Grade to 12th Grade without Diploma": "High School Dropouts",
            "High School Graduates, No College": "High School Graduates",
            "Some College or Associate Degree": "High School Graduates",
            "Bachelor's degree and higher": "College Graduates",
        },
    )

    # drop unused columns
    df_out = df_out.drop(
        columns=["education", "marital_status", "race", "labor_force_status"],
    )

    # rename columns
    df_out = df_out.rename(
        columns={
            "education_reduced": "education",
            "marital_status_reduced": "marital_status",
            "race_reduced": "race",
            "labor_force_status_reduced": "labor_force_status",
        },
    )

    # add column for grade completed if missing
    if "grade_completed" not in df_out.columns:
        df_out.loc[:, "grade_completed"] = np.nan

    # set data types
    for col in cols_numeric:
        df_out.loc[:, col] = df_out[col].astype("float")

    for col in cols_int:
        df_out.loc[:, col] = df_out[col].astype("int")

    for col in cols_str:
        df_out.loc[:, col] = df_out[col].astype(str)

    for col in cols_categorical:
        df_out.loc[:, col] = df_out[col].astype("category")

    # drop unused columns
    df_out = df_out[cols_out]

    return df_out


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":
    try:
        dataset = sys.argv[1]
    except IndexError:
        dataset = "cpsa_2010-03"

    name_in = dataset + "_raw.csv"
    name_out = dataset + ".csv"
    df_in = pd.read_csv(DAT / "cps" / "supplement_asec" / "temp" / name_in, dtype=str)
    with Path.open(
        SRC / "data_specs" / "data_specs" / "supplement_asec" / f"{dataset}.json",
    ) as file:
        data_specs = json.load(file)
    df_out = _clean_one_dataset_yearly(df_in, data_specs)
    df_out.to_csv(BLD / "out" / "data" / "supplement_asec" / name_out, index=False)
