""" Utilities for plotting.

This modules contains standardized functions for plotting
 different types of graphs used throughout the project.


"""
#####################################################
# IMPORTS
#####################################################
import matplotlib.dates as mdates
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

#####################################################
# PARAMETERS
#####################################################

markers = [".", "^", "x", "o", "+", "*", "p", "D", "s", "8", "2", "h", "d"]
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
]
colors = ["tab:blue", "tab:orange", "tab:red", "gold", "limegreen", "deeppink"]

plt.tight_layout(rect=(0, 0.25, 1, 1))

#####################################################
# FUNCTIONS
#####################################################


def _average_by_age_group(array_in, age_min, thresholds, labels):

    array_in.loc[:, "age"] = array_in.index // 4 + age_min
    array_in.loc[:, "age_group"] = pd.cut(
        array_in.age, thresholds, right=False, labels=labels
    )
    array_out = array_in.groupby("age_group").mean()
    array_out = array_out.drop(columns="age")

    return array_out


def _autolabel(ax, rects):
    """Attach a text label above each bar in *rects*, displaying its height."""
    for rect in rects:
        height = rect.get_height()
        ax.annotate(
            f"{height:.1%}",
            xy=(rect.get_x() + rect.get_width() / 2, height),
            xytext=(0, 3),  # 3 points vertical offset
            textcoords="offset points",
            ha="center",
            va="bottom",
        )


def _clean_and_sort_categories(col, order=True):

    if not col.dtype.name == "category":
        col = col.astype("category")

    col.cat.remove_unused_categories(inplace=True)

    if order and not col.cat.ordered:
        new_index = []
        new_index += [
            ele for ele in col.cat.categories if "less" in ele or "lower" in ele
        ]

        names = [
            ele
            for ele in col.cat.categories
            if "less" not in ele
            and "lower" not in ele
            and "more" not in ele
            and "higher" not in ele
        ]
        order = [float(ele[: ele.find("%")]) for ele in names]
        new_index += [x for _, x in sorted(zip(order, names))]

        new_index += [
            ele for ele in col.cat.categories if "more" in ele or "higher" in ele
        ]

        col.cat.reorder_categories(new_index, inplace=True)

    return col


def _plot_bar(data, params):

    x = np.arange(len(data))

    fig, ax = plt.subplots(figsize=params["figsize"], frameon=False)
    rect = ax.bar(x, data, width=params["barwidth"], color=params["colors"])
    ax.set_ylabel(params["ylabel"])
    ax.set_ybound(params["ybound"])
    ax.set_title(params["title"])
    ax.set_xticks(x)
    ax.set_xticklabels(params["labels"])

    if params["data_labels"]:
        _autolabel(ax, rect)

    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    fig.savefig(params["outpath"])
    plt.close()


def _plot_frequency(data, params):

    data = _clean_and_sort_categories(data)

    data = data.apply(pd.value_counts)
    data = data / data.sum()

    data = data.reindex(data.index.sort_values())

    labels = params["labels"]

    x = np.arange(len(labels))  # the label locations
    width = params["barwidth"]  # the width of the bars

    fig, ax = plt.subplots(figsize=params["figsize"], frameon=False)

    x_shift = -(len(data.index) - 1) / 2
    for idx, cat in enumerate(data.index):
        rects = ax.bar(
            x + x_shift * width,
            data.loc[cat, :],
            width,
            label=cat,
            color=params["colors"][idx],
        )
        if params["data_label"]:
            _autolabel(ax, rects)
        x_shift += 1

    # Add some text for labels, title and custom x-axis tick labels, etc.
    ax.set_ylabel(params["ylabel"])
    ax.set_ybound(params["ybound"])
    ax.set_title(params["title"])
    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    if params["legend_on"]:
        ax.legend()
        plt.legend(loc="center left", bbox_to_anchor=(1, 0.2), ncol=1)

    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    fig.tight_layout()
    fig.savefig(params["outpath"])
    plt.close()


