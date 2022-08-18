import json

import numpy as np
import pandas as pd

from src.config import BLD
from src.config import SRC


#####################################################
# PARAMETERS
#####################################################

idx = pd.IndexSlice

cps_data_instructions = json.load(
    open(SRC / "data_specs" / "cps_data_instructions.json")
)

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
    "weight_long": float,
    "weight_personal": float,
}


#####################################################
# FUNCTIONS
#####################################################


def _compile_flow_rates_df():

    year = "2001"
    month = "01"

    # date_start = cps_data_instructions["monthly"]["date_start"]
    # date_end = cps_data_instructions["monthly"]["date_end"]

    period_to = f"{year}-{month}"
    period_from = f"{str(int(year)-1)}-{month}"

    # cols_flows = [
    #     "cps_flow_rate_ee",
    #     "cps_flow_rate_en",
    #     "cps_flow_rate_eu",
    #     "cps_flow_rate_ne",
    #     "cps_flow_rate_nn",
    #     "cps_flow_rate_nu",
    #     "cps_flow_rate_ue",
    #     "cps_flow_rate_un",
    #     "cps_flow_rate_uu",
    # ]
    #
    # education_groups = [
    #     "all",
    #     "Less than a High School Diploma",
    #     "High School Graduates, No College",
    #     "Some College or Associate Degree",
    #     "Bachelor's degree and higher",
    # ]

    filename_from = f"cpsb_{period_from}.csv"
    filename_to = f"cpsb_{period_to}.csv"

    # read in and merge data
    df_from = pd.read_csv(
        BLD / "out" / "data" / "basic_monthly" / filename_from,
        dtype=data_types_cps_monthly,
    )

    df_to = pd.read_csv(
        BLD / "out" / "data" / "basic_monthly" / filename_to,
        dtype=data_types_cps_monthly,
    )

    # select entries for which 12m transitions are observable
    df_to = df_to[df_to.month_in_sample.isin([5, 6, 7, 8])]

    df_from = df_from[df_from.month_in_sample.isin([1, 2, 3, 4])]
    df_from["month_in_sample"] = df_from["month_in_sample"] + 4

    # merge data
    merge_df = pd.merge(
        left=df_to,
        right=df_from[
            [
                "match_identifier",
                "month_in_sample",
                "labor_force_status_reduced",
                "weight_long",
            ]
        ],
        left_index=False,
        left_on=["match_identifier", "month_in_sample"],
        right_index=False,
        right_on=["match_identifier", "month_in_sample"],
        how="inner",
        suffixes=("", "_12m"),
    )

    # remove matched information for entries with no_match flag
    merge_df[merge_df.no_match == 1].loc[:, "labor_force_status_reduced_to"] = np.nan

    # reduce educational attainment to four categories
    merge_df.loc[:, "education_reduced"] = merge_df["education_reduced"].replace(
        {
            "Less than 5th Grade": "Less than a High School Diploma",
            "5th Grade to 12th Grade without Diploma": "Less than a High School Diploma",
        }
    )

    # drop observations with missing information for transition
    merge_df.dropna(
        subset=[
            "labor_force_status_reduced_12m",
            "labor_force_status_reduced",
            "weight_long_12m",
            "weight_long",
        ],
        inplace=True,
    )

    # calculate transitions
    # transition, dist_init, dist_final = _get_transitions(
    #     merge_df["labor_force_status_reduced_12m"],
    #     merge_df["labor_force_status_reduced"],
    #     merge_df["weight_long"],
    # )

    # try:
    #     flow_rates.loc[period, idx[:, "all"]] = transition.stack().values
    # except ValueError:
    #     flow_rates.loc[period, idx[:, "all"]] = np.full(
    #         [transition.shape[0] * transition.shape[1]], np.nan
    #     )
    #
    # for group in education_groups[1:]:
    #     transition, dist_init, dist_final = _get_transitions(
    #         merge_df["labor_force_status_reduced_from"][
    #             merge_df["education_reduced"] == group
    #         ],
    #         merge_df["labor_force_status_reduced_to"][
    #             merge_df["education_reduced"] == group
    #         ],
    #         merge_df["weight_long_from"][merge_df["education_reduced"] == group],
    #     )
    #
    #     try:
    #         flow_rates.loc[period, idx[:, group]] = transition.stack().values
    #     except ValueError:
    #         flow_rates.loc[period, idx[:, group]] = np.full(
    #             [transition.shape[0] * transition.shape[1]], np.nan
    #         )
    #
    # # align series names and reduce index to single column level
    # flow_rates = flow_rates.rename(
    #     columns={
    #         "all": "",
    #         "Less than a High School Diploma": "_edu_1",
    #         "High School Graduates, No College": "_edu_2",
    #         "Some College or Associate Degree": "_edu_3",
    #         "Bachelor's degree and higher": "_edu_4",
    #     }
    # )
    # flow_rates.columns = [
    #     col[0] + col[1]
    #     for col in zip(
    #         flow_rates.columns.get_level_values(0),
    #         flow_rates.columns.get_level_values(1),
    #     )
    # ]

    return merge_df


def _get_transitions(var_from, var_to, weights):

    var_from.rename("from_" + var_from.name, inplace=True)
    var_to.rename("to_" + var_from.name, inplace=True)

    dist_init = (
        var_from.value_counts().reindex(var_from.cat.categories) / var_from.count()
    )
    dist_final = var_to.value_counts().reindex(var_to.cat.categories) / var_to.count()

    data = pd.concat([var_from, var_to], axis=1)

    trans = pd.DataFrame(
        index=var_from.cat.categories,
        columns=var_to.cat.categories,
    )

    for row in trans.index:
        for col in trans.columns:
            trans.loc[row, col] = weights[
                np.logical_and(data.iloc[:, 0] == row, data.iloc[:, 1] == col)
            ].sum()

    trans = trans.div(trans.sum(axis=1), axis=0)

    return trans, dist_init, dist_final


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    cps_flow_rates = _compile_flow_rates_df()

    cps_flow_rates.to_csv(BLD / "out" / "datasets" / "2001-01_flow_rates_12m.csv")
