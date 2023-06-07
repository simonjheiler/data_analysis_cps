"""tbc

"""
####################
# IMPORTS
####################
import numpy as np
import pandas as pd

from src.config import DAT

#####################################################
# PARAMETERS
#####################################################


agegroup_5_thresholds = [
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
agegroup_5_labels = [
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

cohort_10_thresholds = [
    -np.inf,
    1929,
    1939,
    1949,
    1959,
    1969,
    1979,
    1989,
    1999,
    np.inf,
]
cohort_10_labels = [
    "before 1929",
    "1930 to 1939",
    "1940 to 1949",
    "1950 to 1959",
    "1960 to 1969",
    "1970 to 1979",
    "1980 to 1989",
    "1990 to 1999",
    "2000 and later",
]


#####################################################
# FUNCTIONS
#####################################################


def _get_rates(df, varlist):

    for var in varlist:
        df.loc[:, f"{var}_rate"] = df.loc[:, var] / df.loc[:, f"base_{var}"]

    return df


def _remove_data(df, dates_exclude):
    for var in dates_exclude.keys():
        df.loc[
            df.loc[:, "time_unit"].isin(dates_exclude[var]), f"{var}_change"
        ] = np.nan
        df.loc[
            df.loc[:, "time_unit"].isin(dates_exclude[var]), f"{var}_change_cond"
        ] = np.nan
        df.loc[
            df.loc[:, "time_unit"].isin(dates_exclude[var]), f"{var}_change_weighted"
        ] = np.nan
        df.loc[
            df.loc[:, "time_unit"].isin(dates_exclude[var]),
            f"{var}_change_cond_weighted",
        ] = np.nan

    return df


def _aggregate_data(df_in):

    df_in = df_in.reset_index()
    df_in.loc[:, "time_unit"] = pd.to_datetime(df_in.loc[:, "time_unit"])
    df_in.loc[:, "year"] = df_in.loc[:, "time_unit"].dt.year.astype(int)
    df_in.loc[:, "agegroup_5"] = pd.cut(
        df_in["age"], agegroup_5_thresholds, right=True, labels=agegroup_5_labels
    )
    df_in.loc[:, "cohort_10"] = pd.cut(
        df_in["birthyear"], cohort_10_thresholds, right=True, labels=cohort_10_labels
    )

    date_start = pd.to_datetime("1995-09")
    date_end = pd.to_datetime("2019-12")

    # date_occ88_stop = pd.to_datetime("2011-11")
    # date_occ10_start = pd.to_datetime("2011-12")

    dates_exclude = {
        "occ_1": [
            pd.to_datetime("2002-12"),
            pd.to_datetime("2004-04"),
            pd.to_datetime("2004-12"),
            pd.to_datetime("2009-12"),
            pd.to_datetime("2010-12"),
            pd.to_datetime("2012-04"),
            pd.to_datetime("2015-05"),
        ],
        "occ_2": [
            pd.to_datetime("1997-12"),
            pd.to_datetime("2002-12"),
            pd.to_datetime("2004-04"),
            pd.to_datetime("2009-12"),
            pd.to_datetime("2010-12"),
            pd.to_datetime("2012-04"),
            pd.to_datetime("2012-12"),
            pd.to_datetime("2015-05"),
        ],
        "occ_3": [
            pd.to_datetime("2002-12"),
            pd.to_datetime("2004-04"),
            pd.to_datetime("2010-12"),
            pd.to_datetime("2012-12"),
            pd.to_datetime("2013-12"),
            pd.to_datetime("2015-05"),
            pd.to_datetime("2019-12"),
        ],
    }

    # drop observations from exclusion dates
    df_in = df_in.loc[(df_in.time_unit >= date_start), :]
    df_in = df_in.loc[(df_in.time_unit <= date_end), :]
    df_in = _remove_data(df_in, dates_exclude)

    df_test = df_in.groupby("time_unit").sum().reset_index()
    df_test = _remove_data(df_test, dates_exclude)

    # aggregate by year by first taking sums over cohorts (i.e. age) and then
    # taking time averages for calendar years
    df_year = df_in.groupby(["time_unit", "year"]).sum()
    df_year = df_year.reset_index()
    df_year = df_year.drop(columns=["age", "birthyear", "time_unit"])
    df_year = df_year.groupby("year").mean()

    # aggregate by age group by first taking sums over age groups and then
    # taking time averages over entire period
    df_age = df_in.groupby(["time_unit", "agegroup_5"]).sum()
    df_age = df_age.reset_index()
    df_age = df_age.drop(columns=["age", "birthyear", "year"])
    df_age = df_age.groupby("agegroup_5").mean()

    # aggregate by cohort by first taking sums over cohorts and then
    # taking time averages over entire period
    df_cohort = df_in.groupby(["time_unit", "cohort_10"]).sum()
    df_cohort = df_cohort.reset_index()
    df_cohort = df_cohort.drop(columns=["age", "birthyear", "year"])
    df_cohort = df_cohort.groupby("cohort_10").mean()

    # aggregate by age group and year by first taking sums over age groups and then
    # taking time averages for calendar years
    df_age_year = df_in.groupby(["time_unit", "year", "agegroup_5"]).sum()
    df_age_year = df_age_year.reset_index()
    df_age_year = df_age_year.drop(columns=["age", "birthyear"])
    df_age_year = df_age_year.groupby(["agegroup_5", "year"]).mean()

    # aggregate by cohort by first taking sums over cohorts and then
    # taking time averages over entire period
    df_cohort_year = df_in.groupby(["time_unit", "year", "cohort_10"]).sum()
    df_cohort_year = df_cohort_year.reset_index()
    df_cohort_year = df_cohort_year.drop(columns=["age", "birthyear"])
    df_cohort_year = df_cohort_year.groupby(["cohort_10", "year"]).mean()

    # aggregate by age group and cohort by first taking sums over age
    # groups and cohorts and then taking time averages over entire period
    df_age_cohort = df_in.groupby(["time_unit", "agegroup_5", "cohort_10"]).sum()
    df_age_cohort = df_age_cohort.reset_index()
    df_age_cohort = df_age_cohort.drop(columns=["age", "birthyear", "year"])
    df_age_cohort = df_age_cohort.groupby(["agegroup_5", "cohort_10"]).mean()

    varlist_rates = [
        "separation",
        "finding",
        "exit",
        "entry",
        "employer_change",
        "occupation_change",
        "occupation_change_cond",
        "occ_1_change",
        "occ_1_change_cond",
        "occ_2_change",
        "occ_2_change_cond",
        "occ_3_change",
        "occ_3_change_cond",
    ]
    varlist_rates = varlist_rates + [f"{var}_weighted" for var in varlist_rates]

    # compute aggregate transition rates
    df_test = _get_rates(df_test, varlist_rates)
    df_year = _get_rates(df_year, varlist_rates)
    df_age = _get_rates(df_age, varlist_rates)
    df_cohort = _get_rates(df_cohort, varlist_rates)
    df_age_year = _get_rates(df_age_year, varlist_rates)
    df_cohort_year = _get_rates(df_cohort_year, varlist_rates)
    df_age_cohort = _get_rates(df_age_cohort, varlist_rates)

    # store results
    df_year.to_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_year.csv"
    )
    df_age.to_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_age.csv"
    )
    df_cohort.to_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_cohort.csv"
    )
    df_age_year.to_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_age_year.csv"
    )
    df_cohort_year.to_csv(
        DAT
        / "cps"
        / "basic_monthly"
        / "results"
        / "cps_transitions_rates_cohort_year.csv"
    )
    df_age_cohort.to_csv(
        DAT
        / "cps"
        / "basic_monthly"
        / "results"
        / "cps_transitions_rates_age_cohort.csv"
    )

    return


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    df_in = pd.read_csv(
        DAT
        / "cps"
        / "basic_monthly"
        / "results"
        / "cps_transitions_rates_age_cohort_time.csv",
        index_col=[0, 1, 2],
    )

    _aggregate_data(df_in)
