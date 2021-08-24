local working_dir `c(pwd)'
local in_file_path `4'
local in_file_name `1'
local path_out `7'
local out_file `8'
local log_file `2'
local path_read_file `5'
local path_data_dict `6'
local variables `"`9' `10' `11' `12' `13' `14' `15' `16' `17' `18' `19' `20' `21' `22' `23' `24' `25' `26' `27' `28'"'

cd `path_out'

unzipfile `in_file_path', replace

capture confirm file `"`in_file_name'.dat"'
  if _rc==0 {
    local in_file_tmp `"`in_file_name'.dat"'
  }
  else {
    local in_file_tmp `"`in_file_name'.cps"'
  }

do `path_read_file' `log_file' `in_file_tmp' `out_file' `path_data_dict' "`variables'"

capture erase `in_file_tmp'

cd `working_dir'
