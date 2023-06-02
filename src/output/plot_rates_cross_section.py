"""tbc

"""
####################
# IMPORTS
####################
import numpy as np
import pandas as pd

from src.config import BLD
from src.config import DAT
from src.utilities.plot_utils import plot_line

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


def _get_rates(df):

    df.loc[:, "emp_switch_rate"] = df.loc[:, "employer_switch"] / df.loc[:, "employed"]
    df.loc[:, "occ_switch_rate"] = (
        df.loc[:, "occupation_switch"] / df.loc[:, "employed"]
    )
    df.loc[:, "occ_1_switch_1m_rate"] = (
        df.loc[:, "occ_1_switch_1m"] / df.loc[:, "employed"]
    )
    df.loc[:, "occ_2_switch_1m_rate"] = (
        df.loc[:, "occ_2_switch_1m"] / df.loc[:, "employed"]
    )
    df.loc[:, "occ_3_switch_1m_rate"] = (
        df.loc[:, "occ_3_switch_1m"] / df.loc[:, "employed"]
    )
    df.loc[:, "occ_switch_rate_cond"] = (
        df.loc[:, "occupation_switch_cond"] / df.loc[:, "employer_switch"]
    )
    df.loc[:, "occ_1_switch_1m_cond_rate"] = (
        df.loc[:, "occ_1_switch_cond_1m"] / df.loc[:, "employer_switch"]
    )
    df.loc[:, "occ_2_switch_1m_cond_rate"] = (
        df.loc[:, "occ_2_switch_cond_1m"] / df.loc[:, "employer_switch"]
    )
    df.loc[:, "occ_3_switch_1m_cond_rate"] = (
        df.loc[:, "occ_3_switch_cond_1m"] / df.loc[:, "employer_switch"]
    )
    df.loc[:, "emp_switch_rate_weighted"] = (
        df.loc[:, "employer_switch_weighted"] / df.loc[:, "employed_weighted"]
    )
    df.loc[:, "occ_switch_rate_weighted"] = (
        df.loc[:, "occupation_switch_weighted"] / df.loc[:, "employed_weighted"]
    )
    df.loc[:, "occ_1_switch_1m_rate_weighted"] = (
        df.loc[:, "occ_1_switch_1m_weighted"] / df.loc[:, "employed_weighted"]
    )
    df.loc[:, "occ_2_switch_1m_rate_weighted"] = (
        df.loc[:, "occ_2_switch_1m_weighted"] / df.loc[:, "employed_weighted"]
    )
    df.loc[:, "occ_3_switch_1m_rate_weighted"] = (
        df.loc[:, "occ_3_switch_1m_weighted"] / df.loc[:, "employed_weighted"]
    )
    df.loc[:, "occ_switch_rate_cond_weighted"] = (
        df.loc[:, "occupation_switch_cond_weighted"]
        / df.loc[:, "employer_switch_weighted"]
    )
    df.loc[:, "occ_1_switch_1m_cond_rate_weighted"] = (
        df.loc[:, "occ_1_switch_cond_1m_weighted"]
        / df.loc[:, "employer_switch_weighted"]
    )
    df.loc[:, "occ_2_switch_1m_cond_rate_weighted"] = (
        df.loc[:, "occ_2_switch_cond_1m_weighted"]
        / df.loc[:, "employer_switch_weighted"]
    )
    df.loc[:, "occ_3_switch_1m_cond_rate_weighted"] = (
        df.loc[:, "occ_3_switch_cond_1m_weighted"]
        / df.loc[:, "employer_switch_weighted"]
    )

    return df


