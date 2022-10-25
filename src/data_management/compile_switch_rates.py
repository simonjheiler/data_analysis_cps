import json
from datetime import datetime

import numpy as np
import pandas as pd

from src.config import DAT
from src.config import SRC

#####################################################
# PARAMETERS
#####################################################

idx = pd.IndexSlice

data_instructions = json.load(open(SRC / "data_specs" / "cps_data_instructions.json"))

data_types_cps_monthly = {
    "match_identifier": str,
    "year": int,
    "month": int,
    "state": str,
    "sex": str,
    "age": "Int8",
    "age_group": "category",
    "race_reduced": "category",
    "education_reduced": "category",
    "labor_force_status_reduced": "category",
    "marital_status_reduced": "category",
    "same_employer": "category",
    "same_occupation": "category",
    "weight_long": float,
    "weight_personal": float,
}

age_groups_thresholds = [
    -np.inf,
    19,
    24,
    29,
    34,
    39,
    44,
    49,
    54,
    59,
    64,
    np.inf,
]
age_groups_labels = [
    "19 and younger",
    "20 to 24",
    "25 to 29",
    "30 to 34",
    "35 to 39",
    "40 to 44",
    "45 to 49",
    "50 to 54",
    "55 to 59",
    "60 to 64",
    "65 and older",
]

cohorts_1_thresholds = [
    -np.inf,
    1904,
    1909,
    1914,
    1919,
    1924,
    1929,
    1934,
    1939,
    1944,
    1949,
    1954,
    1959,
    1964,
    1969,
    1974,
    1979,
    1984,
    1989,
    1994,
    1999,
    2004,
    2009,
    2014,
    2019,
    np.inf,
]
cohorts_1_labels = [
    "1900-1904",
    "1905-1909",
    "1910-1914",
    "1915-1919",
    "1920-1924",
    "1925-1929",
    "1930-1934",
    "1935-1939",
    "1940-1944",
    "1945-1949",
    "1950-1954",
    "1955-1959",
    "1960-1964",
    "1965-1969",
    "1970-1974",
    "1975-1979",
    "1980-1984",
    "1985-1989",
    "1990-1994",
    "1995-1999",
    "2000-2004",
    "2005-2009",
    "2010-2014",
    "2015-2019",
    "2020 and later",
]

cohorts_2_thresholds = [
    -np.inf,
    1909,
    1919,
    1929,
    1939,
    1949,
    1959,
    1969,
    1979,
    1989,
    1999,
    2009,
    2019,
    np.inf,
]
cohorts_2_labels = [
    "before 1909",
    "1910-1919",
    "1920-1929",
    "1930-1939",
    "1940-1949",
    "1950-1959",
    "1960-1969",
    "1970-1979",
    "1980-1989",
    "1990-1999",
    "2000-2009",
    "2010-2019",
    "2020 and later",
]

#####################################################
# FUNCTIONS
#####################################################


def _compile_switch_rates(in_data, out_path):

    cols_analysis = [
        "year",
        "month",
        "state",
        "age",
        "age_group",
        "same_employer",
        "same_occupation",
        "weight_long",
        "weight_personal",
        "weight_bls",
    ]

    # initiate object to store data and iterable
    df = pd.DataFrame(columns=cols_analysis)

    for index, _ in enumerate(in_data):

        # read in data
        in_file = in_data[index]
        df_tmp = pd.read_csv(in_file, dtype=data_types_cps_monthly)

        # drop observations with missing values in required field
        df_tmp = df_tmp.loc[
            np.logical_or(
                df_tmp.loc[:, "month_in_sample"] == 4,
                df_tmp.loc[:, "month_in_sample"] == 8,
            ),
            :,
        ]
        df_tmp = df_tmp.loc[df_tmp.loc[:, "labor_force_status_reduced"] == "employed"]
        df_tmp = df_tmp.loc[
            np.logical_or(
                ~pd.isna(df_tmp.loc[:, "same_employer"]),
                ~pd.isna(df_tmp.loc[:, "same_occupation"]),
            ),
            :,
        ]
        df_tmp.dropna(subset=["age"], inplace=True)

        # drop observations that are out of scope
        df_tmp = df_tmp[df_tmp.age >= 20]
        df_tmp = df_tmp[df_tmp.age <= 64]

        # make sure all required columns exist, if not, fill with nan
        for col in cols_analysis:
            if col not in df_tmp.columns:
                df_tmp.loc[:, col] = np.nan

        # append current data to output df
        df = pd.concat([df, df_tmp[cols_analysis]], axis=0)

    # get additional variables
    df.loc[:, "occ_all"] = np.logical_or(
        df.loc[:, "same_occupation"] == "YES", df.loc[:, "same_occupation"] == "NO"
    )
    df.loc[:, "occ_switch"] = df.loc[:, "same_occupation"] == "NO"

    df.loc[:, "occ_all_weighted"] = df.loc[:, "occ_all"] * df.loc[:, "weight_long"]
    df.loc[:, "occ_switch_weighted"] = (
        df.loc[:, "occ_switch"] * df.loc[:, "weight_long"]
    )

    # summarize by year and age
    df_out = (
        df.loc[
            :,
            [
                "year",
                "age",
                "occ_all",
                "occ_switch",
                "occ_all_weighted",
                "occ_switch_weighted",
            ],
        ]
        .groupby(["year", "age"])
        .sum()
    )
    df_out = df_out.reset_index()
    df_out.loc[:, "birthyear"] = df_out.loc[:, "year"].astype(int) - df_out.loc[
        :, "age"
    ].astype(int)
    df_out.loc[:, "age_group"] = pd.cut(
        df_out.age, bins=age_groups_thresholds, labels=age_groups_labels
    )
    df_out.loc[:, "cohort_1"] = pd.cut(
        df_out.birthyear, bins=cohorts_1_thresholds, labels=cohorts_1_labels
    )
    df_out.loc[:, "cohort_2"] = pd.cut(
        df_out.birthyear, bins=cohorts_2_thresholds, labels=cohorts_2_labels
    )

    # store results
    df_out.to_csv(out_path, index=True)

    return


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    date_start = "1994-02"
    # date_start = datetime.strptime(
    #     data_instructions[survey_name]["date_start"],
    #     data_instructions[survey_name]["date_format"],
    # )
    date_end = datetime.strptime(
        data_instructions["basic_monthly"]["date_end"],
        data_instructions["basic_monthly"]["date_format"],
    )
    frequency = data_instructions["basic_monthly"]["frequency"]
    prefix = data_instructions["basic_monthly"]["prefix"]

    file_names = pd.date_range(date_start, date_end, freq=frequency).strftime(
        data_instructions["basic_monthly"]["date_format"]
    )
    file_names = [f"{prefix}_{file}.csv" for file in file_names]

    deps = [DAT / "cps" / "basic_monthly" / "formatted" / x for x in file_names]
    prod = DAT / "cps" / "basic_monthly" / "results" / "cps_switch_rates_age_cohort.csv"

    _compile_switch_rates(deps, prod)
