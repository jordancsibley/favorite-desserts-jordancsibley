library(tidyverse)
library(rvest)  # used to scrape website content
library(here)

#read in favorite desserts
fav_desserts <- read_csv(here("favorite_desserts.csv"))

# Check if that data folder exists and creates it if not
dir.create("data", showWarnings = FALSE)

# Read the webpage code
webpage <- read_html("https://www.eatthis.com/iconic-desserts-united-states/")

# Extract the desserts listing
dessert_elements<- html_elements(webpage, "h2")
dessert_listing <- dessert_elements %>% 
  html_text2() %>%             # extracting the text associated with this type of element of the webpage
  as_tibble() %>%              # make it a data frame
  rename(dessert = value) %>%  # better name for the column
  head(.,-3) %>%               # 3 last ones were not desserts 
  rowid_to_column("rank") %>%  # adding a column using the row number as a proxy for the rank
  write_csv("data/iconic_desserts.csv") # save it as csv


# comparing my dessert to the list 

# tried doing some kind of for loop 
#for(i in seq_along(dessert_listing)) {
#  if(str_detect(dessert_listing$dessert[i], "lemon")) {
#    print(dessert_listing$rank[i])
#  }
#}  Couldn't get it to work 


# Suggested that you do a join 
inner_join(fav_desserts, dessert_listing, join_by(Favorite_desserts == dessert))
# in theory this would work if a) we had editted the csv correctly with the desserts not in our last_name column and b) if we had written our desserts as an exact match the the names in the iconic list
           

