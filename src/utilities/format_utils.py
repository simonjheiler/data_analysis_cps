import numpy as np
import pandas as pd


#####################################################
# PARAMETERS
#####################################################

# relabeling containers for categorical variables
education_reduced_cat = {
    "nan": np.nan,
    "None , kindergarten or children": "Less than 5th Grade",
    "NONE": "Less than 5th Grade",
    "E1": "Less than 5th Grade",
    "E2": "Less than 5th Grade",
    "E3": "Less than 5th Grade",
    "E4": "Less than 5th Grade",
    "E5": "5th Grade to 12th Grade without Diploma",
    "E6": "5th Grade to 12th Grade without Diploma",
    "E7": "5th Grade to 12th Grade without Diploma",
    "E8": "5th Grade to 12th Grade without Diploma",
    "H1": "5th Grade to 12th Grade without Diploma",
    "H2": "5th Grade to 12th Grade without Diploma",
    "H3": "5th Grade to 12th Grade without Diploma",
    "H4": "tbd_hs",
    "C1": "Some College or Associate Degree",
    "C2": "Some College or Associate Degree",
    "C3": "Some College or Associate Degree",
    "C4": "tbd_college",
    "C5": "Bachelor's degree and higher",
    "C6+": "Bachelor's degree and higher",
    "CHILDREN": "Less than 5th Grade",
    "LESS THAN 1ST GRADE": "Less than 5th Grade",
    "1ST, 2ND, 3RD OR 4TH GRADE": "Less than 5th Grade",
    "5TH OR 6TH GRADE": "5th Grade to 12th Grade without Diploma",
    "7TH OR 8TH GRADE": "5th Grade to 12th Grade without Diploma",
    "9TH GRADE": "5th Grade to 12th Grade without Diploma",
    "10TH GRADE": "5th Grade to 12th Grade without Diploma",
    "11TH GRADE": "5th Grade to 12th Grade without Diploma",
    "12TH GRADE NO DIPLOMA": "5th Grade to 12th Grade without Diploma",
    "HIGH SCHOOL GRAD-DIPLOMA OR": "High School Graduates, No College",
    "HIGH SCHOOL GRAD-DIPLOMA OR EQUIV (GED)": "High School Graduates, No College",
    "SOME COLLEGE BUT NO DEGREE": "Some College or Associate Degree",
    "ASSOCIATE DEGREE-": "Some College or Associate Degree",
    "ASSOCIATE DEGREE-OCCUPATIONAL/VOCATIONAL": "Some College or Associate Degree",
    "ASSOCIATE DEGREE-ACADEMIC": "Some College or Associate Degree",
    "ASSOCIATE DEGREE-ACADEMIC PROGRAM": "Some College or Associate Degree",
    "BACHELOR'S DEGREE (EX: BA, AB,": "Bachelor's degree and higher",
    "BACHELOR'S DEGREE (EX: BA, AB, BS)": "Bachelor's degree and higher",
    "MASTER'S DEGREE (EX: MA, MS,": "Bachelor's degree and higher",
    "MASTER'S DEGREE (EX: MA, MS, MEng, MEd, MSW)": "Bachelor's degree and higher",
    "PROFESSIONAL SCHOOL DEG (EX: MD,": "Bachelor's degree and higher",
    "PROFESSIONAL SCHOOL DEG (EX: MD, DDS, DVM)": "Bachelor's degree and higher",
    "DOCTORATE DEGREE (EX: PhD, EdD)": "Bachelor's degree and higher",
}

labor_force_status_reduced_cat = {
    "NIU": "not in universe",
    "EMPLOYED-AT WORK": "employed",
    "EMPLOYED-ABSENT": "employed",
    "UNEMPLOYED-ON LAYOFF": "unemployed",
    "UNEMPLOYED-LOOKING": "unemployed",
    "NOT IN LABOR FORCE-RETIRED": "not in labor force",
    "NOT IN LABOR FORCE-DISABLED": "not in labor force",
    "NOT IN LABOR FORCE-OTHER": "not in labor force",
    "NOT IN LABOR FORCE-UNAVAILABLE": "not in labor force",
    "NOT IN LABOR FORCE-WORKING W/O PAY LESS": "not in labor force",
}

