capture log close

* read in variables from command prompt
local working_dir `c(pwd)'
local file_name `1'
local file_tmp `2'
local path_project `3'
local path_log_inner `4'
local path_data `5'
local path_do `6'
local path_dict `7'
local path_in `8'
local path_out `9'
local variables `10'
local variables = subinstr("`variables'", "-", " ",.)

* construct derived variables
local in_file_path `"`path_data'`path_in'`file_name'.zip"'
local log_file `"`path_data'`path_log_inner'`file_name'.log"'
local read_file `"`path_project'`path_do'"'
local data_dict `"`path_project'`path_dict'"'
local out_file `"`path_data'`path_out'`file_name'_raw.csv"'
local path_out_full `"`path_data'`path_out'"'

/* RUN SCRIPT */
log using `log_file', replace

* change working directory to out path
cd `path_out_full'

unzipfile `in_file_path', replace

capture confirm file `"`file_tmp'.dat"'
  if _rc==0 {
    local in_file_tmp `"`file_tmp'.dat"'
  }
  else {
    local in_file_tmp `"`file_tmp'.cps"'
  }

* extract data
do `read_file' `in_file_tmp' `out_file' `data_dict' "`variables'"

erase `in_file_tmp'

* change working directory back to starting location
cd `working_dir'
