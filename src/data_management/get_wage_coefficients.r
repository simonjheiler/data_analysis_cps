require(plyr)

# read in arguments (1: path input file, 2: path output file)
# args <- commandArgs(trailingOnly=TRUE)
args <- c(
  "C:\\Users\\Simon\\Documents\\local_uni\\data\\cps\\supplement_asec\\results\\cps_supplement_asec_extract.csv",
  "C:\\Users\\Simon\\Documents\\sync_uni\\projects\\data_analysis_cps\\bld\\results\\cps_wage_coefficients.csv",
  "C:\\Users\\Simon\\Documents\\sync_uni\\projects\\data_analysis_cps\\bld\\results\\cps_log_wage_coefficients.csv"
)


#####################################################
# PARAMETERS
#####################################################

analysis_df <- read.csv(file = args[1])

#####################################################
# FUNCTIONS
#####################################################

regression_wages <- function(x) {

  ## make sure no missing values and no empty levels
  x <- x[!(is.na(x$earnings_weekly) | is.na(x$age) | is.na(x$marital_status) | is.na(x$education) | is.na(x$race) | is.na(x$weight_earnings)),]
  x <- droplevels(x)

  ## run regression on factors with >= 2 levels
  if(length(levels(x$race)) < 2) {model <- lm(earnings_weekly ~ poly(age, degree = 2, raw = TRUE) + marital_status + education, data=x, weights = weight_earnings)}
  if(length(levels(x$race)) >= 2) {model <- lm(earnings_weekly ~ poly(age, degree = 2, raw = TRUE) + marital_status + education + race, data=x, weights = weight_earnings)}

  ## get regression coefficients
  coef_tmp <- coef(model)

  ## make sure the return value always has the same length
  out <- data.frame(intercept=0, age=0, age_squared=0, d_white=0, d_black=0, d_married=0, d_edu_hs_deg=0, d_edu_no_col=0, d_edu_col_deg=0)
  try(out["intercept"] <- coef_tmp["(Intercept)"])
  try(out["age"] <- coef_tmp["poly(age, degree = 2, raw = TRUE)1"])
  try(out["age_squared"] <- coef_tmp["poly(age, degree = 2, raw = TRUE)2"])
  try(out["d_white"] <- coef_tmp["racewhite"])
  try(out["d_black"] <- coef_tmp["raceblack"])
  try(out["d_married"] <- coef_tmp["marital_statusmarried"])
  try(out["d_edu_2"] <- coef_tmp["educationedu_2"])
  try(out["d_edu_3"] <- coef_tmp["educationedu_3"])
  try(out["d_edu_4"] <- coef_tmp["educationedu_4"])

  out[is.na(out)] <- 0

  return(out)
}


regression_log_wages <- function(x) {

  ## make sure no missing values and no empty levels
  x <- x[!(is.na(x$earnings_weekly) | is.na(x$age) | is.na(x$marital_status) | is.na(x$education) | is.na(x$race) | is.na(x$weight_earnings)),]
  x <- droplevels(x)

  ## run regression on factors with >= 2 levels
  if(length(levels(x$race)) < 2) {model <- lm(log(earnings_weekly) ~ poly(age, degree = 2, raw = TRUE) + marital_status + education, data=x, weights = weight_earnings)}
  if(length(levels(x$race)) >= 2) {model <- lm(log(earnings_weekly) ~ poly(age, degree = 2, raw = TRUE) + marital_status + education + race, data=x, weights = weight_earnings)}

  ## get regression coefficients
  coef_tmp <- coef(model)

  ## make sure the return value always has the same length
  out <- data.frame(intercept=0, age=0, age_squared=0, d_white=0, d_black=0, d_married=0, d_edu_hs_deg=0, d_edu_no_col=0, d_edu_col_deg=0)
  try(out["intercept"] <- coef_tmp["(Intercept)"])
  try(out["age"] <- coef_tmp["poly(age, degree = 2, raw = TRUE)1"])
  try(out["age_squared"] <- coef_tmp["poly(age, degree = 2, raw = TRUE)2"])
  try(out["d_white"] <- coef_tmp["racewhite"])
  try(out["d_black"] <- coef_tmp["raceblack"])
  try(out["d_married"] <- coef_tmp["marital_statusmarried"])
  try(out["d_edu_2"] <- coef_tmp["educationedu_2"])
  try(out["d_edu_3"] <- coef_tmp["educationedu_3"])
  try(out["d_edu_4"] <- coef_tmp["educationedu_4"])

  out[is.na(out)] <- 0

  return(out)
}


#####################################################
# SCRIPT
#####################################################

## drop non-employed individuals
analysis_df <- analysis_df[analysis_df$labor_force_status == "employed",]

## sort data
index <- with(analysis_df, order(marital_status, race, education))
analysis_df <- analysis_df[index, ]

## convert rank to a factor (categorical variable)
analysis_df$race <- factor(analysis_df$race)
analysis_df$marital_status <- factor(analysis_df$marital_status)
analysis_df$education <- factor(analysis_df$education)

## make sure the reference levels are always the same
analysis_df <- within(analysis_df, marital_status <- relevel(marital_status, ref = "not married"))
analysis_df <- within(analysis_df, race <- relevel(race, ref = "other"))
analysis_df$education <- revalue(analysis_df$education, c("Less than a High School Diploma"="edu_1",
                                                          "High School Graduates, No College"="edu_2",
                                                          "Some College or Associate Degree"="edu_3",
                                                          "Bachelor's degree and higher"="edu_4")
)
analysis_df <- within(analysis_df, education <- relevel(education, ref = "edu_1"))

## get coefficients for regression of wages
coefficients <- ddply(analysis_df, .(year, state), regression_wages)

## store results
write.csv(coefficients, args[2], row.names = FALSE)

## get coefficients for regression of log wages
coefficients <- ddply(analysis_df, .(year, state), regression_log_wages)

## store results
write.csv(coefficients, args[3], row.names = FALSE)
