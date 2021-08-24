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
cps_description_basic_monthly = json.load(
    open(SRC / "data_specs" / "cps_data_description_basic_monthly.json")
)
cps_description_supplement_asec = json.load(
    open(SRC / "data_specs" / "cps_data_description_supplement_asec.json")
)
cps_description_supplement_tenure = json.load(
    open(SRC / "data_specs" / "cps_data_description_supplement_tenure.json")
)


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
    specs_out["in_name"] = specs_out["period"].dt.strftime("%b%y").str.lower() + "pub"
    specs_out["out_name"] = "cpsb_" + specs_out["period"].dt.strftime("%Y-%m")
    specs_out = pd.merge_asof(specs_out, data_desc, on="period")
    specs_out.set_index(specs_out["period"].dt.strftime("%Y-%m"), inplace=True)
    specs_out.drop(columns=["period", "index"], inplace=True)
    specs_out = specs_out.to_dict("index")

    return specs_out


def _write_data_specs_cps_supplement_asec(instructions, description):

    date_start = cps_data_instructions["supplement_asec"]["date_start"]
    date_end = cps_data_instructions["supplement_asec"]["date_end"]
    var_list = cps_data_instructions["supplement_asec"]["variables"]

    data_desc = pd.DataFrame.from_dict(cps_description_supplement_asec, orient="index")
    data_desc["var_dict"] = data_desc["var_dict"].apply(
        _filter_vardict_cps, args=[var_list]
    )

    specs_out = pd.DataFrame(
        index=pd.date_range(start=date_start, end=date_end, freq="YS").strftime("%Y-%m")
    )
    specs_out["in_name"] = "cpsa" + specs_out.index
    specs_out["out_name"] = "cpsa_" + specs_out.index

    specs_out = specs_out.join(data_desc)
    specs_out = specs_out.to_dict("index")

    return specs_out


def _write_data_specs_cps_supplement_tenure(instructions, description):

    date_start = datetime.strptime(instructions["date_start"], "%Y-%m")
    date_end = datetime.strptime(instructions["date_end"], "%Y-%m")
    var_list = instructions["variables"]

    surveys_all = list(description.keys())
    surveys_all = [datetime.strptime(survey, "%Y-%m") for survey in surveys_all]

    surveys_selected = []
    for survey in surveys_all:
        if survey >= date_start and survey <= date_end:
            surveys_selected.append(survey)

    surveys_selected = [
        datetime.strftime(survey, "%Y-%m") for survey in surveys_selected
    ]

    data_desc = pd.DataFrame.from_dict(description, orient="index")
    data_desc["var_dict"] = data_desc["var_dict"].apply(
        _filter_vardict_cps, args=[var_list]
    )

    specs_out = pd.DataFrame(index=surveys_selected)
    specs_out["in_name"] = "cpst_" + specs_out.index
    specs_out["out_name"] = "cpst_" + specs_out.index

    specs_out = specs_out.join(data_desc)
    specs_out = specs_out.to_dict("index")

    return specs_out


def _write_data_specs_cps(survey, instructions, description):

    if survey == "basic_monthly":
        data_specs = _write_data_specs_cps_basic_monthly(instructions, description)
    elif survey == "supplement_asec":
        data_specs = _write_data_specs_cps_supplement_asec(instructions, description)
    elif survey == "supplement_tenure":
        data_specs = _write_data_specs_cps_supplement_tenure(instructions, description)
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

    # get data specs
    data_specs_basic_monthly = _write_data_specs_cps_basic_monthly()
    data_specs_supplement_asec = _write_data_specs_cps_supplement_asec()
    data_specs_supplement_tenure = _write_data_specs_cps_supplement_tenure()

    # write individual specification files to build directory
    for dataset in data_specs_basic_monthly:
        with open(
            SRC
            / "data_specs"
            / "data_specs"
            / "basic_monthly"
            / f"cpsb_{dataset}.json",
            "w",
        ) as outfile:
            json.dump(
                data_specs_basic_monthly[dataset], outfile, ensure_ascii=False, indent=2
            )
    for dataset in data_specs_supplement_asec:
        with open(
            SRC
            / "data_specs"
            / "data_specs"
            / "supplement_asec"
            / f"cpsa_{dataset}.json",
            "w",
        ) as outfile:
            json.dump(
                data_specs_supplement_asec[dataset],
                outfile,
                ensure_ascii=False,
                indent=2,
            )
    for dataset in data_specs_supplement_tenure:
        with open(
            SRC
            / "data_specs"
            / "data_specs"
            / "supplement_tenure"
            / f"cpst_{dataset}.json",
            "w",
        ) as outfile:
            json.dump(
                data_specs_supplement_tenure[dataset],
                outfile,
                ensure_ascii=False,
                indent=2,
            )
