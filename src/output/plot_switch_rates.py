import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from src.config import BLD

#####################################################
# PARAMETERS
#####################################################

markers = [
    ".",
    "^",
    "x",
    "o",
    "+",
    "*",
    "p",
    "D",
    "s",
    "8",
    "2",
    "h",
    "d",
    ".",
    "^",
    "x",
    "o",
    "+",
    "*",
    "p",
    "D",
    "s",
    "8",
    "2",
    "h",
    "d",
]
linestyles = [
    (0, ()),
    (0, (1, 1)),
    (0, (5, 1)),
    (0, (5, 1, 1, 1)),
    (0, (3, 5, 1, 5, 1, 5)),
    (0, (1, 10)),
    (0, (5, 10)),
    (0, (5, 1, 10, 1)),
    (0, (3, 10, 1, 10, 1, 10)),
    (0, (1, 15)),
    (0, (5, 15)),
    (0, (5, 1, 15, 1)),
    (0, (3, 15, 1, 15, 1, 15)),
    (0, ()),
    (0, (1, 1)),
    (0, (5, 1)),
    (0, (5, 1, 1, 1)),
    (0, (3, 5, 1, 5, 1, 5)),
    (0, (1, 10)),
    (0, (5, 10)),
    (0, (5, 1, 10, 1)),
    (0, (3, 10, 1, 10, 1, 10)),
    (0, (1, 15)),
    (0, (5, 15)),
    (0, (5, 1, 15, 1)),
    (0, (3, 15, 1, 15, 1, 15)),
]
colors = ["tab:blue", "tab:orange", "tab:red", "gold", "limegreen", "deeppink"]

cohorts1 = [
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
]

cohorts2 = [
    "1920-1929",
    "1930-1939",
    "1940-1949",
    "1950-1959",
    "1960-1969",
    "1970-1979",
]

df_prob_cohort1 = pd.read_csv(
    BLD / "datasets" / "cps_switch_probabilities_age_cohort1.csv",
    index_col=["cohort", "age_group"],
)
df_prob_cohort2 = pd.read_csv(
    BLD / "datasets" / "cps_switch_probabilities_age_cohort2.csv",
    index_col=["cohort", "age_group"],
)

#####################################################
# FUNCTIONS
#####################################################


def plot_line(plot_data, plot_params):

    x = np.arange(plot_data.shape[0]) + 1
    data_series = plot_data.columns

    fig, ax = plt.subplots(figsize=(12, 6))

    fig.tight_layout(rect=(0.1, 0.1, 1, 1))

    for idx, series in enumerate(data_series):
        ax.plot(
            x,
            plot_data[series],
            linestyle=linestyles[idx],
            marker=markers[idx],
            label=data_series[idx],
        )

    # format axes
    ax.set_xlabel(plot_params["xlabel"])
    # ax.set_xticks(ticks=x, labels=list(plot_data.index))

    ax.set_ylabel(plot_params["ylabel"])
    ax.set_ylim(plot_params["ylim"][:2])
    # ax.set_yticks(
    #     np.arange(
    #         plot_params["ylim"][0], plot_params["ylim"][1], plot_params["ylim"][2]
    #     )
    # )

    # ax.set_title(plot_params["title"])

    # format plot area
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    # add legend
    if plot_params["legend"]:
        ax.legend(loc="upper right", ncol=3)

    # save figure
    fig.savefig(plot_params["outpath"])
    plt.close()


def _plot_line_charts():

    data = df_prob_cohort1.loc[:, "estimate"].unstack(level=0)
    params = {
        "legend": True,
        "xlabel": "age group",
        "ylabel": "12m occupation switch rate",
        "ylim": [0.0, 0.02, 0.005],
        "title": "Occupation switching by age and cohort",
        "outpath": BLD / "figures" / "cps_switch_probabilities_age_cohorts1.pdf",
    }
    plot_line(data, params)

    data = df_prob_cohort2.loc[:, "estimate"].unstack(level=0)
    params = {
        "legend": True,
        "xlabel": "age group",
        "ylabel": "12m occupation switch rate",
        "ylim": [0.0, 0.02, 0.005],
        "title": "Occupation switching by age and cohort",
        "outpath": BLD / "figures" / "cps_switch_probabilities_age_cohorts2.pdf",
    }
    plot_line(data, params)

    return


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    _plot_line_charts()
