""" Create all figures.

This module generates the figures for all output files.

"""
#####################################################
# IMPORTS
#####################################################
# import json
import numpy as np
import pandas as pd

from src.config import BLD
from src.utilities.plot_utils import _plot_lines_analytics
from src.utilities.plot_utils import _plot_lines_with_error_bars

# from src.utilities.plot_utils import _plot_line_with_ci
# from src.utilities.plot_utils import _plot_stacked_area_100
# from src.utilities.plot_utils import _plot_time_series
# from src.utilities.plot_utils import _plot_time_series_2_axes


#####################################################
# PARAMETERS
#####################################################

idx = pd.IndexSlice

tenure = pd.read_csv(
    BLD / "results" / "cps_returns_to_tenure.csv", index_col=["x", "group"]
)
flow_rates_age_race = pd.read_csv(
    BLD / "results" / "cps_flow_rates_age_race.csv", index_col=["age_group", "race"]
)

x_range_age_groups = np.array(
    [
        15 + (20 - 15) / 2,
        20 + (25 - 20) / 2,
        25 + (30 - 25) / 2,
        30 + (35 - 30) / 2,
        35 + (40 - 35) / 2,
        40 + (45 - 40) / 2,
        45 + (50 - 45) / 2,
        50 + (55 - 50) / 2,
        55 + (60 - 55) / 2,
        60 + (65 - 60) / 2,
    ]
)

#####################################################
# FUNCTIONS
#####################################################


def create_figures():

    plot_data = {}
    for group in ["low", "medium", "high"]:
        plot_data[group] = {
            "y": np.array(tenure.loc[idx[:, group], "predicted"]),
            "error": np.absolute(
                np.array(tenure.loc[idx[:, group], ["conf.low", "conf.high"]]).T
                - np.array(
                    (
                        tenure.loc[idx[:, group], "predicted"],
                        tenure.loc[idx[:, group], "predicted"],
                    )
                )
            ),
            "ci": np.array(tenure.loc[idx[:, group], ["conf.low", "conf.high"]]).T,
        }
    plot_params = {
        "markers": True,
        "figsize": (8, 16 / 3),
        "xlabel": "tenure",
        "xlabels": list(range(0, 41, 5)),
        "ybound": [0, 1500],
        "labels": [
            "low",
            "medium",
            "high",
        ],
        "plot_error_bars": False,
        "plot_ci": True,
        "outpath": BLD / "figures" / "cps_earnings_tenure_education.pdf",
    }
    _plot_lines_with_error_bars(plot_data, plot_params)

    plot_data = flow_rates_age_race.loc[:, "separation_1m_weighted"].unstack(level=1)
    plot_data.loc[:, "x"] = x_range_age_groups
    plot_params = {
        "markers": True,
        "figsize": (6, 4),
        "xlabel": "age group",
        "xlabels": list(range(0, 41, 5)),
        "ylabel": "1-month separation rate",
        "xbound": [15, 65, 5],
        "ybound": [0, 0.08, 0.02],
        "labels": {
            "black": "black",
            "other": "other",
            "white": "white",
        },
        "legend": True,
        "plot_error_bars": False,
        "plot_ci": False,
        "outpath": BLD / "figures" / "cps_separation_1m_age_race.pdf",
    }
    _plot_lines_analytics(plot_data, plot_params)

    plot_data = flow_rates_age_race.loc[:, "match_1m_weighted"].unstack(level=1)
    plot_data.loc[:, "x"] = x_range_age_groups
    plot_params = {
        "markers": True,
        "figsize": (6, 4),
        "xlabel": "age group",
        "xlabels": list(range(0, 41, 5)),
        "ylabel": "1-month match rate",
        "xbound": [15, 65, 5],
        "ybound": [0, 0.4, 0.1],
        "labels": {
            "black": "black",
            "other": "other",
            "white": "white",
        },
        "legend": True,
        "plot_error_bars": False,
        "plot_ci": False,
        "outpath": BLD / "figures" / "cps_match_1m_age_race.pdf",
    }
    _plot_lines_analytics(plot_data, plot_params)

    return


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    create_figures()
