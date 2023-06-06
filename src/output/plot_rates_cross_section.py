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


def _plot_line_charts(
    df_year, df_age, df_cohort, df_age_year, df_cohort_year, df_age_cohort
):

    xticks = {
        "year": ([0, 5, 10, 15, 20, 25], [1995, 2000, 2005, 2010, 2015, 2020]),
    }

    ylabels = {
        "employer_change_rate": "1-month employer change rate (self-reported)",
        "occupation_change_rate": "1-month occupation change rate (self-reported)",
        "occupation_change_cond_rate": "1-month occupation change rate (self-reported) conditional on employer change",
        "occ_1_change_rate": "1-month occupation change rate \n (major occupation group, L1)",
        "occ_2_change_rate": "1-month occupation change rate \n (detailed occupation group, L2)",
        "occ_3_change_rate": "1-month occupation change rate (occupation, L3)",
        "occ_1_change_cond_rate": "1-month occupation change rate conditional on employer change \n (major occupation group, L1)",
        "occ_2_change_cond_rate": "1-month occupation change rate conditional on employer change \n (detailed occupation group, L2)",
        "occ_3_change_cond_rate": "1-month occupation change rate conditional on employer change \n (occupation, L3)",
        "employer_change_weighted_rate": "1-month employer change rate (self-reported)",
        "occupation_change_weighted_rate": "1-month occupation change rate (self-reported)",
        "occupation_change_cond_weighted_rate": "1-month occupation change rate (self-reported) conditional on employer change",
        "occ_1_change_weighted_rate": "1-month occupation change rate \n (major occupation group, L1)",
        "occ_2_change_weighted_rate": "1-month occupation change rate \n (detailed occupation group, L2)",
        "occ_3_change_weighted_rate": "1-month occupation change rate \n (occupation, L3)",
        "occ_1_change_cond_weighted_rate": "1-month occupation change rate conditional on employer change \n (major occupation group, L1)",
        "occ_2_change_cond_weighted_rate": "1-month occupation change rate conditional on employer change \n (detailed occupation group, L2)",
        "occ_3_change_cond_weighted_rate": "1-month occupation change rate conditional on employer change \n (occupation, L3)",
    }

    ylims = {
        "employer_change_rate": [0.0, 0.06, 0.01],
        "occupation_change_rate": [0.0, 0.02, 0.005],
        "occupation_change_cond_rate": [0.0, 1.0, 0.2],
        "occ_1_change_rate": [0.0, 0.1, 0.02],
        "occ_2_change_rate": [0.0, 0.1, 0.02],
        "occ_3_change_rate": [0.0, 0.1, 0.02],
        "occ_1_change_cond_rate": [0.0, 0.15, 0.05],
        "occ_2_change_cond_rate": [0.0, 0.15, 0.05],
        "occ_3_change_cond_rate": [0.0, 0.15, 0.05],
        "employer_change_weighted_rate": [0.0, 0.06, 0.01],
        "occupation_change_weighted_rate": [0.0, 0.02, 0.005],
        "occupation_change_cond_weighted_rate": [0.0, 1.0, 0.2],
        "occ_1_change_weighted_rate": [0.0, 0.1, 0.02],
        "occ_2_change_weighted_rate": [0.0, 0.1, 0.02],
        "occ_3_change_weighted_rate": [0.0, 0.1, 0.02],
        "occ_1_change_cond_weighted_rate": [0.0, 0.15, 0.05],
        "occ_2_change_cond_weighted_rate": [0.0, 0.15, 0.05],
        "occ_3_change_cond_weighted_rate": [0.0, 0.15, 0.05],
    }

    for var in [
        "employer_change_rate",
        "occupation_change_rate",
        "occupation_change_cond_rate",
        "occ_1_change_rate",
        "occ_2_change_rate",
        "occ_3_change_rate",
        "occ_1_change_cond_rate",
        "occ_2_change_cond_rate",
        "occ_3_change_cond_rate",
        "employer_change_weighted_rate",
        "occupation_change_weighted_rate",
        "occupation_change_cond_weighted_rate",
        "occ_1_change_weighted_rate",
        "occ_2_change_weighted_rate",
        "occ_3_change_weighted_rate",
        "occ_1_change_cond_weighted_rate",
        "occ_2_change_cond_weighted_rate",
        "occ_3_change_cond_weighted_rate",
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
        data = data.drop(["before 1929", "2000 and later"])
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

        # by age (5 years) and year
        data = df_age_year.loc[:, var]
        data = data.unstack(level=0)
        data = data.drop(columns=["19 and younger", "65 and older"])
        params = {
            "legend": True,
            "xlabel": "year",
            "xticks": (np.arange(data.shape[0]) + 1, list(data.index)),
            "ylabel": ylabels[var],
            "ylim": ylims[var],
            "title": f"{ylabels[var]} by age over time",
            "outpath": BLD / "figures" / "plots" / f"cps_{var}_agegroup_5_year.pdf",
        }
        plot_line(data, params)

        # by cohort (10 years) and year
        data = df_cohort_year.loc[:, var]
        data = data.unstack(level=0)
        data = data.drop(columns=["before 1929", "2000 and later"])
        params = {
            "legend": True,
            "xlabel": "year",
            "xticks": (np.arange(data.shape[0]) + 1, list(data.index)),
            "ylabel": ylabels[var],
            "ylim": ylims[var],
            "title": f"{ylabels[var]} by birth year over time",
            "outpath": BLD / "figures" / "plots" / f"cps_{var}_cohort_10_year.pdf",
        }
        plot_line(data, params)

        # by age (5 years) and cohort (10 years)
        data = df_age_cohort.loc[:, var]
        data = data.unstack(level=1)
        data = data.drop(["19 and younger", "65 and older"])
        data = data.drop(columns=["before 1929", "2000 and later"])
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
    df_age_year = pd.read_csv(
        DAT
        / "cps"
        / "basic_monthly"
        / "results"
        / "cps_transitions_rates_age_year.csv",
        index_col=[0, 1],
    )
    df_cohort_year = pd.read_csv(
        DAT
        / "cps"
        / "basic_monthly"
        / "results"
        / "cps_transitions_rates_cohort_year.csv",
        index_col=[0, 1],
    )
    df_age_cohort = pd.read_csv(
        DAT
        / "cps"
        / "basic_monthly"
        / "results"
        / "cps_transitions_rates_age_cohort.csv",
        index_col=[0, 1],
    )

    _plot_line_charts(
        df_year, df_age, df_cohort, df_age_year, df_cohort_year, df_age_cohort
    )
