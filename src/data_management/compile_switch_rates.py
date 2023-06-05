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
    "occupation_code_1_l1": str,
    "occupation_code_1_l2": str,
    "occupation_code_1_l3": str,
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


def _join_transitions(df_from, df_to, lag):

    year_from = df_from.year.unique()
    year_to = df_to.year.unique()

    if lag == 1:
        month_in_sample_drop = [1, 5]
    elif lag == 3:
        month_in_sample_drop = [1, 2, 3, 5, 6, 7]
    else:
        raise ValueError("lag undefined; please select one of [1, 3]")

    # drop new entrants / re-entrants
    df_to = df_to.drop(df_to[df_to.month_in_sample.isin(month_in_sample_drop)].index)
    df_to.drop(df_to[df_to.no_match == 1].index, inplace=True)
    df_to["month_in_sample"] = df_to["month_in_sample"] - lag

    # for 1994 / 1995 merge in addition on state
    if year_from in [1994, 1995] or year_to in [1994, 1995]:
        out_df = pd.merge(
            df_from,
            df_to[
                [
                    "match_identifier",
                    "state",
                    "month_in_sample",
                    "labor_force_status_reduced",
                    "occupation_code_1_l1",
                    "occupation_code_1_l2",
                    "occupation_code_1_l3",
                ]
            ],
            left_index=False,
            left_on=["match_identifier", "state", "month_in_sample"],
            right_index=False,
            right_on=["match_identifier", "state", "month_in_sample"],
            how="left",
            suffixes=("_from", "_to"),
        )
    else:
        out_df = pd.merge(
            df_from,
            df_to[
                [
                    "match_identifier",
                    "month_in_sample",
                    "labor_force_status_reduced",
                    "occupation_code_1_l1",
                    "occupation_code_1_l2",
                    "occupation_code_1_l3",
                ]
            ],
            left_index=False,
            left_on=["match_identifier", "month_in_sample"],
            right_index=False,
            right_on=["match_identifier", "month_in_sample"],
            how="left",
            suffixes=("_from", "_to"),
        )

    # calculate booleans for separations, matches, labor market entry,
    cols_transitions = [
        f"loss_{lag}m",
        f"finding_{lag}m",
        f"entry_{lag}m",
        f"exit_{lag}m",
        "employer_switch",
        "occupation_switch",
        "occupation_switch_cond",
        f"occ_1_switch_{lag}m",
        f"occ_1_switch_cond_{lag}m",
        f"occ_2_switch_{lag}m",
        f"occ_2_switch_cond_{lag}m",
        f"occ_3_switch_{lag}m",
        f"occ_3_switch_cond_{lag}m",
    ]

    # labor market exit, occupation change (level 1, 2, and 3)
    for col in cols_transitions:
        out_df.loc[:, col] = np.nan

    # for matches and separations, only capture workers that are in the
    # labor force in both months (excluding all 'not in labor force' transitions)
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "employed",
                out_df["labor_force_status_reduced_to"] == "employed",
            ),
            :,
        ].index,
        f"loss_{lag}m",
    ] = False
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "employed",
                out_df["labor_force_status_reduced_to"] == "unemployed",
            ),
            :,
        ].index,
        f"loss_{lag}m",
    ] = True

    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "unemployed",
                out_df["labor_force_status_reduced_to"] == "unemployed",
            ),
            :,
        ].index,
        f"finding_{lag}m",
    ] = False
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "unemployed",
                out_df["labor_force_status_reduced_to"] == "employed",
            ),
            :,
        ].index,
        f"finding_{lag}m",
    ] = True

    # capture all workers
    # (including 'not in labor force' transitions)
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "employed",
                out_df["labor_force_status_reduced_to"] == "employed",
            ),
            :,
        ].index,
        f"exit_{lag}m",
    ] = False
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "employed",
                out_df["labor_force_status_reduced_to"] == "unemployed",
            ),
            :,
        ].index,
        f"exit_{lag}m",
    ] = False
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "employed",
                out_df["labor_force_status_reduced_to"] == "not in labor force",
            ),
            :,
        ].index,
        f"exit_{lag}m",
    ] = True

    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "not in labor force",
                out_df["labor_force_status_reduced_to"] == "employed",
            ),
            :,
        ].index,
        f"entry_{lag}m",
    ] = True
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "not in labor force",
                out_df["labor_force_status_reduced_to"] == "unemployed",
            ),
            :,
        ].index,
        f"entry_{lag}m",
    ] = True
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "not in labor force",
                out_df["labor_force_status_reduced_to"] == "not in labor force",
            ),
            :,
        ].index,
        f"entry_{lag}m",
    ] = False

    # changes in occupation code
    # only for workers that are in the labor force in both periods

    # level 1
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    np.logical_or(
                        out_df["labor_force_status_reduced_from"] == "employed",
                        out_df["labor_force_status_reduced_from"] == "unemployed",
                    ),
                    np.logical_or(
                        out_df["labor_force_status_reduced_to"] == "employed",
                        out_df["labor_force_status_reduced_to"] == "unemployed",
                    ),
                ),
                out_df["occupation_code_1_l1_from"]
                != out_df["occupation_code_1_l1_to"],
            ),
            :,
        ].index,
        f"occ_1_switch_{lag}m",
    ] = True
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    np.logical_or(
                        out_df["labor_force_status_reduced_from"] == "employed",
                        out_df["labor_force_status_reduced_from"] == "unemployed",
                    ),
                    np.logical_or(
                        out_df["labor_force_status_reduced_to"] == "employed",
                        out_df["labor_force_status_reduced_to"] == "unemployed",
                    ),
                ),
                out_df["occupation_code_1_l1_from"]
                == out_df["occupation_code_1_l1_to"],
            ),
            :,
        ].index,
        f"occ_1_switch_{lag}m",
    ] = False

    # level 2
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    np.logical_or(
                        out_df["labor_force_status_reduced_from"] == "employed",
                        out_df["labor_force_status_reduced_from"] == "unemployed",
                    ),
                    np.logical_or(
                        out_df["labor_force_status_reduced_to"] == "employed",
                        out_df["labor_force_status_reduced_to"] == "unemployed",
                    ),
                ),
                out_df["occupation_code_1_l2_from"]
                != out_df["occupation_code_1_l2_to"],
            ),
            :,
        ].index,
        f"occ_2_switch_{lag}m",
    ] = True
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    np.logical_or(
                        out_df["labor_force_status_reduced_from"] == "employed",
                        out_df["labor_force_status_reduced_from"] == "unemployed",
                    ),
                    np.logical_or(
                        out_df["labor_force_status_reduced_to"] == "employed",
                        out_df["labor_force_status_reduced_to"] == "unemployed",
                    ),
                ),
                out_df["occupation_code_1_l2_from"]
                == out_df["occupation_code_1_l2_to"],
            ),
            :,
        ].index,
        f"occ_2_switch_{lag}m",
    ] = False
    # level 2
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    np.logical_or(
                        out_df["labor_force_status_reduced_from"] == "employed",
                        out_df["labor_force_status_reduced_from"] == "unemployed",
                    ),
                    np.logical_or(
                        out_df["labor_force_status_reduced_to"] == "employed",
                        out_df["labor_force_status_reduced_to"] == "unemployed",
                    ),
                ),
                out_df["occupation_code_1_l2_from"]
                != out_df["occupation_code_1_l2_to"],
            ),
            :,
        ].index,
        f"occ_2_switch_{lag}m",
    ] = True
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    np.logical_or(
                        out_df["labor_force_status_reduced_from"] == "employed",
                        out_df["labor_force_status_reduced_from"] == "unemployed",
                    ),
                    np.logical_or(
                        out_df["labor_force_status_reduced_to"] == "employed",
                        out_df["labor_force_status_reduced_to"] == "unemployed",
                    ),
                ),
                out_df["occupation_code_1_l2_from"]
                == out_df["occupation_code_1_l2_to"],
            ),
            :,
        ].index,
        f"occ_2_switch_{lag}m",
    ] = False

    # level 3
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    np.logical_or(
                        out_df["labor_force_status_reduced_from"] == "employed",
                        out_df["labor_force_status_reduced_from"] == "unemployed",
                    ),
                    np.logical_or(
                        out_df["labor_force_status_reduced_to"] == "employed",
                        out_df["labor_force_status_reduced_to"] == "unemployed",
                    ),
                ),
                out_df["occupation_code_1_l3_from"]
                != out_df["occupation_code_1_l3_to"],
            ),
            :,
        ].index,
        f"occ_3_switch_{lag}m",
    ] = True
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    np.logical_or(
                        out_df["labor_force_status_reduced_from"] == "employed",
                        out_df["labor_force_status_reduced_from"] == "unemployed",
                    ),
                    np.logical_or(
                        out_df["labor_force_status_reduced_to"] == "employed",
                        out_df["labor_force_status_reduced_to"] == "unemployed",
                    ),
                ),
                out_df["occupation_code_1_l3_from"]
                == out_df["occupation_code_1_l3_to"],
            ),
            :,
        ].index,
        f"occ_3_switch_{lag}m",
    ] = False

    # employer switch based on self-reported flag
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    out_df["labor_force_status_reduced_from"] == "employed",
                    out_df["labor_force_status_reduced_to"] == "employed",
                ),
                out_df["same_employer"] == "YES",
            ),
            :,
        ].index,
        "employer_switch",
    ] = False
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    out_df["labor_force_status_reduced_from"] == "employed",
                    out_df["labor_force_status_reduced_to"] == "employed",
                ),
                out_df["same_employer"] == "NO",
            ),
            :,
        ].index,
        "employer_switch",
    ] = True

    # occupation switch based on self-reported flag
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    out_df["labor_force_status_reduced_from"] == "employed",
                    out_df["labor_force_status_reduced_to"] == "employed",
                ),
                out_df["same_occupation"] == "YES",
            ),
            :,
        ].index,
        "occupation_switch",
    ] = False
    out_df.loc[
        out_df.loc[
            np.logical_and(
                np.logical_and(
                    out_df["labor_force_status_reduced_from"] == "employed",
                    out_df["labor_force_status_reduced_to"] == "employed",
                ),
                out_df["same_occupation"] == "NO",
            ),
            :,
        ].index,
        "occupation_switch",
    ] = True

    # construct occupation switch conditional on employer switch
    out_df.loc[
        np.logical_and(
            out_df["employer_switch"] == True,
            out_df["occupation_switch"] == True,
        ),
        "occupation_switch_cond",
    ] = True
    out_df.loc[
        np.logical_and(
            out_df["employer_switch"] == True,
            out_df["occupation_switch"] == False,
        ),
        "occupation_switch_cond",
    ] = False

    out_df.loc[
        np.logical_and(
            out_df["employer_switch"] == True,
            out_df["occ_1_switch_1m"] == True,
        ),
        f"occ_1_switch_cond_{lag}m",
    ] = True
    out_df.loc[
        np.logical_and(
            out_df["employer_switch"] == True,
            out_df["occ_1_switch_1m"] == False,
        ),
        f"occ_1_switch_cond_{lag}m",
    ] = False

    out_df.loc[
        np.logical_and(
            out_df["employer_switch"] == True,
            out_df["occ_2_switch_1m"] == True,
        ),
        f"occ_2_switch_cond_{lag}m",
    ] = True
    out_df.loc[
        np.logical_and(
            out_df["employer_switch"] == True,
            out_df["occ_2_switch_1m"] == False,
        ),
        f"occ_2_switch_cond_{lag}m",
    ] = False

    out_df.loc[
        np.logical_and(
            out_df["employer_switch"] == True,
            out_df["occ_3_switch_1m"] == True,
        ),
        f"occ_3_switch_cond_{lag}m",
    ] = True
    out_df.loc[
        np.logical_and(
            out_df["employer_switch"] == True,
            out_df["occ_3_switch_1m"] == False,
        ),
        f"occ_3_switch_cond_{lag}m",
    ] = False

    # convert to numeric
    for col in cols_transitions:
        out_df.loc[:, col] = out_df.loc[:, col].astype(float)

    # remove unused columns and relabel changed column to original names
    out_df = out_df.drop(columns=["labor_force_status_reduced_to"])
    out_df = out_df.rename(
        columns={"labor_force_status_reduced_from": "labor_force_status_reduced"}
    )

    return out_df


