"""Run output tasks.


"""
import pytask

from src.config import BLD
from src.output.create_figures import create_figures

data = BLD / "results" / "cps_returns_to_tenure.csv"
prod = BLD / "figures" / "cps_earnings_tenure_education.pdf"


@pytask.mark.depends_on(data)
@pytask.mark.produces(prod)
def task_data_analysis():
    create_figures()
