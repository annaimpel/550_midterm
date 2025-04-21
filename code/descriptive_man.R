

# Load libraries
library(readr)
library(dplyr)
library(labelled)
library(gtsummary)
library(readxl)
library(tidyverse)
library(gt)
library(here)

source(here("raw_data", "get_data.R"))
data <- read_csv(here("data", "wastewater.csv"))


# dataset
NWSS <- data
# ptc_15d, population_served. sampling prior, wwtp_jurisdiction, date_start, date_end, detect_prop_15d

# Labels
var_label(NWSS) <- list(
  wwtp_jurisdiction = "WWTP Jurisdiction",
  sample_location = "Sample Location",
  date_start = "Data Start",
  date_end = "Date End",
  ptc_15d = "Percent Change (15d)",
  detect_prop_15d = "Detection Proportion (15d)",
  sampling_prior = "Sampling Prior",
  first_sample_date = "First Sample Date"
)


NWSS <- NWSS %>%
  mutate(first_sample_date = as.Date(first_sample_date, format = "%m/%d/%Y"),
         first_sample_year = format(first_sample_date, "%Y"))


# Categorical variables
descriptive <- NWSS %>%
  select(wwtp_jurisdiction, sample_location, first_sample_year, ptc_15d, detect_prop_15d) %>%
  tbl_strata(
    strata = sample_location,
    .tbl_fun = ~.x %>%
      tbl_summary(by = first_sample_year) %>%
      modify_spanning_header(all_stat_cols() ~ "Sample Collection Location and Year") %>%
      add_overall()
  )

descriptive %>%
  as_gt() %>%
  gt::tab_header(
    title = "Descriptive Statistics of NWSS Data",
    subtitle = "Grouped by Sample Location and Year "
  ) %>%
  gtsave("output/descriptive_out_man.html")

# Correct one

