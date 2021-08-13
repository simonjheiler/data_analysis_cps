'
The file "esimate_returns.r" estimates returns to tenure by age and education from CPS data.
'

# args <- commandArgs(trailingOnly=TRUE)

args <- c(
   'C:/Users/simon/Documents/sync_uni/Projects/data_analysis_cps/bld/out/data/supplement_tenure/cpst_2004-01.csv',
   'C:/Users/simon/Documents/sync_uni/Projects/data_analysis_cps/bld/out/results/cps_returns_to_tenure.csv'
)

library(foreign)
library(plyr)
library(dplyr)
library(spatstat)

#####################################################
# PARAMETERS
#####################################################

# load data
df <- data.frame()
for(infile in args[-length(args)]){
   df_tmp <- read.csv(file = infile)
   df <- rbind.fill(df, df_tmp)
}

#####################################################
# FUNCTIONS
#####################################################


#####################################################
# SCRIPT
#####################################################

### PREPARE DATA

## drop observations out of scope
df$AGE <- as.numeric(df$AGE)