def _remove_data(df, dates_exclude):
    for var in dates_exclude.keys():
        df.loc[
            df.loc[:, "time_unit"].isin(dates_exclude[var]), f"{var}_switch_1m"
        ] = np.nan
        df.loc[
            df.loc[:, "time_unit"].isin(dates_exclude[var]), f"{var}_switch_cond_1m"
        ] = np.nan
        df.loc[
            df.loc[:, "time_unit"].isin(dates_exclude[var]), f"{var}_switch_1m_weighted"
        ] = np.nan
        df.loc[
            df.loc[:, "time_unit"].isin(dates_exclude[var]),
            f"{var}_switch_cond_1m_weighted",
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

    # date_occ88_stop = pd.to_datetime("2011-11")
    # date_occ10_start = pd.to_datetime("2011-12")

    dates_exclude = {
        "occ_1": [
            pd.to_datetime("2002-12"),
            pd.to_datetime("2004-04"),
            pd.to_datetime("2004-12"),
            pd.to_datetime("2009-12"),
            pd.to_datetime("2012-04"),
            pd.to_datetime("2015-05"),
        ],
        "occ_2": [
            pd.to_datetime("1997-12"),
            pd.to_datetime("2002-12"),
            pd.to_datetime("2004-04"),
            pd.to_datetime("2009-12"),
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

    # aggregate by age group and cohort by first taking sums over age
    # groups and cohorts and then taking time averages over entire period
    df_age_cohort = df_in.groupby(["time_unit", "agegroup_5", "cohort_10"]).sum()
    df_age_cohort = df_age_cohort.reset_index()
    df_age_cohort = df_age_cohort.drop(columns=["age", "birthyear", "year"])
    df_age_cohort = df_age_cohort.groupby(["agegroup_5", "cohort_10"]).mean()

    # compute rates
    df_test = _get_rates(df_test)
    df_year = _get_rates(df_year)
    df_age = _get_rates(df_age)
    df_cohort = _get_rates(df_cohort)
    df_age_cohort = _get_rates(df_age_cohort)

    return [df_year, df_age, df_cohort, df_age_cohort]


def _plot_line_charts(df_year, df_age, df_cohort, df_age_cohort):

    xticks = {
        "year": ([0, 5, 10, 15, 20, 25], [1995, 2000, 2005, 2010, 2015, 2020]),
    }

    ylabels = {
        "emp_switch_rate": "1-month employer switch rate (self-reported)",
        "occ_switch_rate": "1-month occupation switch rate (self-reported)",
        "occ_switch_rate_cond": "1-month occupation switch rate (self-reported)",
        "occ_1_switch_1m_rate": "1-month occupation switch rate "
        "(major occupation group, L1)",
        "occ_2_switch_1m_rate": "1-month occupation switch rate "
        "(detailed occupation group, L2)",
        "occ_3_switch_1m_rate": "1-month occupation switch rate (occupation, L3)",
        "occ_1_switch_1m_cond_rate": "1-month occupation switch rate conditional "
        "on employer change (major occupation group, L1)",
        "occ_2_switch_1m_cond_rate": "1-month occupation switch rate conditional "
        "on employer change (detailed occupation group, L2)",
        "occ_3_switch_1m_cond_rate": "1-month occupation switch rate conditional "
        "on employer change (occupation, L3)",
        "emp_switch_rate_weighted": "1-month employer switch rate (self-reported)",
        "occ_switch_rate_weighted": "1-month occupation switch rate (self-reported)",
        "occ_switch_rate_cond_weighted": "1-month occupation switch rate (self-reported)",
        "occ_1_switch_1m_rate_weighted": "1-month occupation switch rate "
        "(major occupation group, L1)",
        "occ_2_switch_1m_rate_weighted": "1-month occupation switch rate "
        "(detailed occupation group, L2)",
        "occ_3_switch_1m_rate_weighted": "1-month occupation switch rate (occupation, L3)",
        "occ_1_switch_1m_cond_rate_weighted": "1-month occupation switch rate conditional "
        "on employer change (major occupation group, L1)",
        "occ_2_switch_1m_cond_rate_weighted": "1-month occupation switch rate conditional "
        "on employer change (detailed occupation group, L2)",
        "occ_3_switch_1m_cond_rate_weighted": "1-month occupation switch rate conditional "
        "on employer change (occupation, L3)",
    }

    ylims = {
        "emp_switch_rate": [0.0, 0.045, 0.005],
        "occ_switch_rate": [0.0, 0.1, 0.02],
        "occ_switch_rate_cond": [0.0, 0.1, 0.02],
        "occ_1_switch_1m_rate": [0.0, 0.1, 0.02],
        "occ_2_switch_1m_rate": [0.0, 0.1, 0.02],
        "occ_3_switch_1m_rate": [0.0, 0.1, 0.02],
        "occ_1_switch_1m_cond_rate": [0.0, 0.15, 0.05],
        "occ_2_switch_1m_cond_rate": [0.0, 0.15, 0.05],
        "occ_3_switch_1m_cond_rate": [0.0, 0.15, 0.05],
        "emp_switch_rate_weighted": [0.0, 0.045, 0.005],
        "occ_switch_rate_weighted": [0.0, 0.1, 0.02],
        "occ_switch_rate_cond_weighted": [0.0, 0.1, 0.02],
        "occ_1_switch_1m_rate_weighted": [0.0, 0.1, 0.02],
        "occ_2_switch_1m_rate_weighted": [0.0, 0.1, 0.02],
        "occ_3_switch_1m_rate_weighted": [0.0, 0.1, 0.02],
        "occ_1_switch_1m_cond_rate_weighted": [0.0, 0.15, 0.05],
        "occ_2_switch_1m_cond_rate_weighted": [0.0, 0.15, 0.05],
        "occ_3_switch_1m_cond_rate_weighted": [0.0, 0.15, 0.05],
    }

    for var in [
        "emp_switch_rate",
        "occ_switch_rate",
        "occ_1_switch_1m_rate",
        "occ_2_switch_1m_rate",
        "occ_3_switch_1m_rate",
        "occ_switch_rate_cond",
        "occ_1_switch_1m_cond_rate",
        "occ_2_switch_1m_cond_rate",
        "occ_3_switch_1m_cond_rate",
        "emp_switch_rate_weighted",
        "occ_switch_rate_weighted",
        "occ_1_switch_1m_rate_weighted",
        "occ_2_switch_1m_rate_weighted",
        "occ_3_switch_1m_rate_weighted",
        "occ_switch_rate_cond_weighted",
        "occ_1_switch_1m_cond_rate_weighted",
        "occ_2_switch_1m_cond_rate_weighted",
        "occ_3_switch_1m_cond_rate_weighted",
    ]:
        # by time
        data = df_year.loc[:, var]
        params = {
            "legend": False,
            "xlabel": "year",
            "xticks": xticks["year"],
            "ylabel": ylabels[var],
            "ylim": ylims[var],
            "title": f"{ylabels[var]} over time",
            "outpath": BLD / "figures" / "plots" / f"cps_{var}_year.pdf",
        }
        plot_line(data, params)

        # by age
        data = df_age.loc[:, var]
        data = data.drop(["19 and younger", "65 and older"])
        params = {
            "legend": False,
            "xlabel": "age group",
            "xticks": (np.arange(data.shape[0]) + 1, list(data.index)),
            "ylabel": ylabels[var],
            "ylim": ylims[var],
            "title": f"{ylabels[var]} by age",
            "outpath": BLD / "figures" / "plots" / f"cps_{var}_agegroup_5.pdf",
        }
        plot_line(data, params)

        # by cohort
        data = df_cohort.loc[:, var]
        data = data.drop(["before 1929"])
        params = {
            "legend": False,
            "xlabel": "birth year",
            "xticks": (np.arange(data.shape[0]) + 1, list(data.index)),
            "ylabel": ylabels[var],
            "ylim": ylims[var],
            "title": f"{ylabels[var]} by birth year",
            "outpath": BLD / "figures" / "plots" / f"cps_{var}_cohort_10.pdf",
        }
        plot_line(data, params)

        # by age (5 years) and cohort (10 years)
        data = df_age_cohort.loc[:, var]
        data = data.unstack(level=1)
        data = data.drop(["19 and younger", "65 and older"])
        data = data.drop(columns=["before 1929"])
        params = {
            "legend": True,
            "xlabel": "age group",
            "xticks": (np.arange(data.shape[0]) + 1, list(data.index)),
            "ylabel": ylabels[var],
            "ylim": ylims[var],
            "title": f"{ylabels[var]} by age and birth year",
            "outpath": BLD
            / "figures"
            / "plots"
            / f"cps_{var}_agegroup_5_cohort_10.pdf",
        }
        plot_line(data, params)

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

    [df_year, df_age, df_cohort, df_age_cohort] = _aggregate_data(df_in)

    df_year.to_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_year.csv"
    )
    df_age.to_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_age.csv"
    )
    df_cohort.to_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_cohort.csv"
    )
    df_age_cohort.to_csv(
        DAT
        / "cps"
        / "basic_monthly"
        / "results"
        / "cps_transitions_rates_age_cohort.csv"
    )

    df_year = pd.read_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_year.csv",
        index_col=[0],
    )
    df_age = pd.read_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_age.csv",
        index_col=[0],
    )
    df_cohort = pd.read_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_transitions_rates_cohort.csv",
        index_col=[0],
    )
    df_age_cohort = pd.read_csv(
        DAT
        / "cps"
        / "basic_monthly"
        / "results"
        / "cps_transitions_rates_age_cohort.csv",
        index_col=[0, 1],
    )

    _plot_line_charts(df_year, df_age, df_cohort, df_age_cohort)
