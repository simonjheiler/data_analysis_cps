import pytask

from src.config import BLD
from src.config import SRC

# data = SRC / "original_data" / "ajrcomment.dta"
# prod = BLD / "data" / "ajrcomment_all.csv"
#
#
# @pytask.mark.r([str(x.resolve()) for x in [data, prod]])
# @pytask.mark.depends_on(["add_variables.r", data])
# @pytask.mark.produces(prod)
# def task_ajr_comment_data():
#     pass


# datasets = [
#     "SCFP1989.csv",
#     "SCFP1992.csv",
#     "SCFP1995.csv",
#     "SCFP1998.csv",
#     "SCFP2001.csv",
#     "SCFP2004.csv",
#     "SCFP2007.csv",
#     "SCFP2010.csv",
#     "SCFP2013.csv",
#     "SCFP2016.csv",
#     "SCFP2019.csv",
# ]
#
# data = [SRC / "original_data" / "extracts" / x for x in datasets]
# prod = BLD / "data" / "scf_extract.csv"
#
#
# @pytask.mark.r([str(x.resolve()) for x in data + [prod]])
# @pytask.mark.depends_on(["get_assets_over_income.r"] + data)
# @pytask.mark.produces(prod)
def task_get_assets_over_income():
    pass
