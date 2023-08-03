

# Loading csvs and EML into Power BI
# using the EVER_AA_Data dataset example

library(tidyverse)
library(EML)

# https://www.rdocumentation.org/packages/emld/versions/0.5.1

# Power BI needs to know where the files are...

setwd("C:/Users/growell/HTLN-BreedingBird-Dashboard/src/EVER_example")


AA_Plots <- read_csv("AA_Plots.csv")
AA_Vegetation <- read_csv("AA_VegetationDetail.csv")

my_eml <- read_eml("EVER_AA_metadata.xml")

#my_eml$dataset$title
#my_eml$dataset$creator$individualName$givenName
#my_eml$dataset$creator$individualName$surName
#my_eml$dataset$pubDate
#my_eml$dataset$abstract$para

#eml_EVER_example <- c(my_eml$dataset$title,
#                my_eml$dataset$creator$individualName$givenName,
#                my_eml$dataset$creator$individualName$surName,
#                my_eml$dataset$pubDate,
#                my_eml$dataset$abstract$para)

title <- c(my_eml$dataset$title)
firstname <- c(my_eml$dataset$creator$individualName$givenName)
lastname <- c(my_eml$dataset$creator$individualName$surName)
pubdate <- c(my_eml$dataset$pubDate)
abstract <- c(my_eml$dataset$abstract$para)

eml_df <- data.frame(title, firstname, lastname, pubdate, abstract)

eml_df






