library(here)
library(readr)

url <- "https://data.cdc.gov/api/views/2ew6-ywp6/rows.csv?accessType=DOWNLOAD"
destfile <- here("raw_data", "wastewater.csv")

if (!file.exists(destfile)) {
  download.file(url, destfile, mode = "wb")
}
