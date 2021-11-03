import json
from datetime import datetime

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


def _write_data_specs_cps_basic_monthly(instructions, description):

    date_start = instructions["date_start"]
    date_end = instructions["date_end"]
    var_list = instructions["variables"]

    data_desc = pd.DataFrame.from_dict(description, orient="index")
    data_desc["period"] = pd.to_datetime(data_desc.index)
    data_desc.reset_index(inplace=True)
    data_desc["var_dict"] = data_desc["var_dict"].apply(
        _filter_vardict_cps, args=[var_list]
    )

    specs_out = pd.DataFrame(
        data=pd.date_range(start=date_start, end=date_end, freq="MS"),
        index=pd.date_range(start=date_start, end=date_end, freq="MS").strftime(
            "%Y-%m"
        ),
        columns=["period"],
    )
    specs_out["in_dir"] = "cpsb_" + specs_out["period"].dt.strftime("%Y-%m")
    specs_out["in_file"] = specs_out["period"].dt.strftime("%b%y").str.lower() + "pub"
    specs_out["out_name"] = "cpsb_" + specs_out["period"].dt.strftime("%Y-%m")
    specs_out = pd.merge_asof(specs_out, data_desc, on="period")
    specs_out.set_index(specs_out["period"].dt.strftime("%Y-%m"), inplace=True)
    specs_out.drop(columns=["period", "index"], inplace=True)
    specs_out = specs_out.to_dict("index")

    return specs_out


def _write_data_specs_cps_supplement(instructions, description):

    date_start = datetime.strptime(instructions["date_start"], "%Y-%m")
    date_end = datetime.strptime(instructions["date_end"], "%Y-%m")
    var_list = instructions["variables"]
    prefix = instructions["prefix"]

    surveys_all = list(description.keys())
    surveys_all = [datetime.strptime(survey, "%Y-%m") for survey in surveys_all]

    surveys_selected = []
    for survey in surveys_all:
        if date_start <= survey <= date_end:
            surveys_selected.append(survey)

    surveys_selected = [
        datetime.strftime(survey, "%Y-%m") for survey in surveys_selected
    ]

    data_desc = pd.DataFrame.from_dict(description, orient="index")
    data_desc["var_dict"] = data_desc["var_dict"].apply(
        _filter_vardict_cps, args=[var_list]
    )

    specs_out = pd.DataFrame(index=surveys_selected)
    specs_out["in_dir"] = prefix + "_" + specs_out.index
    specs_out["in_file"] = prefix + "_" + specs_out.index
    specs_out["out_name"] = prefix + "_" + specs_out.index

    specs_out = specs_out.join(data_desc)
    specs_out = specs_out.to_dict("index")

    return specs_out


def _write_data_specs_cps(survey, instructions, description):

    if survey == "basic_monthly":
        data_specs = _write_data_specs_cps_basic_monthly(instructions, description)
    elif survey == "supplement_asec":
        data_specs = _write_data_specs_cps_supplement(instructions, description)
    elif survey == "supplement_tenure":
        data_specs = _write_data_specs_cps_supplement(instructions, description)
    else:
        raise ValueError(
            f"survey name {survey} unknown;"
            " please choose one of ['basic_monthly', 'supplement_asec', 'supplement_tenure']"
        )

    return data_specs


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    surveys = ["basic_monthly", "supplement_asec", "supplement_tenure"]

    for survey_name in surveys:
        prefix = cps_data_instructions[survey_name]["prefix"]

        # get data specs
        data_specs = _write_data_specs_cps(
            survey_name,
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
                / f"{prefix}_{dataset}.json",
                "w",
            ) as outfile:
                json.dump(data_specs[dataset], outfile, ensure_ascii=False, indent=2)
