
# Merge episode_data with title.basics, title.akas, and title.ratings
TV_series_data <- episode_data %>%
  left_join(basics_data, by = c("parentTconst" = "tconst")) %>%
  left_join(akas_data, by = c("parentTconst" = "titleId")) %>%
  left_join(ratings_data, by = c("parentTconst" = "tconst"))

# Check the result
glimpse(TV_series_data)


table(TV_series_data$titleType)

# see that there is also tvMiniSeries, we don't want to include them as TV Mini Series are usually meant to only last a season, and don't get renewed.


# Only keep TV_series_data
TV_series_data <- TV_series_data %>%
  filter(titleType == "tvSeries")

# check unique nr of parentTconst in episode_data and TV_series_data

print(length(unique(episode_data$parentTconst)))   # 215686
print(length(unique(TV_series_data$parentTconst))) # 179223


# only keep one row per parentTconst, and only keep the row with the highest seasonNumber of that parentTconst


# Select the row with the highest seasonNumber for each parentTconst
TV_series_data <- TV_series_data %>%
  group_by(parentTconst) %>%
  slice_max(seasonNumber, with_ties = FALSE) %>%
  ungroup()


head(TV_series_data)

print(nrow(TV_series_data)) # should be 179223





TV_series_data <- TV_series_data %>%
  # Create the Renewed variable based on the season number being above or equal to 2
  mutate(Renewed = ifelse(!is.na(seasonNumber) & seasonNumber >= 2, 1, 0)) %>%
  # Ungroup to return to a standard data frame
  ungroup()

# Check the result
head(TV_series_data)
table(TV_series_data$Renewed)


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