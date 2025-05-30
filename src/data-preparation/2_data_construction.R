# Step 2: data construction


# Load the necessary libraries

library(tidyverse)
library(knitr)
library(glue)
library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)

library(conflicted)

conflict_prefer("filter", "dplyr")
conflict_prefer("lag", "dplyr")

#2.0 load the datasets
episode_data <- read_csv("gen/data-preparation/input/episode_data.csv", col_types = cols())
basics_data <- read_csv("gen/data-preparation/input/basics_data.csv", col_types = cols())
akas_data <- read_csv("gen/data-preparation/input/akas_data.csv", col_types = cols())
ratings_data <- read_csv("gen/data-preparation/input/ratings_data.csv", col_types = cols())


#2.1 merge the datasets

# Merge episode_data with title.basics, title.akas, and title.ratings
TV_series_data <- episode_data %>%
  left_join(basics_data, by = c("parentTconst" = "tconst")) %>%
  left_join(akas_data, by = c("parentTconst" = "titleId")) %>%
  left_join(ratings_data, by = c("parentTconst" = "tconst"))

#2.2 Filter out everything that is not a TV series

# EXPLANATION: 
# since our focus is tv-series, we are filtering the titletype on this (tvseries).
# we also see that there is also tvMiniSeries, we don't want to include them as TV Mini Series are usually meant to only last a season, and don't get renewed.

# Only keep TV_series_data
TV_series_data <- TV_series_data %>%
  filter(titleType == "tvSeries")

#2.3 create renewal variable

# In our datasets, certain rows have the same identifier (parenttconst),
# this makes sense as season 1 of a show and season 2 have the same identifier
# therefore we want to only keep the rows with the highest season number (this will be 
# useful in the next step, when we need to check whether a show was renewed or not. 

# Select the row with the highest seasonNumber for each parentTconst
TV_series_data <- TV_series_data %>%
  group_by(parentTconst) %>%
  slice_max(seasonNumber, with_ties = FALSE) %>%
  ungroup()

# We now create the variable renewed, we can do this based on whether a tv show has only 1 or multiple seasons

TV_series_data <- TV_series_data %>%
  # Create the Renewed variable based on the season number being above or equal to 2
  mutate(Renewed = ifelse(!is.na(seasonNumber) & seasonNumber >= 2, 1, 0)) %>%
  # Ungroup to return to a standard data frame
  ungroup()

# 2.4 create a multi-value column for genre so that we can analyse them later on

# Split the multi_values column into three separate columns
TV_series_data_genre <- TV_series_data %>%
  separate(genres, into = c("Genre1", "Genre2", "Genre3"), sep = ",", fill = "right")

# Get all unique categories across the selected columns
all_genres <- unique(unlist(TV_series_data_genre))

# Apply the same factor levels consistently across columns
TV_series_data_genre <- TV_series_data_genre %>%
  mutate(across(starts_with("Genre"), 
                ~ as.numeric(factor(., levels = all_genres)), 
                .names = "{.col}_encoded"))


# Get all unique categories across the selected columns
all_genres <- unique(unlist(TV_series_data_genre))

# Apply the same factor levels consistently across columns
TV_series_data_genre <- TV_series_data_genre %>%
  mutate(across(starts_with("Genre"), 
                ~ as.numeric(factor(., levels = all_genres)), 
                .names = "{.col}_encoded"))


# view the mapping of each variable

# Print out the mapping for each column
factor_mapping <- sapply(TV_series_data_genre[, c("Genre1", "Genre1_encoded")], function(x) {
  levels(factor(x))
})

print(factor_mapping)



#2.6 save the dataset

# Create directory for saving data
dir.create('gen/data-preparation/output')

# save to csv
write_csv(TV_series_data_genre, "gen/data-preparation/output/TV_series_data_genre.csv")
