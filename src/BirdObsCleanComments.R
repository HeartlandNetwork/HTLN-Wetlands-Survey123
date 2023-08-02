
library(tidyverse)

birdobs <- read_csv("src/BirdObservationsThru2022_3.csv")

glimpse(birdobs)


# look at unique comments

birdobs |>  
  select(Comments) |> 
  distinct(Comments) |>
  print(n = 909)


# try search for a special character "@"

birdobs |>  
  select(Comments) |> 
  filter(str_detect(Comments, "@"))

# replace @ with ' at '
birdobs <- birdobs |>  
  mutate(
    Comments = str_replace_all(Comments, "@", "at"))

# check for @ after mutate

birdobs |>  
  select(Comments) |> 
  filter(str_detect(Comments, "heard at creek crossing"))

# pass Comments2 to Comments1 in birdobs

# look for other special chars

birdobs |>  
  select(Comments) |> 
  distinct(Comments) |>
  print(n = 909)

# try search for a special character "~"

birdobs |>  
  select(Comments) |> 
  filter(str_detect(Comments, "~"))
















# one record got by... print to file 

out_df <- birdobs2 |>  
  select(Comments2) |> 
  filter(str_detect(Comments3, "@"))

write_csv(out_df, "./src/outfile.csv")

# it contains @ PERI 42 - try specific mutate

# create new comment column and replace @ with ' at '
birdobs3 <- birdobs2 |>  
  mutate(
    Comments3 = str_replace(Comments2, "@ PERI 42", " at PERI 42"))

birdobs3 |>  
  select(Comments3) |> 
  filter(str_detect(Comments3, "@"))


  