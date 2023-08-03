
library(tidyverse)

VIBI_herb <- read_csv("CUVA_VIBI_herb.csv")

glimpse(VIBI_herb)


Access_data_1 <- VIBI_herb |> 
  select(Species, Module, CoverClass, CoverClassAll, EditDate, HerbSiteName) |>
  mutate( FeatureID = HerbSiteName)


Access_data_2 <- Access_data_1 |>
  mutate( EventID = str_c( 'CUVAWetlnd', str_sub(VIBI_herb$EditDate, 6, 9), '0', 
      str_sub(VIBI_herb$EditDate, 1, 1), str_sub(VIBI_herb$EditDate, 3, 4))) 

glimpse(Access_data_2)




