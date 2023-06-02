import pandas as pd

from src.config import DAT
from src.data_management.compile_monthly_data_cps import data_types_cps_monthly

# from src.config import SRC

df_cohort_age_time = pd.read_csv(
    DAT
    / "cps"
    / "basic_monthly"
    / "results"
    / "cps_transitions_rates_age_cohort_time.csv",
    index_col=[0, 1, 2],
)


def _get_switches(in_data, out_path):

    # date_start = data_instructions["basic_monthly"]["date_start"]
    # date_end = data_instructions["basic_monthly"]["date_end"]

    date_start = "2000-07"
    date_end = "2000-07"

    periods = pd.date_range(start=date_start, end=date_end, freq="MS").strftime("%Y-%m")

    cols_analysis = [
        "year",
        "month",
        "state",
        "sex",
        "age",
        "age_group",
        "marital_status",
        "race",
        "education",
        "spousal_status",
        "working_spouse",
        "labor_force_status",
        "n_children",
        "same_employer",
        "same_occupation",
        "weight_long",
        "weight_personal",
        "weight_bls",
    ]

    # initiate object to store data and iterable
    analysis_df = pd.DataFrame(columns=cols_analysis)

    for index, _ in enumerate(periods):

        # read in data
        in_file = in_data[index]
        tmp_df = pd.read_csv(in_file, dtype=data_types_cps_monthly)

        # drop observations with missing values in required field
        tmp_df.dropna(subset=["age"], inplace=True)
        tmp_df.dropna(subset=["labor_force_status_reduced"], inplace=True)

        # drop observations that are out of scope
        tmp_df = tmp_df[tmp_df.sex == "MALE"]
        tmp_df = tmp_df[tmp_df.age >= 16]
        tmp_df = tmp_df[tmp_df.age <= 64]

        # change column labels in accordance with output df
        tmp_df = tmp_df.rename(
            columns={
                "labor_force_status_reduced": "labor_force_status",
                "education_reduced": "education",
                "race_reduced": "race",
                "marital_status_reduced": "marital_status",
            }
        )

        # append current data to output df
        analysis_df = pd.concat([analysis_df, tmp_df[cols_analysis]], axis=0)

    analysis_df.to_csv(out_path, index=False)

    return


if __name__ == "__main__":

    # survey_name = "basic_monthly"
    #
    # file_names = ["cpsb_2000-07.csv"]
    #
    # deps = [DAT / "cps" / survey_name / "formatted" / x for x in file_names]
    # prod = DAT / "cps" / survey_name / "results" / f"cps_{survey_name}_extract.csv"
    #
    # _get_switches(deps, prod)

    df_cohort_age_time.loc[:, "age_group"] = pd.cut()

    print("done")
