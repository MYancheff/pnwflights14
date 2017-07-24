library(dplyr)
library(readr)
library(purrr)

if (!file.exists("data-raw/airports.dat")) {
  download.file(
    "https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat",
    "data-raw/airports.dat"
  )
}

raw <- read_csv("data-raw/airports.dat",
  col_names = c("id", "name", "city", "country", "faa", "icao", "lat", "lon", "alt", "tz", "dst", "tzone")
)


airports <- raw %>%
  tbl_df() %>%
  filter(country == "United States", faa != "") %>%
  select(faa, name, lat, lon, alt, tz, dst, tzone) %>%
  mutate(lat = as.numeric(lat), lon = as.numeric(lon)) %>%
  arrange(faa)

write.csv(airports, "data-raw/airports.csv", row.names = FALSE)
save(airports, file = "data/airports.rda")

# Save to RDS file
saveRDS(airports, "data/airports.RDS")
