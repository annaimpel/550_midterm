library(here)
library(readr)

# Define the download URL and destination path
url <- "https://data.cdc.gov/api/views/2ew6-ywp6/rows.csv?accessType=DOWNLOAD"
destfile <- here("data", "wastewater.csv")

# Only download if the file doesn't already exist
if (!file.exists(destfile)) {
  download.file(url, destfile, mode = "wb")
}
