import json
import os
from pathlib import Path

import pytask

from src.config import BLD
from src.config import SRC


survey_name = "supplement_tenure"

in_path = SRC / "data_specs" / "data_specs" / survey_name

in_specs = list(in_path.glob("cpst_*.json"))

in_names = [os.path.basename(spec) for spec in in_specs]

stata_instructions = []
for spec_path in in_specs:

    in_file = os.path.basename(spec_path)
    in_file_name = os.path.splitext(in_file)[0]

    tmp = json.load(open(spec_path))
    tmp_instructions = {
        "do": Path("extract_data.do"),
        "deps": [
            spec_path,
            SRC / "original_data" / survey_name / f"{tmp['in_name']}.zip",
            SRC / "data_management" / survey_name / tmp["read_file"],
            SRC / "data_specs" / "data_dicts" / survey_name / tmp["data_dict"],
        ],
        "log": BLD / "out" / "data" / survey_name / "log" / f"{tmp['out_name']}.log",
        "in_file_name": in_file_name,
        "path_out": BLD / "out" / "data" / survey_name,
        "result": BLD / "out" / "data" / survey_name / f"{tmp['out_name']}.csv",
        "variables": " ".join(list(tmp["var_dict"].values())),
    }
    stata_instructions.append(tmp_instructions)

print("Test")


@pytask.mark.parametrize(
    "stata, depends_on, produces",
    [
        (
            [
                str(x)
                for x in [
                    s["in_file_name"],
                    s["log"],
                    *s["deps"],
                    s["path_out"],
                    s["result"],
                    s["variables"],
                ]
            ],
            [s["do"], *s["deps"]],
            [s["result"]],
        )
        for s in stata_instructions
    ],
)
def task_estimate():
    pass


# # define specs directories as nodes
# cps_specs_monthly = abs_rel_paths("IN_DATA_SPECS", "cps", "specs", "monthly")["rel"]
# cps_specs_monthly = ctx.path.make_node(cps_specs_monthly)
#
# # extract and format CPS basic monthly data
# for node in cps_specs_monthly.ant_glob("cpsb_*.json"):
#
#     data_specs = node.read_json()
#     dataset = os.path.basename(str(node))
#
#     in_name = data_specs["in_name"]
#     out_name = data_specs["out_name"]
#     read_file = data_specs["read_file"]
#     data_dict = data_specs["data_dict"]
#     variables = [data_specs["var_dict"][key] for key in data_specs["var_dict"]]
#     variables += data_specs["identifier"]
#
#     append = ["monthly", in_name, out_name, read_file, data_dict]
#     append += variables
#
#     ctx(
#         features="run_do_script",
#         source=ctx.path_to(ctx, "IN_DATA_MGMT", "get_data_cps.do"),
#         deps=[
#             ctx.path_to(ctx, "IN_DATA_SPECS", "cps", "specs", "monthly", dataset),
#             ctx.path_to(ctx, "IN_DATA_SPECS", "cps_monthly", data_dict),
#             ctx.path_to(ctx, "IN_DATA_MGMT", "cps_monthly", read_file),
#         ],
#         target=[
#             ctx.path_to(
#                 ctx, "OUT_DATA", "cps_monthly", "raw", out_name + "_raw.csv"
#             ),
#             ctx.path_to(
#                 ctx, "OUT_DATA", "cps_monthly", "raw", "log", out_name + ".log"
#             ),
#         ],
#         append=append,
#     )
#
#     ctx.add_group()
#
# for node in cps_specs_monthly.ant_glob("cpsb_*.json"):
#
#     data_specs = node.read_json()
#     dataset = os.path.splitext(os.path.basename(str(node)))[0]
#
#     in_name = data_specs["in_name"]
#     out_name = data_specs["out_name"]
#
#     ctx(
#         features="run_py_script",
#         source="format_data_cps_monthly.py",
#         deps=[
#             ctx.path_to(
#                 ctx, "OUT_DATA", "cps_monthly", "raw", out_name + "_raw.csv"
#             ),
#             ctx.path_to(ctx, "IN_DATA", "misc", "cps_us_state_codes.csv"),
#         ],
#         target=ctx.path_to(ctx, "OUT_DATA", "cps_monthly", out_name + ".csv"),
#         name="format_data_cps_monthly",
#         append=dataset,
#     )
#
# # extract and format CPS March supplement data
# for node in cps_specs_yearly.ant_glob("cpsy_*.json"):
#
#     data_specs = node.read_json()
#     dataset = os.path.basename(str(node))
#
#     in_name = data_specs["in_name"]
#     out_name = data_specs["out_name"]
#     read_file = data_specs["read_file"]
#     data_dict = data_specs["data_dict"]
#     variables = [data_specs["var_dict"][key] for key in data_specs["var_dict"]]
#
#     append = ["yearly", in_name, out_name, read_file, data_dict]
#     append += variables
#
#     ctx(
#         features="run_do_script",
#         source=ctx.path_to(ctx, "IN_DATA_MGMT", "get_data_cps.do"),
#         deps=[
#             ctx.path_to(ctx, "IN_DATA_SPECS", "cps", "specs", "yearly", dataset),
#             ctx.path_to(ctx, "IN_DATA_SPECS", "cps_yearly", data_dict),
#             ctx.path_to(ctx, "IN_DATA_MGMT", "cps_yearly", read_file),
#         ],
#         target=[
#             ctx.path_to(
#                 ctx, "OUT_DATA", "cps_yearly", "raw", out_name + "_raw.csv"
#             ),
#             ctx.path_to(
#                 ctx, "OUT_DATA", "cps_yearly", "raw", "log", out_name + ".log"
#             ),
#         ],
#         append=append,
#     )
#
#     ctx.add_group()
#
# for node in cps_specs_yearly.ant_glob("cpsy_*.json"):
#
#     data_specs = node.read_json()
#     dataset = os.path.splitext(os.path.basename(str(node)))[0]
#
#     in_name = data_specs["in_name"]
#     out_name = data_specs["out_name"]
#
#     ctx(
#         features="run_py_script",
#         source="format_data_cps_yearly.py",
#         deps=[
#             ctx.path_to(
#                 ctx, "OUT_DATA", "cps_yearly", "raw", out_name + "_raw.csv"
#             ),
#             ctx.path_to(ctx, "IN_DATA", "misc", "cps_us_state_codes.csv"),
#         ],
#         target=ctx.path_to(ctx, "OUT_DATA", "cps_yearly", out_name + ".csv"),
#         name="format_data_cps_yearly",
#         append=dataset,
#     )
