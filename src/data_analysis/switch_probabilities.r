#' Calculate unemployment rates and labor force flow rates for different splits of the population

#####################################################
# IMPORTS
#####################################################

## load required packages
require(ggeffects)
require(plyr)
require(dplyr)

# read in arguments (1: path input file, 2: path output file)
args <- commandArgs(trailingOnly=TRUE)
args <- c(
  "C:\\Users\\user\\data\\cps\\basic_monthly\\results\\cps_switch_rates_age_cohort.csv",
  "C:\\Users\\user\\sync_uni\\projects\\data_analysis_cps\\bld\\datasets\\cps_switch_probabilities_age_cohort1.csv",
  "C:\\Users\\user\\sync_uni\\projects\\data_analysis_cps\\bld\\datasets\\cps_switch_probabilities_age_cohort2.csv"
)

#####################################################
# PARAMETERS
#####################################################


#####################################################
# FUNCTIONS
#####################################################


#####################################################
# SCRIPT
#####################################################

### PREPARE DATA

## read in data
df <- read.csv(file = args[1])

## format data
# drop out of scope
df <- df[df$age_group != "19 and younger",]
df <- df[df$age_group != "65 and older",]

# ensure ordering of category variables
df$age_group <- ordered(df$age_group, levels = c(
  "20 to 24",
  "25 to 29",
  "30 to 34",
  "35 to 39",
  "40 to 44",
  "45 to 49",
  "50 to 54",
  "55 to 59",
  "60 to 64"
))
df$cohort_2 <- ordered(df$cohort_2, levels = c(
  "1930-1939",
  "1940-1949",
  "1950-1959",
  "1960-1969",
  "1970-1979",
  "1980-1989",
  "1990-1999"
))
df$cohort_1 <- ordered(df$cohort_1, levels = c(
  "1930-1934",
  "1935-1939",
  "1940-1944",
  "1945-1949",
  "1950-1954",
  "1955-1959",
  "1960-1964",
  "1965-1969",
  "1970-1974",
  "1975-1979",
  "1980-1984",
  "1985-1989",
  "1990-1994"
))


df$occ_switch_rate <- df$occ_switch / df$occ_all
df$occ_switch_rate_weighted <- df$occ_switch_weighted / df$occ_all_weighted

# transform categorials to factor variables
df$year <- factor(df$year)


### ESTIMATE TRANSITION PROBABILITIES
# estimate linear model
model_p_occ_switch_cohort1 <- lm(occ_switch_rate ~ age_group * cohort_1 + year,
                        data = df
)
model_p_occ_switch_cohort2 <- lm(occ_switch_rate ~ age_group * cohort_2 + year,
                        data = df
)

# predict average marginal effects by age and education
p_occ_switch_cohort1 <- ggpredict(model_p_occ_switch_cohort1, terms = c("age_group", "cohort_1"))
p_occ_switch_cohort2 <- ggpredict(model_p_occ_switch_cohort2, terms = c("age_group", "cohort_2"))

# format data
p_occ_switch_cohort1 <- p_occ_switch_cohort1 %>%
  rename(
    age_group = x,
    cohort = group,
    estimate = predicted,
    conf_high = conf.high,
    conf_low = conf.low
    )
p_occ_switch_cohort1 <- p_occ_switch_cohort1[, c("age_group", "cohort", "estimate", "conf_low", "conf_high")]

p_occ_switch_cohort2 <- p_occ_switch_cohort2 %>%
  rename(
    age_group = x,
    cohort = group,
    estimate = predicted,
    conf_high = conf.high,
    conf_low = conf.low
    )
p_occ_switch_cohort2 <- p_occ_switch_cohort2[, c("age_group", "cohort", "estimate", "conf_low", "conf_high")]

df_grouped_cohort1 <- df %>% group_by(age_group, cohort_1)  %>%
    summarise(employed = sum(occ_all),
              occ_switch = sum(occ_switch)
    )
df_grouped_cohort2 <- df %>% group_by(age_group, cohort_2)  %>%
    summarise(employed = sum(occ_all),
              occ_switch = sum(occ_switch)
    )

df_out_cohort1 <- merge(p_occ_switch_cohort1, df_grouped_cohort1, by.x=c("age_group", "cohort"), by.y=c("age_group", "cohort_1"))
df_out_cohort2 <- merge(p_occ_switch_cohort2, df_grouped_cohort2, by.x=c("age_group", "cohort"), by.y=c("age_group", "cohort_2"))

## store results

write.csv(df_out_cohort1, file = args[2], row.names = FALSE)
write.csv(df_out_cohort2, file = args[3], row.names = FALSE)

## clear workspace and collect garbage
rm(df)
rm(model_p_occ_switch)
rm(p_occ_switch)
gc()