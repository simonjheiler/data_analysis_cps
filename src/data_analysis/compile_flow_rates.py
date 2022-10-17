import json

import pandas as pd

from src.config import BLD
from src.config import DAT
from src.config import SRC


#####################################################
# PARAMETERS
#####################################################

idx = pd.IndexSlice

cps_data_instructions = json.load(
    open(SRC / "data_specs" / "cps_data_instructions.json")
)

data_types_cps_monthly = {
    "match_identifier": str,
    "year": int,
    "month": int,
    "state": str,
    "sex": str,
    "age": "Int8",
    "age_group": "category",
    "race_reduced": "category",
    "education_reduced": "category",
    "labor_force_status_reduced": "category",
    "marital_status_reduced": "category",
    "weight_long": float,
    "weight_personal": float,
    "separation_1m": float,
    "match_1m": float,
    "separation_3m": float,
    "match_3m": float,
}


#####################################################
# FUNCTIONS
#####################################################


def _compile_average_flow_rates():

    # read in and merge data
    df = pd.read_csv(
        DAT / "cps" / "basic_monthly" / "results" / "cps_basic_monthly_extract.csv",
        dtype=data_types_cps_monthly,
    )

    cols_analysis = ["separation_1m", "match_1m"]

    for col in cols_analysis:
        df.loc[:, f"{col}_obs"] = ~df.loc[:, col].isna()
        df.loc[:, f"{col}_weighted"] = df.loc[:, col] * df.loc[:, "weight_long"]
        df.loc[:, f"{col}_obs_weighted"] = (
            df.loc[:, f"{col}_obs"] * df.loc[:, "weight_long"]
        )

    age_groups = df.age_group.unique().sort_values()
    race_cats = df.race.unique()

    index = pd.MultiIndex.from_product(
        [age_groups, race_cats], names=["age_group", "race"]
    )
    df_out = pd.DataFrame(index=index)
    for col in cols_analysis:
        tmp_df = df.dropna(subset=[col])
        tmp_df = (
            tmp_df[
                [
                    "age_group",
                    "race",
                    f"{col}",
                    f"{col}_weighted",
                    f"{col}_obs",
                    f"{col}_obs_weighted",
                ]
            ]
            .groupby(["age_group", "race"])
            .sum()
        )
        tmp_df.loc[:, f"{col}"] = tmp_df.loc[:, f"{col}"] / tmp_df.loc[:, f"{col}_obs"]
        tmp_df.loc[:, f"{col}_weighted"] = (
            tmp_df.loc[:, f"{col}_weighted"] / tmp_df.loc[:, f"{col}_obs_weighted"]
        )
        tmp_df = tmp_df.drop(columns=[f"{col}_obs", f"{col}_obs_weighted"])
        df_out = pd.merge(left=df_out, right=tmp_df, left_index=True, right_index=True)

    return df_out


#####################################################
# SCRIPT
#####################################################

if __name__ == "__main__":

    df_out = _compile_average_flow_rates()

    df_out.to_csv(BLD / "results" / "cps_flow_rates_age_race.csv", index=True)
