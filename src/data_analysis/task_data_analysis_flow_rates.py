"""Run data analysis tasks.


"""
import pytask

from src.config import BLD
from src.config import DAT
from src.data_analysis.compile_flow_rates import _compile_average_flow_rates

data = DAT / "cps" / "basic_monthly" / "results" / "cps_basic_monthly_extract.csv"
prod = BLD / "results" / "cps_flow_rates_age_race.csv"


@pytask.mark.depends_on(data)
@pytask.mark.produces(prod)
def task_data_analysis_flow_rates():

    df_out = _compile_average_flow_rates()

    df_out.to_csv(BLD / "results" / "cps_flow_rates_age_race.csv", index=True)
