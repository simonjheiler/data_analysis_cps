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
    BLD / "out" / "results" / "cps_returns_to_tenure.csv", index_col=["x", "group"]
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
        "outpath": BLD / "out" / "figures" / "cps_earnings_tenure_education.pdf",
    }
    _plot_lines_with_error_bars(plot_data, plot_params)

    return


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    create_figures()
