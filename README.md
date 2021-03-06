
<!-- README.md is generated from README.Rmd. Please edit that file -->

# NaturePHDSurvey

<!-- badges: start -->

![R-CMD-check](https://github.com/jflint21/NaturePHDSurvey/workflows/R-CMD-check/badge.svg)
<!-- badges: end -->

The goal of NaturePHDSurvey is to provide a relatively curated interface
with the set of responses to the 2019 Nature survey of current PhD
candidates.

## Installation

You can install the released version of NaturePHDSurvey from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("NaturePHDSurvey")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jflint21/NaturePHDSurvey")
```

## Example 1: Do older PhD students experience more bullying?

``` r
library(NaturePHDSurvey)
library(tidyverse)

PhD_Survey_ds_1 <- NaturePHDSurvey %>%
  group_by(age, discriminated) %>%
  summarize(n = n()) %>%
  pivot_wider(names_from = discriminated, values_from = n) %>%
  mutate(prop_discriminated = Yes / (Yes + No)) %>%
  select(age, prop_discriminated)

knitr::kable(PhD_Survey_ds_1, 
             digits = 2, 
             align = "c",
             col.names = c("Age Group", "Proportion experiencing bullying"))
```

|     Age Group     | Proportion experiencing bullying |
|:-----------------:|:--------------------------------:|
|      18 - 24      |               0.14               |
|      25 - 34      |               0.22               |
|      35 - 44      |               0.27               |
|      45 - 54      |               0.32               |
|      55 - 64      |               0.18               |
|    65 or over     |               0.14               |
| Prefer not to say |               0.22               |

The youngest students experience the lowest rate of bullying, at about
13.5%.

PhD students aged 35 to 55 experience significantly more bullying than
their younger (or older) peers, by about 2-2.5 times.

By age 65 or older, bullying rates return to those seen for young
students (18-24 years of age).

## Example 2: Is there an association between hours worked and satisfaction?

``` r
PhD_Survey_ds_2 <- NaturePHDSurvey %>%
  group_by(hours) %>%
  summarize(satisfaction = mean(satisfaction))
#> `summarise()` ungrouping output (override with `.groups` argument)

knitr::kable(PhD_Survey_ds_2, 
             digits = 1,
             align = "c",
             col.names = c("Typical weekly hours", "Satisfaction"))
```

| Typical weekly hours | Satisfaction |
|:--------------------:|:------------:|
|  Less than 11 hours  |     4.4      |
|     11-20 hours      |     4.8      |
|     21-30 hours      |     5.1      |
|     31-40 hours      |     5.0      |
|     41-50 hours      |     5.0      |
|     51-60 hours      |     4.9      |
|     61-70 hours      |     4.8      |
|     71-80 hours      |     4.7      |
|  More than 80 hours  |     5.0      |

Self-reported satisfaction is highest among those PhD students working
21-30 hours per week.

The lowest satisfaction rates are reported by those students working
less than 11 hours per week.

Breaking the general downward trend in satisfaction as work hours
increase beyond 21-30 hours per week, there is a spike in satisfaction
among those students working more than 80 hours per week.
