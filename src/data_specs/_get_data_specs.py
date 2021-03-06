import json

import pandas as pd

from src.config import SRC


#####################################################
# PARAMETERS
#####################################################

# load data description and data specs
cps_data_instructions = json.load(
    open(SRC / "data_specs" / "cps_data_instructions.json")
)
cps_data_descriptions = {
    "basic_monthly": json.load(
        open(SRC / "data_specs" / "cps_data_description_basic_monthly.json")
    ),
    "supplement_asec": json.load(
        open(SRC / "data_specs" / "cps_data_description_supplement_asec.json")
    ),
    "supplement_tenure": json.load(
        open(SRC / "data_specs" / "cps_data_description_supplement_tenure.json")
    ),
}


#####################################################
# FUNCTIONS
#####################################################


def _filter_vardict_cps(vardict, varlist):

    out = {
        key: value for (key, value) in vardict.items() if key in varlist and value != ""
    }

    return out


def _write_data_specs_cps(instructions, description):

    date_start = instructions["date_start"]
    date_end = instructions["date_end"]
    var_list = instructions["variables"]
    prefix = instructions["prefix"]
    frequency = instructions["frequency"]

    surveys_selected = (
        pd.date_range(start=date_start, end=date_end, freq=frequency)
        .strftime("%Y-%m")
        .tolist()
    )

    data_desc = pd.DataFrame.from_dict(description, orient="index")
    data_desc["period"] = pd.to_datetime(data_desc.index)
    data_desc["var_dict"] = data_desc["var_dict"].apply(
        _filter_vardict_cps, args=[var_list]
    )

    specs_out = pd.DataFrame(index=surveys_selected)
    specs_out["in_dir"] = prefix + "_" + specs_out.index
    if prefix == "cpsb":
        specs_out["in_file"] = (
            pd.to_datetime(specs_out.index).strftime("%b%y").str.lower() + "pub"
        )
    else:
        specs_out["in_file"] = prefix + "_" + specs_out.index
    specs_out["out_name"] = prefix + "_" + specs_out.index
    specs_out["period"] = pd.to_datetime(specs_out.index)

    specs_out = pd.merge_asof(specs_out, data_desc, on="period")
    specs_out.index = specs_out["period"].dt.strftime("%Y-%m")
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
            with open(
                SRC
                / "data_specs"
                / "data_specs"
                / survey_name
                / f"{cps_data_instructions[survey_name]['prefix']}_{dataset}.json",
                "w",
            ) as outfile:
                json.dump(data_specs[dataset], outfile, ensure_ascii=False, indent=2)
