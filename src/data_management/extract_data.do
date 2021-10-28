capture log close

local working_dir `c(pwd)'
local in_file_path `4'
local in_file_name `1'
local path_out `7'
local out_file `8'
local log_file_inner `2'
local log_file_outer `3'
local path_read_file `5'
local path_data_dict `6'
local variables `9'
local variables = subinstr("`variables'", "-", " ",.)

log using `log_file_outer', replace

cd `path_out'

unzipfile `in_file_path', replace

capture confirm file `"`in_file_name'.dat"'
  if _rc==0 {
    local in_file_tmp `"`in_file_name'.dat"'
  }
  else {
    local in_file_tmp `"`in_file_name'.cps"'
  }

*display "`variables'"
do `path_read_file' `log_file_inner' `in_file_tmp' `out_file' `path_data_dict' "`variables'"

erase `in_file_tmp'

cd `working_dir'
