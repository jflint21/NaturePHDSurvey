## code to prepare `PhD_Survey` dataset goes here
library(tidyverse)
library(readxl)
NaturePHDSurvey <- read_excel("Nature_PhD survey_Anon_v1.xlsx")[-1, ] %>%
  janitor::clean_names() %>%
  rename(
    date = id_date,
    dual_degree = q1,
    reason = q3,
    employed = q13,
    enjoy = q17,
    satisfaction = q19_a,
    hours = q24,
    mental_health_help = q28,
    bullied = q31,
    discriminated = q34,
    next_position = q40,
    hindsight = q55,
    age = q56,
    gender = q57
  ) %>%
  select(
    age,
    bullied,
    date,
    dual_degree,
    discriminated,
    employed,
    enjoy,
    gender,
    hindsight,
    hours,
    mental_health_help,
    next_position,
    reason,
    satisfaction
  ) %>%
  mutate(
    age = as.factor(age),
    bullied = as.factor(bullied),
    date = as.Date(date, format = "%m/%d/%Y", optional = TRUE),
    dual_degree = if_else(
      dual_degree == "Dual doctorate degree (MD-PhD, PhD-PhD or other combination)",
      TRUE,
      FALSE),
    employed = if_else(employed == "Yes", TRUE, FALSE),
    enjoy = as.factor(enjoy),
    gender = as.factor(gender),
    hours = fct_relevel(as.factor(hours), "Less than 11 hours"),
    mental_health_help = as.factor(mental_health_help),
    next_position = as.factor(next_position),
    reason = as.factor(reason),
    satisfaction = as.numeric(str_sub(satisfaction, 1, 1))
  )
usethis::use_data(NaturePHDSurvey, overwrite = TRUE)
