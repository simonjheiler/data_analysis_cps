'
The file "esimate_returns.r" estimates returns to tenure by age and
education from CPS data.
'

# read in arguments (1: path input file, 2: path output file)
args <- commandArgs(trailingOnly=TRUE)
# args <- c(
#   "C:\\Users\\simon\\Documents\\sync_uni\\Projects\\data_analysis_cps\\bld\\out\\data\\supplement_tenure.csv",
#   "C:\\Users\\simon\\Documents\\sync_uni\\Projects\\data_analysis_cps\\bld\\out\\results\\cps_returns_to_tenure.csv"
# )

# load required packages
library(foreign)
library(plyr)
library(dplyr)
library(spatstat)
library(tidyr)
library(ggeffects)

#####################################################
# SCRIPT
#####################################################

## DATA PREPARATION
# load data
df <- read.csv(file = args[1])

# drop observations out of scope and with missing values
df <- drop_na(df, c(
  "earnings_weekly_deflated",
  "tenure",
  "education",
  "age_group",
  "marital_status",
  "citizenship_status",
  "race",
  "weight"
))
df <- df[df$earnings_weekly_deflated!=0,]
df <- subset(df, "sex"="MALE")

# data cleaning and processing
# truncate tenure at 45 years
df[df$tenure>45,"tenure"] <- 45

# add reduced education category
df$education_reduced <- revalue(df$education, c(
  "Less than 5th Grade"="low",
  "5th Grade to 12th Grade without Diploma"="low",
  "High School Graduates, No College"="medium",
  "Some College or Associate Degree"="medium",
  "Bachelor's degree and higher"="high"
))

# transform categorical variables to factors
df$year <- factor(df$year)
df$marital_status <- factor(df$marital_status)
df$race <- factor(df$race)
df$citizenship_status <- factor(df$citizenship_status)

# compute log earnigns
df$log_earnings <- log(df$earnings_weekly_deflated)

## ESTIMATION AND PREDICTION
# estimate linear model of returns to tenure
model_tenure <- lm(log_earnings ~ education_reduced * tenure
  + education_reduced * I(tenure^2)
  + age + I(age^2) + year + state + marital_status + citizenship_status + race,
                     weights = weight,
                     data=df
)

# predict log earnings by tenure and education
returns_predicted <- ggeffect(model_tenure, terms=c("tenure [0:40 by=5]", "education_reduced"))

# transform log earnings to earnings
returns_predicted$predicted <- exp(returns_predicted$predicted)
returns_predicted$conf.high <- exp(returns_predicted$conf.high)
returns_predicted$conf.low <- exp(returns_predicted$conf.low)

## OUTPUT
# store results
write.csv(returns_predicted, file = args[2], row.names = FALSE)