race_reduced_cat = {
    "White": "white",
    "White only": "white",
    "White Only": "white",
    "Black": "black",
    "Black only": "black",
    "Black Only": "black",
    "American Indian, Aleut Eskimo": "other",
    "American Indian, Alaskan Native only": "other",
    "American Indian, Alaskan Native Only": "other",
    "Asian or Pacific Islander": "other",
    "Asian only": "other",
    "Asian Only": "other",
    "Hawaiian/Pacific Islander only": "other",
    "Hawaiian/Pacific Islander Only": "other",
    "Other": "other",
    "White-Black": "other",
    "White-AI": "other",
    "White-Asian": "other",
    "White-Hawaiian": "other",
    "White-HP": "other",
    "Black-AI": "other",
    "Black-Asian": "other",
    "Black-HP": "other",
    "AI-Asian": "other",
    "AI-HP": "other",
    "Asian-HP": "other",
    "White-Black-AI": "other",
    "W-B-AI": "other",
    "White-Black-Asian": "other",
    "W-B-A": "other",
    "White-Black-HP": "other",
    "W-B-HP": "other",
    "White-AI-Asian": "other",
    "W-AI-A": "other",
    "White-AI-HP": "other",
    "W-AI-HP": "other",
    "White-Asian-HP": "other",
    "W-A-HP": "other",
    "Black-AI-Asian": "other",
    "B-AI-A": "other",
    "White-Black-AI-Asian": "other",
    "W-B-AI-A": "other",
    "White-AI-Asian-HP": "other",
    "W-AI-A-HP": "other",
    "2 or 3 races": "other",
    "2 or 3 Races": "other",
    "Other 3 Race Combinations": "other",
    "4 or 5 races": "other",
    "4 or 5 Races": "other",
    "Other 4 and 5 Race Combinations": "other",
}

married_reduced_cat = {
    "Married - AF spouse present": "married",
    "MARRIED - AF SPOUSE PRESENT": "married",
    "Married - civilian spouse present": "married",
    "MARRIED - CIVILIAN SPOUSE PRESENT": "married",
    "Married - spouse present": "married",
    "MARRIED-SPOUSE PRESENT": "married",
    "MARRIED - SPOUSE PRESENT": "married",
    "Married - spouse absent (exc separated)": "married",
    "MARRIED - SPOUSE ABSENT (EXC SEPARATED)": "married",
    "MARRIED-SPOUSE ABSENT": "married",
    "MARRIED - SPOUSE ABSENT": "married",
    "Widowed": "not married",
    "WIDOWED": "not married",
    "Divorced": "not married",
    "DIVORCED": "not married",
    "Separated": "not married",
    "SEPARATED": "not married",
    "Never married": "not married",
    "NEVER MARRIED": "not married",
}

age_thresholds = [
    -np.inf,
    14,
    19,
    24,
    29,
    34,
    39,
    44,
    49,
    54,
    59,
    64,
    69,
    74,
    79,
    84,
    np.inf,
]
age_groups = [
    "14 and younger",
    "15 to 19",
    "20 to 24",
    "25 to 29",
    "30 to 34",
    "35 to 39",
    "40 to 44",
    "45 to 49",
    "50 to 54",
    "55 to 59",
    "60 to 64",
    "65 to 69",
    "70 to 74",
    "75 to 79",
    "80 to 84",
    "85 and older",
]


#####################################################
# FUNCTIONS
#####################################################


def _add_categorical_variables(df):

    # labor force status
    df.loc[:, "labor_force_status_reduced"] = df["labor_force_status"].replace(
        labor_force_status_reduced_cat
    )

    # educational attainment
    df.loc[:, "education_reduced"] = df["education"].replace(education_reduced_cat)

    if "grade_completed" in df.columns:
        df.loc[
            df[
                (df.education_reduced == "tbd_hs") & (df.grade_completed == "YES")
            ].index,
            "education_reduced",
        ] = "High School Graduates, No College"
        df.loc[
            df[(df.education_reduced == "tbd_hs") & (df.grade_completed == "NO")].index,
            "education_reduced",
        ] = "5th Grade to 12th Grade without Diploma"

        df.loc[
            df[
                (df.education_reduced == "tbd_college") & (df.grade_completed == "YES")
            ].index,
            "education_reduced",
        ] = "Bachelor's degree and higher"
        df.loc[
            df[
                (df.education_reduced == "tbd_college") & (df.grade_completed == "NO")
            ].index,
            "education_reduced",
        ] = "Some College or Associate Degree"

    # marital status
    df.loc[:, "marital_status_reduced"] = df["marital_status"].replace(
        married_reduced_cat
    )

    # race
    df.loc[:, "race_reduced"] = df["race"].replace(race_reduced_cat)

    # age group
    df.loc[:, "age_group"] = pd.cut(
        df["age"], age_thresholds, right=True, labels=age_groups
    )

    return df


def _drop_out_of_scope(df, cols_req):

    # drop all observations that have nan in required column
    df = df.dropna(subset=cols_req)

    return df
