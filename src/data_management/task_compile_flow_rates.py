import pytask

from src.config import BLD
from src.data_management.compile_flow_rates import _compile_flow_rates_df

survey_years = [
    "1990",
    "1991",
    "1992",
    "1993",
    "1994",
    "1995",
    "1996",
    "1997",
    "1998",
    "1999",
    "2000",
    "2001",
    "2002",
    "2003",
    "2004",
    "2005",
    "2006",
    "2007",
    "2008",
    "2009",
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
]

months = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
]

deps = []
for year in survey_years:

    # add current year surveys
    deps += [f"{year}-{month}" for month in months]

    # add -12m surveys
    deps += [f"{str(int(year) - 1)}-{month}" for month in months]

# remove duplicates and transform to paths
deps = list(set(deps))
deps = [BLD / "out" / "data" / "basic_monthly" / f"cpsb_{dep}.csv" for dep in deps]


@pytask.mark.depends_on(deps)
@pytask.mark.produces([BLD / "out" / "datasets" / "cps_12m_flow_rates.csv"])
def task_compile_flow_rates():

    df_out = _compile_flow_rates_df(survey_years)
    df_out.to_csv(BLD / "out" / "datasets" / "cps_12m_flow_rates.csv", index=True)
