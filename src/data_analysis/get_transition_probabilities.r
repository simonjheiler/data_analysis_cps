#' Calculate unemployment rates and labor force flow rates for different splits of the population

#####################################################
# IMPORTS
#####################################################

## load required packages
require(ggeffects)
require(plyr)
require(dplyr)

## load project paths
source("project_paths.r")

#####################################################
# PARAMETERS
#####################################################

# define auxiliary variables
age_group_edu_split <- c("25 to 29", "30 to 34", "35 to 39", "40 to 44",
                         "45 to 49", "50 to 54", "55 to 59", "60 to 64")
years_exclude_transitions <- c("1994", "1995")


#####################################################
# FUNCTIONS
#####################################################


#####################################################
# SCRIPT
#####################################################

### PREPARE DATA

## read in data
df_cps <- read.csv(paste(PATH_OUT_DATA, "cps", "cps_data_monthly.csv", sep ="/"), na.strings=c("","NA"))

## format data
# drop observations with missing entries
df_cps <- df_cps[!is.na(df_cps$year),]
df_cps <- df_cps[!is.na(df_cps$month),]
df_cps <- df_cps[!is.na(df_cps$age_group),]
df_cps <- df_cps[!is.na(df_cps$education),]
df_cps <- df_cps[!is.na(df_cps$weight_long),]

# drop out of scope
df_cps <- df_cps[!df_cps$labor_force_status == "not in labor force",]
df_cps <- df_cps[df_cps$age >= 21,]
df_cps <- df_cps[df_cps$age <= 65,]
df_cps <- subset(df_cps, !(year %in% years_exclude_transitions))

# adjust age groups to match target groups
df_cps$age_group <- revalue(df_cps$age_group, c("20 to 24"="21 to 24"))
df_cps$age_group <- ordered(df_cps$age_group, levels = c(
  "21 to 24",
  "25 to 29",
  "30 to 34",
  "35 to 39",
  "40 to 44",
  "45 to 49",
  "50 to 54",
  "55 to 59",
  "60 to 64"
))

# reduce educational categories to 4
df_cps$education <- revalue(df_cps$education, c(
  "Less than 5th Grade"="edu_0",
  "5th Grade to 12th Grade without Diploma"="edu_1",
  "High School Graduates, No College"="edu_2",
  "Some College or Associate Degree"="edu_3",
  "Bachelor's degree and higher"="edu_4"
))
df_cps$education <- ordered(df_cps$education, levels = c("edu_0", "edu_1", "edu_2", "edu_3", "edu_4"))

# add education_reduced variable
df_cps$education_reduced <- df_cps$education
df_cps$education_reduced <- revalue(df_cps$education_reduced, c(
  "edu_0"="low",
  "edu_1"="low",
  "edu_2"="medium",
  "edu_3"="medium",
  "edu_4"="high"
))
df_cps$education_reduced <- ordered(df_cps$education_reduced, levels = c("low", "medium", "high"))

# transform categorials to factor variables
df_cps$year <- factor(df_cps$year)
df_cps$month <- factor(df_cps$month)
df_cps$marital_status <- factor(df_cps$marital_status)
df_cps$race <- factor(df_cps$race)

# construct dummy for dependent variables
df_cps$separation_1m <- revalue(df_cps$separation_1m, c(
  "False"=0,
  "True"=1
))
df_cps$separation_3m <- revalue(df_cps$separation_3m, c(
  "False"=0,
  "True"=1
))
df_cps$match_1m <- revalue(df_cps$match_1m, c(
  "False"=0,
  "True"=1
))
df_cps$match_3m <- revalue(df_cps$match_3m, c(
  "False"=0,
  "True"=1
))
df_cps$separation_1m <- as.numeric(df_cps$separation_1m)
df_cps$separation_3m <- as.numeric(df_cps$separation_3m)
df_cps$match_1m <- as.numeric(df_cps$match_1m)
df_cps$match_3m <- as.numeric(df_cps$match_3m)

# drop unused variables
df_cps <- subset(df_cps, select=-c(sex, age, spousal_status, working_spouse, education, labor_force_status, n_children, weight_long, weight_bls, earnings_imputed, log_earnings_imputed))

### ESTIMATE TRANSITION PROBABILITIES
# estimate probit models
model_p_eu_1m <- glm(separation_1m ~ age_group * education_reduced + year + month + state + race + marital_status,
                        family = binomial(link = "probit"),
                        data = df_cps[!is.na(df_cps$separation_1m),]
)
model_p_eu_3m <- glm(separation_3m ~ age_group * education_reduced + year + month + state + race + marital_status,
                           family = binomial(link = "probit"),
                           data = df_cps[!is.na(df_cps$separation_3m),]
)
model_p_ue_1m <- glm(match_1m ~ age_group * education_reduced + year + month + state + race + marital_status,
                      family = binomial(link = "probit"),
                      data = df_cps[!is.na(df_cps$match_1m),]
)
model_p_ue_3m <- glm(match_3m ~ age_group * education_reduced + year + month + state + race + marital_status,
                      family = binomial(link = "probit"),
                      data = df_cps[!is.na(df_cps$match_3m),]
)

