"""Run output tasks.


"""
import pytask

from src.config import BLD
from src.output.create_figures import create_figures

data = [
    BLD / "results" / "cps_returns_to_tenure.csv",
    BLD / "results" / "cps_flow_rates_age_race.csv",
]
prod = [
    BLD / "figures" / "cps_earnings_tenure_education.pdf",
    BLD / "figures" / "cps_separation_1m_age_race.pdf",
    BLD / "figures" / "cps_match_1m_age_race.pdf",
]


@pytask.mark.depends_on(data)
@pytask.mark.produces(prod)
def task_data_analysis():
    create_figures()
