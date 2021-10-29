import os

import pytask

from src.config import BLD
from src.data_management.compile_dataset import _compile_long_df


survey_name = "supplement_tenure"

infiles = os.listdir(BLD / "out" / "data" / survey_name)

data = [
    BLD / "out" / "data" / survey_name / x
    for x in infiles
    if os.path.isfile(BLD / "out" / "data" / survey_name / x)
]
prod = BLD / "out" / "data" / f"cps_extract_{survey_name}.csv"


@pytask.mark.depends_on(data)
@pytask.mark.produces(prod)
def task_compile_data():
    _compile_long_df(data, prod, survey_name)
