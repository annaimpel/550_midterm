# Load libraries
library(dplyr)
library(ggplot2)
library(maps)
library(here)

source(here("raw_data", "get_data.R"))
data <- read_csv(here("data", "wastewater.csv"))

wastewater <- data

# Convert date_end to Date format if needed
wastewater <- wastewater %>%
  mutate(date_end = as.Date(date_end))

# Get the most recent date
most_recent_date <- max(wastewater$date_end, na.rm = TRUE)

# Filter data for the most recent date
wastewater_latest <- wastewater %>%
  filter(date_end == most_recent_date)

# Check output
print(most_recent_date)
head(wastewater_latest)

# Calculate state-level averages for detect_prop_15d
state_averages <- wastewater_latest %>%
  group_by(wwtp_jurisdiction) %>%
  summarise(avg_detect_prop_15d = mean(detect_prop_15d, na.rm = TRUE))

# View results
head(state_averages)

# Get US state map data
us_states <- map_data("state")
us_states$region <- tolower(us_states$region)

# Ensure state names match (convert to lowercase)
state_averages <- wastewater_latest %>%
  group_by(wwtp_jurisdiction) %>%
  summarise(avg_detect_prop_15d = mean(detect_prop_15d, na.rm = TRUE)) %>%
  mutate(wwtp_jurisdiction = tolower(wwtp_jurisdiction))

# Merge map data with wastewater data
merged_data <- us_states %>%
  left_join(state_averages, by = c("region" = "wwtp_jurisdiction"))

# Check merged data
head(merged_data)

# Create the map
map_plot <- ggplot(merged_data, aes(x = long, y = lat, group = group, fill = avg_detect_prop_15d)) +
  geom_polygon(color = "black", size = 0.2) +
  scale_fill_viridis_c(option = "plasma", na.value = "gray80", name = "Avg. Detection (%)") +
  coord_fixed(1.3) +
  theme_void() +
  labs(
    title = "Average SARS-CoV-2 Detection in US Wastewater by State",
    subtitle = paste("Data from", most_recent_date),
    caption = "Source: NWSS Wastewater Data"
  ) +
  theme(
    legend.position = "right",
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank()
  )

# Save the map as an RDS file
saveRDS(map_plot, "/Users/emilioestrada/550_midterm/output/analysis_out_EE.rds")
