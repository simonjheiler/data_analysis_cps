import os

import pytask

from src.config import BLD
from src.data_management.compile_dataset import _compile_long_df


surveys = ["supplement_asec", "supplement_tenure"]


@pytask.mark.parametrize(
    "depends_on, produces, survey_name",
    [
        (
            [
                BLD / "out" / "data" / survey / x
                for x in os.listdir(BLD / "out" / "data" / survey)
                if os.path.isfile(BLD / "out" / "data" / survey / x)
            ],
            BLD / "out" / "data" / f"cps_{survey}_extract.csv",
            survey,
        )
        for survey in surveys
    ],
)
def task_compile_data(depends_on, produces, survey_name):
    _compile_long_df(depends_on, produces, survey_name)