# predict average marginal effects by age and education
p_eu_1m <- ggeffect(model_p_eu_1m, terms = c("age_group", "education_reduced"))
p_eu_3m <- ggeffect(model_p_eu_3m, terms = c("age_group", "education_reduced"))
p_ue_1m <- ggeffect(model_p_ue_1m, terms = c("age_group", "education_reduced"))
p_ue_3m <- ggeffect(model_p_ue_3m, terms = c("age_group", "education_reduced"))

# format data
p_eu_1m <- p_eu_1m %>%
  rename(
    age_group = x,
    education_reduced = group,
    estimate = predicted,
    conf_high = conf.high,
    conf_low = conf.low
    )
p_eu_1m <- p_eu_1m[, c("age_group", "education_reduced", "estimate", "conf_low", "conf_high")]

p_eu_3m <- p_eu_3m %>%
  rename(
    age_group = x,
    education_reduced = group,
    estimate = predicted,
    conf_high = conf.high,
    conf_low = conf.low
    )
p_eu_3m <- p_eu_3m[, c("age_group", "education_reduced", "estimate", "conf_low", "conf_high")]

p_ue_1m <- p_ue_1m %>%
  rename(
    age_group = x,
    education_reduced = group,
    estimate = predicted,
    conf_high = conf.high,
    conf_low = conf.low
    )
p_ue_1m <- p_ue_1m[, c("age_group", "education_reduced", "estimate", "conf_low", "conf_high")]

p_ue_3m <- p_ue_3m %>%
  rename(
    age_group = x,
    education_reduced = group,
    estimate = predicted,
    conf_high = conf.high,
    conf_low = conf.low
    )
p_ue_3m <- p_ue_3m[, c("age_group", "education_reduced", "estimate", "conf_low", "conf_high")]

p_1m <- merge(p_eu_1m, p_ue_1m, by.x=c("age_group", "education_reduced"), by.y=c("age_group", "education_reduced"))
p_1m <- subset(p_1m, select=c("age_group", "education_reduced", "estimate.x", "estimate.y"))
p_1m <- p_1m %>%
  rename(
    p_eu_1m_estimated = estimate.x,
    p_ue_1m_estimated = estimate.y
  )
p_1m$p_eu_3m_computed <- (
  (1-p_1m$p_eu_1m_estimated) * (1-p_1m$p_eu_1m_estimated) * p_1m$p_eu_1m_estimated +
  (1-p_1m$p_eu_1m_estimated) * p_1m$p_eu_1m_estimated * (1-p_1m$p_ue_1m_estimated) +
  p_1m$p_eu_1m_estimated * (1-p_1m$p_ue_1m_estimated) * (1-p_1m$p_ue_1m_estimated) +
  p_1m$p_eu_1m_estimated * p_1m$p_ue_1m_estimated * p_1m$p_eu_1m_estimated
)

p_1m$p_ue_3m_computed <- (
  p_1m$p_ue_1m_estimated * (1-p_1m$p_eu_1m_estimated) * (1-p_1m$p_eu_1m_estimated) +
  p_1m$p_ue_1m_estimated * p_1m$p_eu_1m_estimated * p_1m$p_ue_1m_estimated +
  (1-p_1m$p_ue_1m_estimated) * p_1m$p_ue_1m_estimated * (1-p_1m$p_eu_1m_estimated) +
  (1-p_1m$p_ue_1m_estimated) * (1-p_1m$p_ue_1m_estimated) * p_1m$p_ue_1m_estimated
)

p_3m <- merge(p_eu_3m, p_ue_3m, by.x=c("age_group", "education_reduced"), by.y=c("age_group", "education_reduced"))
p_3m <- subset(p_3m, select=c("age_group", "education_reduced", "estimate.x", "estimate.y"))
p_3m <- p_3m %>%
  rename(
    p_eu_3m_estimated = estimate.x,
    p_ue_3m_estimated = estimate.y
  )

transition_probabilities <- merge(p_1m, p_3m, by.x=c("age_group", "education_reduced"), by.y=c("age_group", "education_reduced"))

## store results

write.csv(transition_probabilities, paste(PATH_OUT_RESULTS, "empirics", "cps_transition_probabilities.csv", sep="/"), row.names = FALSE)

## clear workspace and collect garbage
rm(df_cps)
rm(p_1m)
rm(p_3m)
rm(p_eu_1m)
rm(p_eu_3m)
rm(p_ue_1m)
rm(p_ue_3m)
rm(transition_probabilities)
rm(model_p_eu_1m)
rm(model_p_eu_3m)
rm(model_p_ue_1m)
rm(model_p_ue_3m)
gc()