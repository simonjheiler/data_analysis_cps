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

        # calculate booleans for separations, job finding, labor market exit,
        # labor market entry, employer change (self-reported) occupation change
        # (self-reported), occupation change based on occupation code (level 1, 2,
        # and 3) and occupation change based on occupation code (level 1, 2,
        # and 3) conditional on employer change (self-reported)

        # separation events:
        #   - base is all workers that are currently employed and where next period
        #     labor force status is not unknown
        #   - event is a transition from being employed to being unemployed
        out_df.loc[:, "base_separation"] = np.logical_and(
            out_df.loc[:, "labor_force_status_reduced_from"] == "employed",
            ~out_df.loc[:, "labor_force_status_reduced_to"].isna(),
        )
    out_df.loc[:, "separation"] = np.logical_and(
        out_df["labor_force_status_reduced_from"] == "employed",
        out_df["labor_force_status_reduced_to"] == "unemployed",
    )

    # job finding event:
    #   - base is all workers that are currently unemployed and where next period
    #     labor force status is not unknown
    #   - event is a transition from being unemployed to being employed
    out_df.loc[:, "base_finding"] = np.logical_and(
        out_df.loc[:, "labor_force_status_reduced_from"] == "unemployed",
        ~out_df.loc[:, "labor_force_status_reduced_to"].isna(),
    )
    out_df.loc[:, "finding"] = np.logical_and(
        out_df["labor_force_status_reduced_from"] == "unemployed",
        out_df["labor_force_status_reduced_to"] == "employed",
    )

    # labor force exit event:
    #   - base is all workers that are currently in the labor force and where next
    #     period labor force status is not unknown
    #   - event is transition from in the labor force (employed or unemployed) to
    #     not in the labor force
    out_df.loc[:, "base_exit"] = np.logical_and(
        np.logical_or(
            out_df.labor_force_status_reduced_from == "employed",
            out_df.labor_force_status_reduced_from == "unemployed",
        ),
        ~out_df["labor_force_status_reduced_to"].isna(),
    )
    out_df.loc[:, "exit"] = np.logical_and(
        out_df.loc[:, "base_exit"],
        out_df.labor_force_status_reduced_to == "not in labor force",
    )

    # labor force entry event:
    #   - base is all workers that are currently not in the labor force and where
    #     next period labor force status is not unknown
    #   - event is transition from not in labor force to in the labor force
    #     (employed or unemployed)
    out_df.loc[:, "base_entry"] = np.logical_and(
        out_df.labor_force_status_reduced_from == "not in labor force",
        ~out_df["labor_force_status_reduced_to"].isna(),
    )
    out_df.loc[:, "entry"] = np.logical_and(
        out_df.loc[:, "base_entry"],
        np.logical_or(
            out_df.labor_force_status_reduced_to == "employed",
            out_df.labor_force_status_reduced_to == "unemployed",
        ),
    )

    # employer change event (self-reported):
    #   - base is all workers that are employed in both periods and have
    #     reported ("YES" or "NO") on "same employer" question
    #   - event is reporting "NO"
    out_df.loc[:, "base_employer_change"] = np.logical_and(
        np.logical_and(
            out_df.loc[:, "labor_force_status_reduced_from"] == "employed",
            out_df.loc[:, "labor_force_status_reduced_to"] == "employed",
        ),
        np.logical_or(
            out_df.loc[:, "same_employer"] == "YES",
            out_df.loc[:, "same_employer"] == "NO",
        ),
    )
    out_df.loc[:, "employer_change"] = np.logical_and(
        out_df.loc[:, "base_employer_change"], out_df.loc[:, "same_employer"] == "NO"
    )

    # occupation change event (self-reported):
    #   - base is all workers that are in the labor force in both periods and
    #     have reported ("YES" or "NO") on "same occupation" question
    #   - event is being in the labor force in both periods and reporting "NO"
    out_df.loc[:, "base_occupation_change"] = np.logical_and(
        np.logical_and(
            np.logical_or(
                out_df.loc[:, "labor_force_status_reduced_from"] == "employed",
                out_df.loc[:, "labor_force_status_reduced_from"] == "unemployed",
            ),
            np.logical_or(
                out_df.loc[:, "labor_force_status_reduced_to"] == "employed",
                out_df.loc[:, "labor_force_status_reduced_to"] == "unemployed",
            ),
        ),
        np.logical_or(
            out_df.loc[:, "same_occupation"] == "YES",
            out_df.loc[:, "same_occupation"] == "NO",
        ),
    )
    out_df.loc[:, "occupation_change"] = np.logical_and(
        out_df.loc[:, "base_occupation_change"],
        out_df.loc[:, "same_occupation"] == "NO",
    )

    # occupation change event (based on occupation codes):
    #   - base is all workers that are in the labor force in both periods and where
    #     occupation codes are not unknown for both periods
    #   - event is being in the labor force in both periods and the occupation codes
    #     being not the same for both periods
    for level in ["1", "2", "3"]:
        out_df.loc[:, f"base_occ_{level}_change"] = np.logical_and(
            np.logical_and(
                np.logical_or(
                    out_df.loc[:, "labor_force_status_reduced_from"] == "employed",
                    out_df.loc[:, "labor_force_status_reduced_from"] == "unemployed",
                ),
                np.logical_or(
                    out_df.loc[:, "labor_force_status_reduced_to"] == "employed",
                    out_df.loc[:, "labor_force_status_reduced_to"] == "unemployed",
                ),
            ),
            np.logical_and(
                ~out_df.loc[:, f"occupation_code_1_l{level}_from"].isna(),
                ~out_df.loc[:, f"occupation_code_1_l{level}_to"].isna(),
            ),
        )
        out_df.loc[:, f"occ_{level}_change"] = np.logical_and(
            out_df.loc[:, f"base_occ_{level}_change"],
            (
                out_df.loc[:, f"occupation_code_1_l{level}_from"]
                != out_df.loc[:, f"occupation_code_1_l{level}_to"]
            ),
        )

    # occupation change (self-reported) conditional on employer change (self-reported)
    #   - base is all workers that have reported "NO" on "same employer" questions and
    #     that have reported ("YES" or "NO") on "same occupation" question
    #   - event is reporting "NO" on "same employer" question and "NO" on "same occupation"
    #     question
    out_df.loc[:, "base_occupation_change_cond"] = np.logical_and(
        out_df.loc[:, "base_occupation_change"],
        out_df.loc[:, "employer_change"],
    )
    out_df.loc[:, "occupation_change_cond"] = np.logical_and(
        out_df.loc[:, "base_occupation_change_cond"],
        out_df.loc[:, "same_occupation"] == "NO",
    )

    # occupation change (based on occupation codes) conditional on employer change
    # (self-reported)
    #   - base is all workers that have reported "NO" on "same employer" questions and
    #     that are employed in both periods and where occupation codes are not
    #     unknown for both periods
    #   - event is reporting "NO" on "same employer" question and being in the labor force
    #     in both periods and the occupation codes being not the same for both periods
    for level in ["1", "2", "3"]:
        out_df.loc[:, f"base_occ_{level}_change_cond"] = np.logical_and(
            out_df.loc[:, "employer_change"], out_df.loc[:, f"base_occ_{level}_change"]
        )
        out_df.loc[:, f"occ_{level}_change_cond"] = np.logical_and(
            out_df.loc[:, f"base_occ_{level}_change_cond"],
            out_df.loc[:, f"occupation_code_1_l{level}_from"]
            != out_df.loc[:, f"occupation_code_1_l{level}_to"],
        )

    # combinations of occupation change (based on occupation codes) and employer change
    # (self-reported), i.e.
    #   - same employer, same occupation
    #   - same employer, different occupation
    #   - different employer, same occupation
    #   - different employer, different occupation
    #
    #   - base is all workers that have reported ("YES" or "NO") on "same employer" questions
    #     and that are employed in both periods and where occupation codes are not
    #     unknown for both periods
    #   - events are
    #       + reporting "YES" on "same employer" question and being employed in both periods
    #         and the occupation codes being the same for both periods
    #       + reporting "YES" on "same employer" question and being employer in both periods
    #         and the occupation codes being not the same for both periods
    #       + reporting "NO" on "same employer" question and being employed in both periods
    #         and the occupation codes being the same for both periods
    #       + reporting "NO" on "same employer" question and being employer in both periods
    #         and the occupation codes being not the same for both periods
    out_df.loc[:, "base_j2j"] = np.logical_and(
        out_df.loc[:, "base_employer_change"], out_df.loc[:, "base_occ_1_change"]
    )
    out_df.loc[:, "j2j_same_employer_same_occupation"] = np.logical_and(
        out_df.loc[:, "base_j2j"],
        np.logical_and(
            out_df.loc[:, "same_employer"] == "YES",
            (
                out_df.loc[:, "occupation_code_1_l1_from"]
                == out_df.loc[:, "occupation_code_1_l1_to"]
            ),
        ),
    )
    out_df.loc[:, "j2j_same_employer_different_occupation"] = np.logical_and(
        out_df.loc[:, "base_j2j"],
        np.logical_and(
            out_df.loc[:, "same_employer"] == "YES",
            (
                out_df.loc[:, "occupation_code_1_l1_from"]
                != out_df.loc[:, "occupation_code_1_l1_to"]
            ),
        ),
    )
    out_df.loc[:, "j2j_different_employer_same_occupation"] = np.logical_and(
        out_df.loc[:, "base_j2j"],
        np.logical_and(
            out_df.loc[:, "same_employer"] == "NO",
            (
                out_df.loc[:, "occupation_code_1_l1_from"]
                == out_df.loc[:, "occupation_code_1_l1_to"]
            ),
        ),
    )
    out_df.loc[:, "j2j_different_employer_different_occupation"] = np.logical_and(
        out_df.loc[:, "base_j2j"],
        np.logical_and(
            out_df.loc[:, "same_employer"] == "NO",
            (
                out_df.loc[:, "occupation_code_1_l1_from"]
                != out_df.loc[:, "occupation_code_1_l1_to"]
            ),
        ),
    )

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
        "separation",
        "finding",
        "entry",
        "exit",
        "employer_change",
        "occupation_change",
        "occupation_change_cond",
        "occ_1_change",
        "occ_2_change",
        "occ_3_change",
        "occ_1_change_cond",
        "occ_2_change_cond",
        "occ_3_change_cond",
        "base_separation",
        "base_finding",
        "base_entry",
        "base_exit",
        "base_employer_change",
        "base_occupation_change",
        "base_occupation_change_cond",
        "base_occ_1_change",
        "base_occ_2_change",
        "base_occ_3_change",
        "base_occ_1_change_cond",
        "base_occ_2_change_cond",
        "base_occ_3_change_cond",
        "base_j2j",
        "j2j_same_employer_same_occupation",
        "j2j_same_employer_different_occupation",
        "j2j_different_employer_same_occupation",
        "j2j_different_employer_different_occupation",
    ]

    cols_sum_weighted = [f"{col}_weighted" for col in cols_sum]

    # initiate object to store data and iterable
    df = pd.DataFrame(columns=cols_agg + cols_sum + cols_sum_weighted)
    periods_iter = in_data[:-1]

    for index, _ in enumerate(periods_iter):

        # read in data
        in_file = in_data[index]
        print(f"aggregating dataset {in_file}")
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

        # convert boolean columns to numeric
        for col in cols_sum:
            df_tmp.loc[:, col] = df_tmp.loc[:, col].astype(float)

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

    date_start = "1996-01"
    # date_end = "2010-01"
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
