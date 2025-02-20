# Loading the data 
# We will load the needed data files from the internet. 
# It is all information that is not to do with the people that work on the 
# movies/series, but rather the characteristics of the movies/series themselves

{r warning=FALSE, message=FALSE}

# Define required packages
required_packages <- c("glue", "readr", "dplyr", "ggplot2", "knitr")

# Install missing packages
new_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(new_packages)) install.packages(new_packages, type = "binary")

# Suppress startup messages while loading packages
suppressPackageStartupMessages({
  library(glue)
  library(readr)
  library(dplyr)
  library(ggplot2)
  library(knitr)
  library(tidyr)})

# Downloading IMDb datasets
options(timeout = 600)
download.file("https://datasets.imdbws.com/title.akas.tsv.gz", "title.akas.tsv.gz")
download.file("https://datasets.imdbws.com/title.basics.tsv.gz", "title.basics.tsv.gz")
download.file("https://datasets.imdbws.com/title.episode.tsv.gz", "title.episode.tsv.gz")
download.file("https://datasets.imdbws.com/title.ratings.tsv.gz", "title.ratings.tsv.gz")

# Read and process the data using readr functions and dplyr
akas_data <- read_tsv("title.akas.tsv.gz", col_names = TRUE, na = "\\N")

basics_data <- read_tsv("title.basics.tsv.gz", col_names = TRUE, na = "\\N")

episode_data <- read_tsv("title.episode.tsv.gz", col_names = TRUE, na = "\\N")

ratings_data <- read_tsv("title.ratings.tsv.gz", col_names = TRUE, na = "\\N") 