def plot_line(plot_data, plot_params):

    x = np.arange(plot_data.shape[0]) + 1
    if plot_data.ndim == 1:
        plot_data = pd.DataFrame(plot_data)

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
    xtick_ticks = plot_params["xticks"][0]
    xtick_labels = plot_params["xticks"][1]
    if len(xtick_ticks) > 10:
        xtick_ticks = np.arange(0, len(xtick_ticks), len(xtick_ticks) // 5)
        xtick_labels = [xtick_labels[i] for i in xtick_ticks]
    ax.set_xticks(ticks=xtick_ticks, labels=xtick_labels)

    ax.set_ylabel(plot_params["ylabel"])
    ax.set_ylim(plot_params["ylim"][:2])
    ax.set_yticks(
        np.arange(
            plot_params["ylim"][0], plot_params["ylim"][1], plot_params["ylim"][2]
        )
    )

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


def _plot_frequency_over_time(data, params):

    for col in data.columns:
        data[col] = _clean_and_sort_categories(data[col])

    data = data.apply(pd.value_counts)
    for col in data.columns:
        data[col] = data[col] / data[col].sum()

    data = data.reindex(data.index.sort_values())

    labels = params["labels"]

    x = np.arange(len(labels))  # the label locations
    width = params["barwidth"]  # the width of the bars

    fig, ax = plt.subplots(figsize=params["figsize"], frameon=False)

    x_shift = -(len(data.index) - 1) / 2
    for idx, cat in enumerate(data.index):
        rects = ax.bar(
            x + x_shift * width,
            data.loc[cat, :],
            width,
            label=cat,
            color=params["colors"][idx],
        )
        if params["data_label"]:
            _autolabel(ax, rects)
        x_shift += 1

    # Add some text for labels, title and custom x-axis tick labels, etc.
    ax.set_ylabel(params["ylabel"])
    ax.set_ybound(params["ybound"])
    ax.set_title(params["title"])
    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    if params["legend_on"]:
        ax.legend()
        plt.legend(loc="center left", bbox_to_anchor=(1, 0.5), ncol=1)

    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    fig.tight_layout()
    fig.savefig(params["outpath"])
    plt.close()


def _plot_heatmap(data, params):

    data = data.astype("float")
    data = data.iloc[::-1]

    fig, ax = plt.subplots(figsize=params["figsize"], frameon=False)
    im = ax.imshow(
        data,
        aspect=params["figsize"][1] / params["figsize"][0],
        vmin=params["scale"][0],
        vmax=params["scale"][1],
        cmap=params["colors"],
    )

    ax.set_xticks(np.arange(data.shape[1]))
    ax.set_yticks(np.arange(data.shape[0]))
    ax.set_xticklabels(data.columns)
    ax.set_yticklabels(data.index)

    bottom, top = ax.get_ylim()
    ax.set_ylim(bottom, top)

    if params["data_labels"]:
        for i, row in enumerate(data.index):
            for j, col in enumerate(data.columns):
                ax.text(
                    j,
                    i,
                    f"{data.loc[row, col]:.1%}",
                    ha="center",
                    va="center",
                    color="#000000",
                )

    ax.set_title(params["title"])
    ax.spines["top"].set_visible(False)
    ax.spines["bottom"].set_visible(False)
    ax.spines["left"].set_visible(False)
    ax.spines["right"].set_visible(False)

    cbar = ax.figure.colorbar(im, ax=ax)
    cbar.outline.set_visible(False)

    fig.tight_layout()

    fig.savefig(params["outpath"])
    plt.close()


def _plot_histogram(data, params):

    data = data.dropna()

    fig, ax = plt.subplots(figsize=params["figsize"], frameon=False)

    if params["relative"]:
        weights = np.zeros_like(data) + 1.0 / data.count()
    else:
        weights = np.ones_like(data)

    ax.hist(x=data, bins=params["bins"], color=params["colors"], weights=weights)

    if params["show_mean"]:
        try:
            plt.axvline(data.mean(), color="k", linestyle="dashed", linewidth=1)
            min_ylim, max_ylim = plt.ylim()
            plt.text(data.mean() * 1.1, max_ylim * 0.9, f"Mean: {data.mean():.1f}")
        except TypeError:
            print("type error")

    ax.spines["top"].set_visible(False)
    ax.spines["bottom"].set_visible(False)
    ax.spines["left"].set_visible(False)
    ax.spines["right"].set_visible(False)

    ax.set_ylabel(params["ylabel"])
    ax.set_ybound(params["ybound"])

    ax.set_title(params["title"])

    fig.savefig(params["outpath"])
    plt.close()


def _plot_line_with_ci(data, params):

    x = np.arange(data.shape[0])

    fig, ax = plt.subplots(figsize=(12, 6))

    ax.plot(x, data.iloc[:, 0])
    ax.fill_between(x, data.iloc[:, 1], data.iloc[:, 2], alpha=0.1)

    # format axes
    ax.set_xticks(x)
    ax.set_xticklabels(data.index)

    # format plot area
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    # save figure
    fig.savefig(params["outpath"])
    plt.close()


def _plot_lines_analytics(data, params):

    x = data["x"]

    try:
        figsize = params["figsize"]
    except KeyError:
        figsize = (12, 6)

    data_series = [col for col in data.columns if "x" not in col]

    if params["markers"]:
        plot_markers = markers
    else:
        plot_markers = ["None"] * len(data_series)

    fig, ax = plt.subplots(figsize=figsize)

    fig.tight_layout(rect=(0, 0.05, 1, 1))

    for idx, series in enumerate(data_series):
        ax.plot(
            x,
            data[series],
            linestyle=linestyles[idx],
            marker=plot_markers[idx],
            label=params["labels"][series],
        )

    # format axes
    ax.set_xlabel(params["xlabel"])
    ax.set_xlim(params["xbound"][:2])
    ax.set_xticks(
        np.arange(params["xbound"][0], params["xbound"][1] + 0.01, params["xbound"][2])
    )

    ax.set_ylabel(params["ylabel"])
    ax.set_ylim(params["ybound"][:2])
    ax.set_yticks(
        np.arange(params["ybound"][0], params["ybound"][1] + 0.01, params["ybound"][2])
    )

    # format plot area
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    # add legend
    if params["legend"]:
        ax.legend()

    # save figure
    fig.savefig(params["outpath"])
    plt.close()


def _plot_lines_analytics_all(data, params):

    x = data["x"]

    try:
        figsize = params["figsize"]
    except KeyError:
        figsize = (12, 6)

    data_series = [col for col in data.columns if "x" not in col]

    if params["markers"]:
        plot_markers = [".", ".", ".", "^", "^", "^"]
    else:
        plot_markers = ["None"] * len(data_series)

    plot_linestyles = [(0, ()), (0, ()), (0, ()), (0, (1, 1)), (0, (1, 1)), (0, (1, 1))]

    plot_colors = [
        "tab:blue",
        "tab:orange",
        "tab:green",
        "tab:blue",
        "tab:orange",
        "tab:green",
    ]

    fig, ax = plt.subplots(figsize=figsize)

    fig.tight_layout(rect=(0, 0.05, 1, 1))

    for idx, series in enumerate(data_series):
        ax.plot(
            x,
            data[series],
            color=plot_colors[idx],
            linestyle=plot_linestyles[idx],
            marker=plot_markers[idx],
            label=params["labels"][series],
        )

    # format axes
    ax.set_xlabel(params["xlabel"])
    ax.set_xlim(params["xbound"][:2])
    ax.set_xticks(
        np.arange(params["xbound"][0], params["xbound"][1] + 0.01, params["xbound"][2])
    )

    ax.set_ylabel(params["ylabel"])
    ax.set_ylim(params["ybound"][:2])
    ax.set_yticks(
        np.arange(params["ybound"][0], params["ybound"][1] + 0.01, params["ybound"][2])
    )

    # format plot area
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    # save figure
    fig.savefig(params["outpath"])
    plt.close()


def _plot_lines_simple(data, params):

    x = np.arange(data.shape[0])

    try:
        figsize = params["figsize"]
    except KeyError:
        figsize = (12, 6)

    data_series = data.columns

    if params["markers"]:
        plot_markers = markers
    else:
        plot_markers = ["None"] * len(data_series)

    fig, ax = plt.subplots(figsize=figsize)

    for idx, col in enumerate(data_series):
        ax.plot(
            x,
            data.loc[:, col],
            linestyle=linestyles[idx],
            marker=plot_markers[idx],
            label=params["labels"][idx],
        )

    # format axes
    ax.set_xticks(x)
    ax.set_xticklabels(data.index)

    ax.set_ybound(params["ybound"])

    # format plot area
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    # save figure
    fig.savefig(params["outpath"])
    plt.close()


def _plot_lines_with_error_bars(data, params):

    try:
        figsize = params["figsize"]
    except KeyError:
        figsize = (12, 6)

    if isinstance(params["xlabels"], pd.DatetimeIndex):
        x = params["xlabels"]
    else:
        x = np.arange(
            max(
                max(
                    max(
                        [val.shape for val in value.values()] for value in data.values()
                    )
                )
            )
        )

    if params["markers"]:
        plot_markers = markers
    else:
        plot_markers = ["None"] * len(data)

    fig, ax = plt.subplots(figsize=figsize)

    fig.tight_layout(rect=(0, 0.05, 1, 1))

    ax.set_xlabel(params["xlabel"])

    for idx, group in enumerate(data):

        # plot either line or error bar
        if params["plot_error_bars"]:
            ax.errorbar(
                x,
                data[group]["y"],
                yerr=data[group]["error"],
                linestyle=linestyles[idx],
                marker=plot_markers[idx],
                label=params["labels"][idx],
            )
        else:
            ax.plot(
                x,
                data[group]["y"],
                linestyle=linestyles[idx],
                marker=plot_markers[idx],
                label=params["labels"][idx],
            )

        # add shading for confidence intervals
        if params["plot_ci"]:
            ax.fill_between(
                x, data[group]["ci"][0, :], data[group]["ci"][1, :], alpha=0.1
            )

    # format axes
    if isinstance(params["xlabels"], list):
        ax.set_xticks(x)
        ax.set_xticklabels(params["xlabels"])
    elif isinstance(params["xlabels"], pd.DatetimeIndex):
        ax.set_xlim([params["xlabels"][0], params["xlabels"][-1]])
        ax.xaxis_date()
        ax.xaxis.set_major_formatter(mdates.DateFormatter("%b \n %Y"))

    ax.set_ybound(params["ybound"])

    # format plot area
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    # add legend
    ax.legend()

    # save figure
    fig.savefig(params["outpath"])
    plt.close()


def _plot_pie(data, params):

    fig, ax = plt.subplots(figsize=params["figsize"], frameon=False)
    ax.pie(
        data.values,
        labels=params["labels"],
        autopct="%1.1f%%",
        colors=params["colors"],
    )
    ax.set_title(params["title"])

    fig.savefig(params["outpath"])
    plt.close()


def _plot_stacked_area_100(data, params):

    try:
        figsize = params["figsize"]
    except KeyError:
        figsize = (12, 6)

    x = pd.to_datetime(data.index)

    fig, ax = plt.subplots(figsize=figsize)

    ax.stackplot(
        x,
        data.T,
        labels=data.columns,
        alpha=0.2,
        # colors=colors,
    )

    for idx in range(data.shape[1] - 1):
        ax.plot(
            x,
            data.cumsum(axis=1).iloc[:, idx],
            color="dimgray",
            linestyle="dotted",
        )

    # format axes
    ax.set_xlim(pd.to_datetime([data.index[0], data.index[-1]]))
    ax.xaxis_date()
    ax.xaxis.set_major_formatter(mdates.DateFormatter("%b \n %Y"))

    # format plot area
    ax.margins(0, 0)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    # save figure
    fig.savefig(params["outpath"])
    plt.close()


def _plot_stacked_bar(data, params):

    x = np.arange(data.shape[0])
    bottom = np.zeros(data.shape[0])

    fig, ax = plt.subplots(figsize=params["figsize"], frameon=False)
    for i in range(data.shape[1]):
        y = data.values[:, i]
        ax.bar(
            x,
            y,
            bottom=bottom,
            width=params["barwidth"],
            label=params["categories"][i],
            color=params["colors"][i],
        )
        bottom += y

    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.set_ylabel(params["ylabel"])
    ax.set_ybound(params["ybound"])
    ax.set_title(params["title"])
    ax.set_xticks(x)
    ax.set_xticklabels(params["labels"])

    if params["legend_on"]:
        ax.legend()
        plt.legend(loc="center left", bbox_to_anchor=(1, 0.5), ncol=1)

    fig.savefig(params["outpath"])
    plt.close()


def _plot_time_series(data, params):

    plot_data = data["plot_data"]
    plot_data = plot_data.sort_index()
    plot_data.dropna(axis=0, how="all", inplace=True)

    try:
        shading_data = data["shading_data"]
    except KeyError:
        shading_data = None

    try:
        figsize = params["figsize"]
    except KeyError:
        figsize = (12, 6)

    if params["markers"]:
        plot_markers = markers
    else:
        plot_markers = ["None"] * plot_data.shape[1]

    # create figure
    fig, ax = plt.subplots(figsize=figsize)

    # plot time series
    for idx, col in enumerate(plot_data.columns):
        ax.plot(
            pd.to_datetime(plot_data.index),
            plot_data[col],
            label=params["labels"][col],
            linestyle=linestyles[idx],
            marker=plot_markers[idx],
        )

    # add shaded areas
    if shading_data is not None:
        for i in range(shading_data.shape[0]):
            ax.axvspan(
                pd.to_datetime(shading_data["start"][i]),
                pd.to_datetime(shading_data["end"][i]),
                color=sns.xkcd_rgb["grey"],
                alpha=0.5,
            )

    # remove top and right border
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)

    # format axes
    ax.set_xlim(pd.to_datetime(params["xbound"]))
    ax.xaxis_date()
    ax.xaxis.set_major_formatter(mdates.DateFormatter("%b \n %Y"))

    ax.set_ylim(params["ybound"])
    ax.set_ylabel(params["ylabel"])
    ax.yaxis.grid(linestyle=":")
    # ax.yaxis.set_major_locator(mtick.MultipleLocator(5))
    # ax.yaxis.set_major_formatter(mtick.FormatStrFormatter("%.1f"))

    # add legend
    ax.legend(loc=params["legend_location"])

    # save figure
    fig.savefig(params["outpath"])
    plt.close()


