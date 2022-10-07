import json

import numpy as np
import pandas as pd

from src.config import BLD
from src.config import DAT
from src.config import SRC


#####################################################
# PARAMETERS
#####################################################

idx = pd.IndexSlice

cps_state_codes = pd.read_csv(DAT / "cps" / "misc" / "cps_us_state_codes.csv")
cpi_deflator = pd.read_csv(
    DAT / "misc" / "cpi_to_1999_conversion.csv",
    names=["to_1999"],
    header=0,
)

data_instructions = json.load(open(SRC / "data_specs" / "cps_data_instructions.json"))
eta_ui_laws = pd.read_csv(
    DAT / "misc" / "eta_ui_laws.csv",
    dtype={
        "year": int,
        "month": int,
        "state": str,
        "qualification_fix": float,
        "qualification_hqw": float,
        "qualification_wba": float,
        "qualification_quarters": float,
        "qualification_weeks": float,
        "comp_wage_hq": float,
        "comp_wage_2hq": float,
        "comp_wage_week": float,
        "comp_wage_year": float,
        "comp_wage_bp": float,
        "comp_dep_fix": float,
        "comp_dep_wba": float,
        "comp_dep_max_fix": float,
        "comp_dep_max_wba": float,
        "comp_fix": float,
        "wba_min_0_dep": float,
        "wba_min_1_dep": float,
        "wba_max_0_dep": float,
        "wba_max_max_dep": float,
        "wba_exempt_fix": float,
        "wba_exempt_wage": float,
        "wba_exempt_wba": float,
        "benefit_weeks_min": float,
        "benefit_weeks_max": float,
    },
)
cps_wage_coefficients = pd.read_csv(
    BLD / "results" / "cps_wage_coefficients.csv", index_col=["year", "state"]
)
cps_log_wage_coefficients = pd.read_csv(
    BLD / "results" / "cps_log_wage_coefficients.csv", index_col=["year", "state"]
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


def _compile_long_monthly_df():

    date_start = data_instructions["basic_monthly"]["date_start"]
    date_end = data_instructions["basic_monthly"]["date_end"]

    # date_start = "1996-01"
    # date_end = "1999-01"

    periods = pd.date_range(start=date_start, end=date_end, freq="MS").strftime("%Y-%m")

    get_transitions = True
    impute_earnings = True
    impute_benefits = False
    deflate_payments = False

    cols_analysis = [
        "year",
        "month",
        "state",
        "sex",
        "age",
        "age_group",
        "marital_status",
        "race",
        "education",
        "spousal_status",
        "working_spouse",
        "labor_force_status",
        "n_children",
        "weight_long",
        "weight_personal",
        "weight_bls",
    ]
    cols_payments = []

    if impute_earnings:
        cols_analysis += [
            "earnings_imputed",
            "log_earnings_imputed",
        ]
        cols_payments += [
            "earnings_imputed",
            "log_earnings_imputed",
        ]

    if impute_benefits:
        cols_analysis += [
            "benefits_imputed",
            "benefits_imputed_deflated",
        ]
        cols_payments += [
            "benefits_imputed",
        ]

    if get_transitions:
        cols_analysis += [
            "separation_1m",
            "match_1m",
            "separation_3m",
            "match_3m",
        ]

    # initiate object to store data and iterable
    analysis_df = pd.DataFrame(columns=cols_analysis)
    periods_iter = periods[:-3]
    periods_plus_1m = periods[1:-2]
    periods_plus_3m = periods[3:]

    for index, period in enumerate(periods_iter):

        # read in data
        filename = "cpsb_" + period + ".csv"
        tmp_df = pd.read_csv(
            DAT / "cps" / "basic_monthly" / filename,
            dtype=data_types_cps_monthly,
        )

        if get_transitions:

            # read in data for month t+1
            filename_next = "cpsb_" + periods_plus_1m[index] + ".csv"
            next_df = pd.read_csv(
                DAT / "cps" / "basic_monthly" / "formatted" / filename_next,
                dtype=data_types_cps_monthly,
            )
            tmp_df = _join_transitions(tmp_df, next_df, 1)

            # read in data for month t+3
            filename_next = "cpsb_" + periods_plus_3m[index] + ".csv"
            next_df = pd.read_csv(
                DAT / "cps" / "basic_monthly" / "formatted" / filename_next,
                dtype=data_types_cps_monthly,
            )
            tmp_df = _join_transitions(tmp_df, next_df, 3)

        # drop observations with missing values in required field
        tmp_df.dropna(subset=["age"], inplace=True)
        tmp_df.dropna(subset=["labor_force_status_reduced"], inplace=True)

        # drop observations that are out of scope
        tmp_df = tmp_df[tmp_df.sex == "MALE"]
        tmp_df = tmp_df[tmp_df.age >= 16]
        tmp_df = tmp_df[tmp_df.age <= 64]

        # impute wages and UI benefits
        if impute_earnings:
            tmp_df = _impute_earnings(tmp_df)
            tmp_df = _impute_log_earnings(tmp_df)
        if impute_benefits:
            tmp_df = _impute_benefits(tmp_df)
            # tmp_df = _impute_log_benefits(tmp_df)

        # deflate wages and benefits
        if deflate_payments:
            tmp_df = _deflate_payments(tmp_df, cols_payments, 1990)

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
        analysis_df = analysis_df.append(tmp_df[cols_analysis])

    return analysis_df


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


def _impute_earnings(df):

    coefficients = cps_wage_coefficients.reset_index()
    coefficients["year"] = coefficients["year"].astype(int)
    coefficients["state"] = coefficients["state"].astype(str)

    df["age_squared"] = np.square(df["age"].astype(float))
    df["d_white"] = (df["race_reduced"] == "white").astype(int)
    df["d_black"] = (df["race_reduced"] == "black").astype(int)
    df["d_married"] = (df["marital_status_reduced"] == "married").astype(int)
    df["d_edu_2"] = (
        df["education_reduced"] == "High School Graduates, No College"
    ).astype(int)
    df["d_edu_3"] = (
        df["education_reduced"] == "Some College or Associate Degree"
    ).astype(int)
    df["d_edu_4"] = (df["education_reduced"] == "Bachelor's degree and higher").astype(
        int
    )
    df["intercept"] = 1.0

    df = pd.merge(
        df,
        coefficients,
        how="left",
        left_on=["year", "state"],
        right_on=["year", "state"],
        suffixes=["", "_coef"],
    )

    cols_covariates = [
        "intercept",
        "age",
        "age_squared",
        "d_white",
        "d_black",
        "d_married",
        "d_edu_2",
        "d_edu_3",
        "d_edu_4",
    ]
    cols_coefficients = [
        "intercept_coef",
        "age_coef",
        "age_squared_coef",
        "d_white_coef",
        "d_black_coef",
        "d_married_coef",
        "d_edu_2_coef",
        "d_edu_3_coef",
        "d_edu_4_coef",
    ]

    df[cols_covariates] = df[cols_covariates].astype(float)
    df[cols_coefficients] = df[cols_coefficients].astype(float)

    df["earnings_imputed"] = np.einsum(
        "ij,ij->i", df[cols_covariates], df[cols_coefficients]
    )
    # df["log_earnings_imputed"] = np.log(df["earnings_imputed"])

    df = df.drop(
        columns=[
            "age_squared",
            "d_white",
            "d_black",
            "d_married",
            "d_edu_2",
            "d_edu_3",
            "d_edu_4",
            "intercept",
        ]
        + cols_coefficients
    )

    return df


def _impute_log_earnings(df):

    coefficients = cps_log_wage_coefficients.reset_index()
    coefficients["year"] = coefficients["year"].astype(int)
    coefficients["state"] = coefficients["state"].astype(str)

    df["age_squared"] = np.square(df["age"].astype(float))
    df["d_white"] = (df["race_reduced"] == "white").astype(int)
    df["d_black"] = (df["race_reduced"] == "black").astype(int)
    df["d_married"] = (df["marital_status_reduced"] == "married").astype(int)
    df["d_edu_2"] = (
        df["education_reduced"] == "High School Graduates, No College"
    ).astype(int)
    df["d_edu_3"] = (
        df["education_reduced"] == "Some College or Associate Degree"
    ).astype(int)
    df["d_edu_4"] = (df["education_reduced"] == "Bachelor's degree and higher").astype(
        int
    )
    df["intercept"] = 1.0

    df = pd.merge(
        df,
        coefficients,
        how="left",
        left_on=["year", "state"],
        right_on=["year", "state"],
        suffixes=["", "_coef"],
    )

    cols_covariates = [
        "intercept",
        "age",
        "age_squared",
        "d_white",
        "d_black",
        "d_married",
        "d_edu_2",
        "d_edu_3",
        "d_edu_4",
    ]
    cols_coefficients = [
        "intercept_coef",
        "age_coef",
        "age_squared_coef",
        "d_white_coef",
        "d_black_coef",
        "d_married_coef",
        "d_edu_2_coef",
        "d_edu_3_coef",
        "d_edu_4_coef",
    ]

    df[cols_covariates] = df[cols_covariates].astype(float)
    df[cols_coefficients] = df[cols_coefficients].astype(float)

    df["log_earnings_imputed"] = np.einsum(
        "ij,ij->i", df[cols_covariates], df[cols_coefficients]
    )
    # df["earnings_imputed"] = np.exp(df["log_earnings_imputed"])

    df = df.drop(
        columns=[
            "age_squared",
            "d_white",
            "d_black",
            "d_married",
            "d_edu_2",
            "d_edu_3",
            "d_edu_4",
            "intercept",
        ]
        + cols_coefficients
    )

    return df


def _impute_benefits(data_df):
    # merge ETA unemployment insurance calculation rules to data
    data_df = pd.merge_asof(
        data_df.sort_values(by="month"),
        eta_ui_laws[
            [
                "year",
                "state",
                "month",
                "comp_wage_hq",
                "comp_wage_2hq",
                "comp_wage_week",
                "comp_wage_year",
                "comp_wage_bp",
                "comp_dep_fix",
                "comp_dep_wba",
                "comp_dep_max_fix",
                "comp_dep_max_wba",
                "comp_fix",
                "wba_min_0_dep",
                "wba_min_1_dep",
                "wba_max_0_dep",
                "wba_max_max_dep",
            ]
        ].sort_values(by="month"),
        left_on="month",
        right_on="month",
        left_by=["year", "state"],
        right_by=["year", "state"],
    )

    # compute inputs for benefit imputation
    data_df["earnings_hq"] = data_df["earnings_imputed"] * 13
    data_df["earnings_2hq"] = data_df["earnings_imputed"] * 26
    data_df["earnings_week"] = data_df["earnings_imputed"]
    data_df["earnings_year"] = data_df["earnings_imputed"] * 52
    data_df["earnings_bp"] = data_df["earnings_imputed"] * 65

    # calculate benefits
    data_df["wba_comp"] = (
        np.amax(
            (
                data_df["earnings_hq"] * data_df["comp_wage_hq"],
                data_df["earnings_2hq"] * data_df["comp_wage_2hq"],
                data_df["earnings_week"] * data_df["comp_wage_week"],
                data_df["earnings_year"] * data_df["comp_wage_year"],
                data_df["earnings_bp"] * data_df["comp_wage_bp"],
            ),
            axis=0,
        )
        + data_df["comp_fix"]
    )

    # benefits from dependent allowance
    data_df.loc[:, "n_children"] = data_df.n_children.replace({np.nan: 0.0})
    data_df["n_dep"] = (
        np.logical_or(
            data_df["spousal_status"] == "unemployed partner",
            data_df["spousal_status"] == "non-working partner",
        )
        + data_df["n_children"]
    )
    data_df["wba_min"] = (data_df["n_dep"] == 0) * data_df["wba_min_0_dep"] + (
        data_df["n_dep"] > 0
    ) * data_df["wba_min_0_dep"]
    data_df["wba_max"] = (data_df["n_dep"] == 0) * data_df["wba_max_0_dep"] + (
        data_df["n_dep"] > 0
    ) * data_df["wba_max_max_dep"]

    data_df["wba_dep"] = np.amax(
        (
            np.amin(
                (
                    data_df["n_dep"] * data_df["comp_dep_fix"],
                    data_df["comp_dep_max_fix"],
                ),
                axis=0,
            ),
            np.amin(
                (
                    data_df["n_dep"] * data_df["comp_dep_wba"] * data_df["wba_comp"],
                    data_df["comp_dep_max_wba"] * data_df["wba_comp"],
                ),
                axis=0,
            ),
        ),
        axis=0,
    )

    data_df["wba"] = np.sum(data_df[["wba_comp", "wba_dep"]], axis=1)

    data_df["wba"] = np.amin((data_df["wba"], data_df["wba_max"]), axis=0)
    data_df["wba"] = np.amax((data_df["wba"], data_df["wba_min"]), axis=0)

    # store imputed benefits and log imputed benefits
    data_df["benefits_imputed"] = data_df["wba"]
    # data_df["log_benefits_imputed"] = np.log(data_df["benefits_imputed"])

    # drop calculation columns
    data_df = data_df.drop(
        columns=[
            "wba",
            "wba_min",
            "wba_max",
            "wba_comp",
            "wba_dep",
            "comp_wage_hq",
            "comp_wage_2hq",
            "comp_wage_week",
            "comp_wage_year",
            "comp_wage_bp",
            "comp_dep_fix",
            "comp_dep_wba",
            "comp_dep_max_fix",
            "comp_dep_max_wba",
            "comp_fix",
            "wba_min_0_dep",
            "wba_min_1_dep",
            "wba_max_0_dep",
            "wba_max_max_dep",
            "earnings_hq",
            "earnings_2hq",
            "earnings_week",
            "earnings_year",
            "earnings_bp",
            "n_dep",
        ]
    )

    return data_df


def _impute_log_benefits(data_df):
    # merge ETA unemployment insurance calculation rules to data
    data_df = pd.merge_asof(
        data_df.sort_values(by="month"),
        eta_ui_laws[
            [
                "year",
                "state",
                "month",
                "comp_wage_hq",
                "comp_wage_2hq",
                "comp_wage_week",
                "comp_wage_year",
                "comp_wage_bp",
                "comp_dep_fix",
                "comp_dep_wba",
                "comp_dep_max_fix",
                "comp_dep_max_wba",
                "comp_fix",
                "wba_min_0_dep",
                "wba_min_1_dep",
                "wba_max_0_dep",
                "wba_max_max_dep",
            ]
        ].sort_values(by="month"),
        left_on="month",
        right_on="month",
        left_by=["year", "state"],
        right_by=["year", "state"],
    )

    # compute inputs for benefit imputation
    data_df["earnings_hq"] = np.exp(data_df["log_earnings_imputed"]) * 13
    data_df["earnings_2hq"] = np.exp(data_df["log_earnings_imputed"]) * 26
    data_df["earnings_week"] = np.exp(data_df["log_earnings_imputed"])
    data_df["earnings_year"] = np.exp(data_df["log_earnings_imputed"]) * 52
    data_df["earnings_bp"] = np.exp(data_df["log_earnings_imputed"]) * 65

    # calculate benefits
    data_df["wba_comp"] = (
        np.amax(
            (
                data_df["earnings_hq"] * data_df["comp_wage_hq"],
                data_df["earnings_2hq"] * data_df["comp_wage_2hq"],
                data_df["earnings_week"] * data_df["comp_wage_week"],
                data_df["earnings_year"] * data_df["comp_wage_year"],
                data_df["earnings_bp"] * data_df["comp_wage_bp"],
            ),
            axis=0,
        )
        + data_df["comp_fix"]
    )

    # benefits from dependent allowance
    data_df.loc[:, "n_children"] = data_df.n_children.replace({np.nan: 0.0})
    data_df["n_dep"] = (
        np.logical_or(
            data_df["spousal_status"] == "unemployed partner",
            data_df["spousal_status"] == "non-working partner",
        )
        + data_df["n_children"]
    )
    data_df["wba_min"] = (data_df["n_dep"] == 0) * data_df["wba_min_0_dep"] + (
        data_df["n_dep"] > 0
    ) * data_df["wba_min_0_dep"]
    data_df["wba_max"] = (data_df["n_dep"] == 0) * data_df["wba_max_0_dep"] + (
        data_df["n_dep"] > 0
    ) * data_df["wba_max_max_dep"]

    data_df["wba_dep"] = np.amax(
        (
            np.amin(
                (
                    data_df["n_dep"] * data_df["comp_dep_fix"],
                    data_df["comp_dep_max_fix"],
                ),
                axis=0,
            ),
            np.amin(
                (
                    data_df["n_dep"] * data_df["comp_dep_wba"] * data_df["wba_comp"],
                    data_df["comp_dep_max_wba"] * data_df["wba_comp"],
                ),
                axis=0,
            ),
        ),
        axis=0,
    )

    data_df["wba"] = np.sum(data_df[["wba_comp", "wba_dep"]], axis=1)

    data_df["wba"] = np.amin((data_df["wba"], data_df["wba_max"]), axis=0)
    data_df["wba"] = np.amax((data_df["wba"], data_df["wba_min"]), axis=0)

    # store imputed benefits and log imputed benefits
    # data_df["benefits_imputed"] = data_df["wba"]
    data_df["log_benefits_imputed"] = np.log(data_df["wba"])

    # drop calculation columns
    data_df = data_df.drop(
        columns=[
            "wba",
            "wba_min",
            "wba_max",
            "wba_comp",
            "wba_dep",
            "comp_wage_hq",
            "comp_wage_2hq",
            "comp_wage_week",
            "comp_wage_year",
            "comp_wage_bp",
            "comp_dep_fix",
            "comp_dep_wba",
            "comp_dep_max_fix",
            "comp_dep_max_wba",
            "comp_fix",
            "wba_min_0_dep",
            "wba_min_1_dep",
            "wba_max_0_dep",
            "wba_max_max_dep",
            "earnings_hq",
            "earnings_2hq",
            "earnings_week",
            "earnings_year",
            "earnings_bp",
            "n_dep",
        ]
    )

    return data_df


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
    df_to.drop(
        df_to[df_to.month_in_sample.isin(month_in_sample_drop)].index, inplace=True
    )
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
                ]
            ],
            left_index=False,
            left_on=["match_identifier", "state", "month_in_sample"],
            right_index=False,
            right_on=["match_identifier", "state", "month_in_sample"],
            how="left",
            suffixes=["_from", "_to"],
        )
    else:
        out_df = pd.merge(
            df_from,
            df_to[
                ["match_identifier", "month_in_sample", "labor_force_status_reduced"]
            ],
            left_index=False,
            left_on=["match_identifier", "month_in_sample"],
            right_index=False,
            right_on=["match_identifier", "month_in_sample"],
            how="left",
            suffixes=["_from", "_to"],
        )

    # remove matched information for entries with no_match flag

    # calculate booleans for separations and matches
    out_df.loc[:, "separation_" + str(lag) + "m"] = np.nan
    out_df.loc[:, "match_" + str(lag) + "m"] = np.nan

    # only capture workers that are in the labor force in both months
    # (excluding all 'not in labor force' transitions)
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "employed",
                out_df["labor_force_status_reduced_to"] == "employed",
            ),
            :,
        ].index,
        "separation_" + str(lag) + "m",
    ] = False
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "employed",
                out_df["labor_force_status_reduced_to"] == "unemployed",
            ),
            :,
        ].index,
        "separation_" + str(lag) + "m",
    ] = True

    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "unemployed",
                out_df["labor_force_status_reduced_to"] == "unemployed",
            ),
            :,
        ].index,
        "match_" + str(lag) + "m",
    ] = False
    out_df.loc[
        out_df.loc[
            np.logical_and(
                out_df["labor_force_status_reduced_from"] == "unemployed",
                out_df["labor_force_status_reduced_to"] == "employed",
            ),
            :,
        ].index,
        "match_" + str(lag) + "m",
    ] = True

    # capture all workers
    # (including 'not in labor force' transitions)
    # out_df.loc[out_df.loc[np.logical_and(
    #     out_df["labor_force_status_reduced_from"] == "employed",
    #     out_df["labor_force_status_reduced_to"] == "employed",
    # ), :].index, "separation_" + str(lag) + "m"] = False
    # out_df.loc[out_df.loc[
    #     np.logical_or(
    #         np.logical_and(
    #             out_df["labor_force_status_reduced_from"] == "employed",
    #             out_df["labor_force_status_reduced_to"] == "unemployed",
    #         ),
    #         np.logical_and(
    #             out_df["labor_force_status_reduced_from"] == "employed",
    #             out_df["labor_force_status_reduced_to"] == "not in labor force",
    #         ),
    #     ), :
    # ].index, "separation_" + str(lag) + "m"] = True
    #
    # out_df.loc[out_df.loc[
    #     np.logical_or.reduce(
    #         [
    #             np.logical_and(
    #                 out_df["labor_force_status_reduced_from"] == "unemployed",
    #                 out_df["labor_force_status_reduced_to"] == "unemployed",
    #             ),
    #             np.logical_and(
    #                 out_df["labor_force_status_reduced_from"] == "not in labor force",
    #                 out_df["labor_force_status_reduced_to"] == "not in labor force",
    #             ),
    #             np.logical_and(
    #                 out_df["labor_force_status_reduced_from"] == "unemployed",
    #                 out_df["labor_force_status_reduced_to"] == "not in labor force",
    #             ),
    #             np.logical_and(
    #                 out_df["labor_force_status_reduced_from"] == "not in labor force",
    #                 out_df["labor_force_status_reduced_to"] == "unemployed",
    #             )
    #         ]
    #     ), :
    # ].index, "match_" + str(lag) + "m"] = False
    # out_df.loc[out_df.loc[
    #     np.logical_or(
    #         np.logical_and(
    #             out_df["labor_force_status_reduced_from"] == "unemployed",
    #             out_df["labor_force_status_reduced_to"] == "employed",
    #         ),
    #         np.logical_and(
    #             out_df["labor_force_status_reduced_from"] == "not in labor force",
    #             out_df["labor_force_status_reduced_to"] == "employed",
    #         ),
    #     ), :
    # ].index, "match_" + str(lag) + "m"] = True

    # remove unused columns and relabel changed column to original names
    out_df = out_df.drop(columns=["labor_force_status_reduced_to"])
    out_df = out_df.rename(
        columns={"labor_force_status_reduced_from": "labor_force_status_reduced"}
    )

    return out_df


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    cps_data_monthly = _compile_long_monthly_df()

    cps_data_monthly.to_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_data_monthly.csv", index=False
    )
