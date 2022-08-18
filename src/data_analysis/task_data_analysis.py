"""Run data analysis tasks.


"""
import pytask

from src.config import BLD

data = BLD / "out" / "data" / "cps_supplement_tenure_extract.csv"
prod = BLD / "out" / "results" / "cps_returns_to_tenure.csv"


@pytask.mark.r(
    script="estimate_returns.r", options=[str(x.resolve()) for x in [data] + [prod]]
)
@pytask.mark.depends_on(["estimate_returns.r"] + [data])
@pytask.mark.produces(prod)
def task_data_analysis():
    pass