def _plot_time_series_2_axes(data, params):

    data_1 = data["primary"]
    data_2 = data["secondary"]

    cols_1 = list(data_1)
    cols_2 = list(data_2)

    if params["markers"]:
        plot_markers = markers
    else:
        plot_markers = ["None"] * (len(cols_1) + len(cols_2))

    try:
        figsize = params["figsize"]
    except KeyError:
        figsize = (12, 6)

    # create figure
    fig, ax1 = plt.subplots(figsize=figsize)
    ax2 = ax1.twinx()

    # plot time series on primary axis
    for idx, col in enumerate(cols_1):
        ax1.plot(
            pd.to_datetime(data_1[col]["x"]),
            data_1[col]["y"],
            label=col,
            marker=plot_markers[idx],
            linestyle=linestyles[idx],
        )
        if params["plot_ci"]:
            ax1.fill_between(
                pd.to_datetime(data_1[col]["x"]),
                data_1[col]["ci"][0, :],
                data_1[col]["ci"][1, :],
                alpha=0.1,
            )

    # plot time series on secondary axis
    for col in cols_2:
        ax2.plot(
            pd.to_datetime(data_2[col]["x"]),
            data_2[col]["y"],
            label=col,
            color="black",
            marker=plot_markers[idx],
            linestyle=linestyles[len(cols_1) + idx],
        )
        if params["plot_ci"]:
            ax2.fill_between(
                pd.to_datetime(data_2[col]["x"]),
                data_2[col]["ci"][0, :],
                data_2[col]["ci"][1, :],
                color="black",
                alpha=0.1,
            )

    # remove top border
    ax1.spines["top"].set_visible(False)
    ax2.spines["top"].set_visible(False)

    # format axes
    ax1.set_xlim(pd.to_datetime(params["xbound"]))
    ax1.xaxis_date()
    ax1.xaxis.set_major_formatter(mdates.DateFormatter("%b \n %Y"))

    ax1.set_ylim(params["ybound"][0])
    ax1.set_ylabel(params["ylabel"][0])
    ax2.set_ylim(params["ybound"][1])
    ax2.set_ylabel(params["ylabel"][1])

    ax1.margins(0, 0)
    ax2.margins(0, 0)

    # save figure
    fig.savefig(params["outpath"])
    plt.close()
