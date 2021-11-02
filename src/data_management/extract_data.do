capture log close

* read in variables from command prompt
local working_dir `c(pwd)'
local file_name `1'
local path_project `2'
local path_log_inner `3'
local path_log_outer `4'
local path_data `5'
local path_do `6'
local path_dict `7'
local path_out `8'
local variables `9'
local variables = subinstr("`variables'", "-", " ",.)

* construct derived variables
local in_file_path `"`path_project'`path_data'`file_name'.zip"'
local log_file_inner `"`path_project'`path_log_inner'`file_name'.log"'
local log_file_outer `"`path_project'`path_log_outer'extract_data_supplement_asec_`file_name'.log"'
local read_file `"`path_project'`path_do'"'
local data_dict `"`path_project'`path_dict'"'
local out_file `"`path_project'`path_out'`file_name'.csv"'
local path_out_full `"`path_project'`path_out'"'

/* RUN SCRIPT */
log using `log_file_outer', replace

* change working directory to out path
cd `path_out_full'

unzipfile `in_file_path', replace

capture confirm file `"`file_name'.dat"'
  if _rc==0 {
    local in_file_tmp `"`file_name'.dat"'
  }
  else {
    local in_file_tmp `"`file_name'.cps"'
  }

* extract data
do `read_file' `log_file_inner' `in_file_tmp' `out_file' `data_dict' "`variables'"

erase `in_file_tmp'

* change working directory back to starting location
cd `working_dir'
