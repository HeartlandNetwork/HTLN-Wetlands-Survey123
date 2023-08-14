
library(tidyverse)

#setwd("./src")

# load the Survey123 data

load_file <- read_csv("CUVA_VIBI_herb.csv")

glimpse(load_file)

# select columns from Survey 123 and create FeatureID column

Access_data <- load_file |> 
  select(Species, Module, CoverClass, CoverClassAll, EditDate, HerbSiteName) |>
  mutate( FeatureID = HerbSiteName)

glimpse(Access_data)

# create the EventID column

Access_data <- Access_data |>
  mutate( EventID = str_c( 'CUVAWetlnd', str_sub(load_file$EditDate, 6, 9), '0', 
      str_sub(load_file$EditDate, 1, 1), str_sub(load_file$EditDate, 3, 4))) 

glimpse(Access_data)

# create the LocationID column from the FeatureID column
# and a lookup table from HTLNWetlands

Locations_LUT <- read_csv("Locations_LUT.csv")

glimpse(Locations_LUT)

Access_data <- Access_data |>
  left_join(Locations_LUT, join_by(FeatureID))

glimpse(Access_data)

# create an output file with a timestamp
# and include it in the dataframe for reference


Access_data <- Access_data |>
  mutate(
    My_timestamp = now(),
    My_timestamp = as.character(My_timestamp),
    My_timestamp = str_replace_all(My_timestamp, " ", "_"),
    My_timestamp = str_replace_all(My_timestamp, ":", ""),
    Outfile = str_c("VIBI_herb_", My_timestamp,".txt")
  ) 

glimpse(Access_data)

# clean up columns

Access_data <- Access_data |>
  select(EventID, FeatureID, LocationID, Species, Module,
         CoverClass, CoverClassAll, EditDate, Outfile )

glimpse(Access_data)


write_csv(Access_data, Access_data$Outfile[1])
  




