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


def _compile_flow_rates_one_year(year):

    age_min = 20
    age_max = 64

    df_out = pd.DataFrame()

    months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    time_weights = np.full(len(months), np.nan)

    for idx, month in enumerate(months):

        period_to = f"{year}-{month}"
        period_from = f"{str(int(year)-1)}-{month}"

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

        # get total labor force for time weighting
        df_to.loc[:, "employed"] = df_to.labor_force_status_reduced == "employed"
        df_to.loc[:, "employed_weighted"] = df_to.employed * df_to.weight_personal
        df_to.loc[~df_to.employed, "employed_weighted"] = 0
        df_to.employed_weighted = df_to.employed_weighted.astype(float)

        df_to.loc[:, "unemployed"] = df_to.labor_force_status_reduced == "unemployed"
        df_to.loc[:, "unemployed_weighted"] = df_to.unemployed * df_to.weight_personal
        df_to.loc[~df_to.unemployed, "unemployed_weighted"] = 0
        df_to.unemployed_weighted = df_to.unemployed_weighted.astype(float)

        time_weights[idx] = (
            df_to.employed_weighted.sum() + df_to.unemployed_weighted.sum()
        )

        # select entries for which 12m transitions are observable
        df_to = df_to.loc[df_to.month_in_sample.isin([5, 6, 7, 8]), :]
        df_to = df_to.loc[(df_to.age >= age_min) * (df_to.age <= age_max), :]
        df_to.loc[:, "age_group"] = df_to.age_group.cat.remove_unused_categories()

        df_from = df_from[df_from.month_in_sample.isin([1, 2, 3, 4])]
        df_from = df_from.loc[(df_from.age >= age_min) * (df_from.age <= age_max), :]
        df_from.loc[:, "age_group"] = df_from.age_group.cat.remove_unused_categories()

        # adjust month in sample for merging
        df_from.loc[:, "month_in_sample"] = df_from.month_in_sample + 4

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
        merge_df.loc[merge_df.no_match == 1, "labor_force_status_reduced"] = np.nan

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
        merge_df.loc[:, "employed"] = merge_df.labor_force_status_reduced == "employed"
        merge_df.loc[:, "unemployed"] = (
            merge_df.labor_force_status_reduced == "unemployed"
        )
        merge_df.loc[:, "employed_12m"] = (
            merge_df.labor_force_status_reduced_12m == "employed"
        )
        merge_df.loc[:, "unemployed_12m"] = (
            merge_df.labor_force_status_reduced_12m == "unemployed"
        )
        merge_df.loc[:, "transition_eu"] = merge_df.employed_12m * merge_df.unemployed
        merge_df.loc[:, "transition_ue"] = merge_df.unemployed_12m * merge_df.employed

        merge_df.loc[:, "employed_weighted"] = merge_df.employed * merge_df.weight_long
        merge_df.loc[:, "unemployed_weighted"] = (
            merge_df.unemployed * merge_df.weight_long
        )
        merge_df.loc[:, "employed_12m_weighted"] = (
            merge_df.employed_12m * merge_df.weight_long
        )
        merge_df.loc[:, "unemployed_12m_weighted"] = (
            merge_df.unemployed_12m * merge_df.weight_long
        )
        merge_df.loc[:, "transition_eu_weighted"] = (
            merge_df.transition_eu * merge_df.weight_long
        )
        merge_df.loc[:, "transition_ue_weighted"] = (
            merge_df.transition_ue * merge_df.weight_long
        )

        # computed average rates
        df_avg = (
            merge_df.loc[
                :,
                [
                    "year",
                    "month",
                    "employed_weighted",
                    "unemployed_weighted",
                    "employed_12m_weighted",
                    "unemployed_12m_weighted",
                    "transition_eu_weighted",
                    "transition_ue_weighted",
                ],
            ]
            .groupby(["year", "month"])
            .sum()
        )

        df_avg = df_avg.rename(
            columns={
                "employed_weighted": "employed",
                "unemployed_weighted": "unemployed",
                "employed_12m_weighted": "employed_12m",
                "unemployed_12m_weighted": "unemployed_12m",
                "transition_eu_weighted": "transition_eu",
                "transition_ue_weighted": "transition_ue",
            }
        )

        df_avg.loc[:, "u_rate_avg"] = df_avg.unemployed / (
            df_avg.employed + df_avg.unemployed
        )
        df_avg.loc[:, "eu_rate_avg"] = df_avg.transition_eu / df_avg.employed_12m
        df_avg.loc[:, "ue_rate_avg"] = df_avg.transition_ue / df_avg.unemployed_12m

        df_tmp = (
            merge_df.loc[
                :,
                [
                    "year",
                    "month",
                    "age_group",
                    "employed_weighted",
                    "unemployed_weighted",
                    "employed_12m_weighted",
                    "unemployed_12m_weighted",
                    "transition_eu_weighted",
                    "transition_ue_weighted",
                ],
            ]
            .groupby(["year", "month", "age_group"])
            .sum()
        )

        df_tmp = df_tmp.rename(
            columns={
                "employed_weighted": "employed",
                "unemployed_weighted": "unemployed",
                "employed_12m_weighted": "employed_12m",
                "unemployed_12m_weighted": "unemployed_12m",
                "transition_eu_weighted": "transition_eu",
                "transition_ue_weighted": "transition_ue",
            }
        )

        df_tmp.loc[:, "u_rate"] = df_tmp.unemployed / (
            df_tmp.employed + df_tmp.unemployed
        )
        df_tmp.loc[:, "eu_rate"] = df_tmp.transition_eu / df_tmp.employed_12m
        df_tmp.loc[:, "ue_rate"] = df_tmp.transition_ue / df_tmp.unemployed_12m

        # add average rates
        df_tmp = pd.merge(
            left=df_tmp,
            right=df_avg.loc[:, ["u_rate_avg", "eu_rate_avg", "ue_rate_avg"]],
            left_index=True,
            right_index=True,
            how="left",
        )

        # compute relative rates
        df_tmp.loc[:, "u_rate_rel"] = df_tmp.u_rate / df_tmp.u_rate_avg
        df_tmp.loc[:, "eu_rate_rel"] = df_tmp.eu_rate / df_tmp.eu_rate_avg
        df_tmp.loc[:, "ue_rate_rel"] = df_tmp.ue_rate / df_tmp.ue_rate_avg

        # drop unused columns
        df_tmp = df_tmp[
            ["u_rate", "u_rate_rel", "eu_rate", "eu_rate_rel", "ue_rate", "ue_rate_rel"]
        ]

        df_out = pd.concat([df_out, df_tmp], axis=0)

    # get averages
    df_out = df_out.groupby(level=["age_group", "year"]).mean()

    df_out.index = df_out.index.reorder_levels(order=["year", "age_group"])

    return df_out


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


def _compile_flow_rates_df(years):

    df_out = pd.DataFrame()
    for year in years:
        df_tmp = _compile_flow_rates_one_year(year)
        df_out = pd.concat([df_out, df_tmp], axis=0)

    return df_out


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    years = [
        "1990",
        "1991",
        "1992",
        "1993",
        "1994",
        "1995",
        "1996",
        "1997",
        "1998",
        "1999",
        "2000",
        "2001",
        "2002",
        "2003",
        "2004",
        "2005",
        "2006",
        "2007",
        "2008",
        "2009",
        "2010",
        "2011",
        "2012",
        "2013",
        "2014",
        "2015",
        "2016",
        "2017",
        "2018",
        "2019",
    ]

    df_out = _compile_flow_rates_df(years)

    df_out.to_csv(BLD / "out" / "datasets" / "cps_12m_flow_rates.csv", index=True)
