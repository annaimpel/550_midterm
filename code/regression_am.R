library(here)
source(here("raw_data", "get_data.R"))
data <- read_csv(here("raw_data", "wastewater.csv"))


# Load necessary libraries
library(tidyverse)
library(lubridate)
library(janitor)
library(readr)
library(zoo)
library(here)


# View dataset structure
glimpse(data)

wastewater <- data

# Convert 'date_start' and 'date_end' to Date format
wastewater <- wastewater %>%
  mutate(
    date_start = as.Date(date_start),
    date_end = as.Date(date_end)
  )

# Filter for most recent full year (adjust if needed)
latest_year <- max(year(wastewater$date_start), na.rm = TRUE)
wastewater_recent <- wastewater %>%
  filter(year(date_start) == latest_year)

# Remove rows with missing key values
wastewater_clean <- wastewater_recent %>%
  filter(!is.na(ptc_15d),
         !is.na(detect_prop_15d),
         !is.na(population_served))

# ======== Summary Statistics ========
summary_stats <- wastewater_clean %>%
  summarise(
    avg_ptc_15d = mean(as.numeric(ptc_15d), na.rm = TRUE),
    median_ptc_15d = median(as.numeric(ptc_15d), na.rm = TRUE),
    sd_ptc_15d = sd(as.numeric(ptc_15d), na.rm = TRUE),
    avg_detect_prop = mean(as.numeric(detect_prop_15d), na.rm = TRUE),
    mean_population = mean(as.numeric(population_served), na.rm = TRUE)
  )

print(summary_stats)

# ======== Time Series: National Trend ========
time_series <- wastewater_clean %>%
  group_by(date_start) %>%
  summarise(mean_ptc_15d = mean(as.numeric(ptc_15d), na.rm = TRUE)) %>%
  mutate(rolling_avg = rollmean(mean_ptc_15d, k = 7, fill = NA))

time_plot<- ggplot(time_series, aes(x = date_start)) +
  geom_line(aes(y = mean_ptc_15d), color = "steelblue", alpha = 0.5) +
  geom_line(aes(y = rolling_avg), color = "red", size = 1) +
  labs(
    title = "National Average Percent Change in SARS-CoV-2 RNA Levels in Wastewater",
    x = "Sample Start Date",
    y = "Percent Change in SARS-CoV-2 RNA (15d)"
  ) +
  theme_minimal()



# ======== Boxplot: Percent Change by Reporting Jurisdiction ========
box_plot<- ggplot(wastewater_clean, aes(x = reporting_jurisdiction, y = as.numeric(ptc_15d))) +
  geom_boxplot(fill = "lightblue", outlier.color = "red", outlier.size = 1.5) +
  scale_y_continuous(trans = "log10") +
  labs(
    title = "Percent Change in SARS-CoV-2 RNA Levels by Reporting Jurisdiction",
    x = "Reporting Jurisdiction",
    y = "Percent Change (log scale)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


saveRDS(time_plot, file = here("output", "timeplot.rds"))
saveRDS(box_plot, file = here("output", "boxplot.rds"))
