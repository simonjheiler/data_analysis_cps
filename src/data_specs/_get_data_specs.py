import json
from pathlib import Path

import pandas as pd

from src.config import SRC

#####################################################
# PARAMETERS
#####################################################

# load data description and data specs
with Path.open(SRC / "data_specs" / "cps_data_instructions.json") as file:
    cps_data_instructions = json.load(file)
with Path.open(SRC / "data_specs" / "cps_data_description_basic_monthly.json") as file:
    cps_data_description_basic_monthly = json.load(file)
with Path.open(
    SRC / "data_specs" / "cps_data_description_supplement_asec.json",
) as file:
    cps_data_description_supplement_asec = json.load(file)
with Path.open(
    SRC / "data_specs" / "cps_data_description_supplement_tenure.json",
) as file:
    cps_data_description_supplement_tenure = json.load(file)

cps_data_descriptions = {
    "basic_monthly": cps_data_description_basic_monthly,
    "supplement_asec": cps_data_description_supplement_asec,
    "supplement_tenure": cps_data_description_supplement_tenure,
}


#####################################################
# FUNCTIONS
#####################################################


def _filter_vardict_cps(vardict, varlist):
    """Filter variable dictionary for entries included in list."""
    return {key: value for (key, value) in vardict.items() if key in varlist and value}


def _write_data_specs_cps(instructions, description):
    """Compile specifications to extract data from CPS raw data files."""
    # load instructions
    date_start = instructions["date_start"]
    date_end = instructions["date_end"]
    date_format = instructions["date_format"]
    var_list = instructions["variables"]
    prefix = instructions["prefix"]
    frequency = instructions["frequency"]

    # generate file list
    specs_out = pd.DataFrame(
        index=pd.date_range(start=date_start, end=date_end, freq=frequency)
        .strftime(date_format)
        .tolist(),
    )

    data_desc = pd.DataFrame.from_dict(description, orient="index")
    data_desc["period"] = pd.to_datetime(data_desc.index)
    data_desc["var_dict"] = data_desc["var_dict"].apply(
        _filter_vardict_cps,
        args=[var_list],
    )

    specs_out.loc[:, "in_dir"] = prefix + "_" + specs_out.index.to_numpy()
    if prefix == "cpsb":
        specs_out.loc[:, "in_file"] = (
            pd.to_datetime(specs_out.index).strftime("%b%y").str.lower() + "pub"
        )
    else:
        specs_out["in_file"] = prefix + "_" + specs_out.index
    specs_out["out_name"] = prefix + "_" + specs_out.index
    specs_out["period"] = pd.to_datetime(specs_out.index)

    specs_out = pd.merge_asof(specs_out, data_desc, on="period")
    specs_out.index = specs_out["period"].dt.strftime(date_format)
    specs_out = specs_out.drop(columns="period")
    specs_out = specs_out.to_dict("index")

    return specs_out


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":
    surveys = ["basic_monthly", "supplement_asec", "supplement_tenure"]

    for survey_name in surveys:
        # get data specs
        data_specs = _write_data_specs_cps(
            cps_data_instructions[survey_name],
            cps_data_descriptions[survey_name],
        )

        # write individual specification files to build directory
        for dataset in data_specs:
            with Path.open(
                SRC
                / "data_specs"
                / "data_specs"
                / survey_name
                / f"{cps_data_instructions[survey_name]['prefix']}_{dataset}.json",
                "w",
            ) as outfile:
                json.dump(data_specs[dataset], outfile, ensure_ascii=False, indent=2)