def _compile_switch_rates(in_data, out_path):

    cols_agg = [
        "time_unit",
        "age",
    ]

    cols_sum = [
        "employed",
        "unemployed",
        "not_in_labor_force",
        "finding_1m",
        "loss_1m",
        "entry_1m",
        "exit_1m",
        "employer_switch",
        "occupation_switch",
        "occupation_switch_cond",
        "occ_1_switch_1m",
        "occ_2_switch_1m",
        "occ_3_switch_1m",
        "occ_1_switch_cond_1m",
        "occ_2_switch_cond_1m",
        "occ_3_switch_cond_1m",
    ]

    cols_sum_weighted = [f"{col}_weighted" for col in cols_sum]

    # initiate object to store data and iterable
    df = pd.DataFrame(columns=cols_agg + cols_sum + cols_sum_weighted)
    periods_iter = in_data[:-1]

    for index, _ in enumerate(periods_iter):

        # read in data
        in_file = in_data[index]
        df_tmp = pd.read_csv(in_file, dtype=data_types_cps_monthly)

        # drop observations with missing values in required field
        df_tmp = df_tmp.dropna(subset=["age"])

        # drop observations with month in sample 4 or 8 (no next month observation available)
        df_tmp = df_tmp.loc[df_tmp.loc[:, "month_in_sample"] != 4]
        df_tmp = df_tmp.loc[df_tmp.loc[:, "month_in_sample"] != 8]

        # drop observations that are out of scope
        df_tmp = df_tmp[df_tmp.age >= 20]
        df_tmp = df_tmp[df_tmp.age <= 64]

        # make sure all required columns exist, if not, fill with nan
        for col in cols_agg:
            if col not in df_tmp.columns:
                df_tmp.loc[:, col] = np.nan

        # construct columns for employed, unemployed, not in labor force
        for status in ["employed", "unemployed"]:
            df_tmp.loc[:, status] = (
                df_tmp.loc[:, "labor_force_status_reduced"] == status
            )
            df_tmp.loc[:, status] = df_tmp.loc[:, status].astype(float)

        df_tmp.loc[:, "not_in_labor_force"] = (
            df_tmp.loc[:, "labor_force_status_reduced"] == "not in labor force"
        )
        df_tmp.loc[:, "not_in_labor_force"] = df_tmp.loc[
            :, "not_in_labor_force"
        ].astype(float)

        # get status and occupation codes next month
        next_df = pd.read_csv(in_data[index + 1], dtype=data_types_cps_monthly)
        df_tmp = _join_transitions(df_tmp, next_df, 1)

        # construct time unit
        df_tmp.loc[:, "time_unit"] = (
            df_tmp.loc[:, "year"].astype(str)
            + "-"
            + df_tmp.loc[:, "month"].astype(str).str.pad(2, fillchar="0")
        )

        # get weighted values
        for col in cols_sum:
            df_tmp.loc[:, f"{col}_weighted"] = (
                df_tmp.loc[:, col] * df_tmp.loc[:, "weight_long"]
            )

        # aggregate data by age
        df_tmp = (
            df_tmp.loc[:, cols_agg + cols_sum + cols_sum_weighted]
            .groupby(["time_unit", "age"])
            .sum()
        )

        # reset_index
        df_tmp = df_tmp.reset_index()

        # append current data to output df
        df = pd.concat([df, df_tmp[cols_agg + cols_sum + cols_sum_weighted]], axis=0)

    # get additional variables
    df.loc[:, "year"] = pd.to_datetime(df.loc[:, "time_unit"]).dt.year.astype(int)
    df.loc[:, "birthyear"] = df.loc[:, "year"].astype(int) - df.loc[:, "age"].astype(
        int
    )

    # sort variables
    df = df[["time_unit", "age", "birthyear"] + cols_sum + cols_sum_weighted]

    # store results
    df.to_csv(out_path)

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
    prod = (
        DAT
        / "cps"
        / "basic_monthly"
        / "results"
        / "cps_transitions_rates_age_cohort_time.csv"
    )

    _compile_switch_rates(deps, prod)
