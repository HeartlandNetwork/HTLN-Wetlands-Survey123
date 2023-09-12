
library(dplyr)
library(readr)



setwd("../HTLN-Wetlands-Survey123/src")

# load the Survey123 data

load_file <- read_csv("Woody.csv")

glimpse(load_file)


# select columns from Survey 123 and create FeatureID column
# 

Access_data <- load_file |>
	select(WoodyModule, WoodySpecies, EditDate, WoodySiteName, ShrubClump, D0to1,
	       D1to2_5, D2_5to5, D5to10, D10to15, D15to20, D20to25, D25to30, D30to35,
	       D35to40, Dgt40, Dgt40_1, Dgt40_2, Dgt40_3, Dgt40_4, Dgt40_5)

Access_data <- Access_data |>
  mutate( FeatureID = WoodySiteName) |>
  mutate(EditDate = (EditDate <- as.Date(EditDate, format = "%m/%d/%Y")))

glimpse(Access_data)

# Substitute NA with -9999 in all dbl variable

Access_data$ShrubClump <- Access_data$ShrubClump |> replace_na(-9999)
Access_data$D0to1 <- Access_data$CoverD0to1 |> replace_na(-9999)
Access_data$D1to2_5 <- Access_data$D1to2_5 |> replace_na(-9999)
Access_data$D2_5to5 <- Access_data$D2_5to5 |> replace_na(-9999)
Access_data$D5to10 <- Access_data$D5to10 |> replace_na(-9999)
Access_data$D10to15 <- Access_data$15to20 |> replace_na(-9999)
Access_data$D15to20 <- Access_data$CoverClass |> replace_na(-9999)
Access_data$CoverClass <- Access_data$CoverClass |> replace_na(-9999)
Access_data$CoverClass <- Access_data$CoverClass |> replace_na(-9999)
Access_data$CoverClass <- Access_data$CoverClass |> replace_na(-9999)
Access_data$CoverClass <- Access_data$CoverClass |> replace_na(-9999)
Access_data$CoverClass <- Access_data$CoverClass |> replace_na(-9999)


# Generate EventID from EditDate

Access_data <- Access_data |>
	  mutate( EventID = str_c( 'CUVAWetlnd', EditDate)) |>
	    mutate(EventID = str_replace_all(EventID, "-", ""))



# Generate EventID from EditDate

Access_data <- Access_data |>
  mutate( EventID = str_c( 'CUVAWetlnd', EditDate)) |>
  mutate(EventID = str_replace_all(EventID, "-", ""))

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
    Timestamp = str_c("VIBI_herb_", My_timestamp)
  ) 

glimpse(Access_data)

# clean up columns

Access_data <- Access_data |>
  select(EventID, FeatureID, LocationID, Species, Module,
         CoverClass, CoverClassAll, EditDate, Timestamp )

glimpse(Access_data)


#write_csv(Access_data, Access_data$Outfile[1])

writexl::write_xlsx(Access_data, "Load_VIBI_herb.xlsx")
  



