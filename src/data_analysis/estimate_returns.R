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
library(tidyr)

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
vars <- c("prtage", "peeduca", "pemlr", "prst1tn", "prernwa")
df <- drop_na(df, any_of(vars))
df <- df[df$prernwa > 0,]
## drop observations out of scope and with missing values


age_thresholds <- c(0, 19, 24, 29, 34, 39, 44, 49, 54, 59, 64, 200)
age_labels <- c("less than 20", "20 to 24", "25 to 29", "30 to 34", "35 to 39", "40 to 44", "45 to 49", "50 to 54", "55 to 59", "60 to 64", "65 and older")

tenure_thresholds <- c(0, 5, 10, 15, 20, 25, 30, 35, 40, 200)
tenure_labels <- c("less than 5 years", "5 to 10", "10 to 15", "15 to 20", "20 to 25", "25 to 30", "30 to 35", "35 to 40", "more than 40 years")


df$age <- df$prtage
df$age <- revalue(df$age, "-1"=NaN)
df$age <- as.numeric(df$prtage)

df$age_group <- cut(df$age, age_thresholds, labels = age_labels)

df$tenure_group <- cut(df$prst1tn, tenure_thresholds, labels = tenure_labels)

df$education_reduced <- df$peeduca
df$education_reduced <- revalue(df$education_reduced, c(
  "-1"=NaN,
   "LESS THAN 1ST GRADE"="low",
   "1ST, 2ND, 3RD OR 4TH GRADE"="low",
   "5TH OR 6TH GRADE"="low",
   "7TH OR 8TH GRADE"="low",
   "9TH GRADE"="low",
   "10TH GRADE"="low",
   "11TH GRADE"="low",
   "12TH GRADE NO DIPLOMA"="low",
   "HIGH SCHOOL GRAD-DIPLOMA OR"="medium",
   "PROFESSIONAL SCHOOL DEG"="medium",
   "ASSOCIATE DEGREE-OCCUPATIONAL/"="medium",
   "ASSOCIATE DEGREE-ACADEMIC"="medium",
   "SOME COLLEGE BUT NO DEGREE"="medium",
   "BACHELOR'S DEGREE"="high",
   "MASTER'S DEGREE (EX: MA, MS,"="high",
   "DOCTORATE DEGREE"="high"
))
df$education_reduced <- ordered(df$education_reduced, levels = c("low", "medium", "high"))

df$log_earnings <- log(df$prernwa)


model_tenure <- lm(log_earnings ~ education_reduced * tenure_group + age_group, data=df)