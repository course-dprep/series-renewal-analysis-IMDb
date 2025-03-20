# Step 1: Loading the data 
print("make directories")
dir.create('../../gen')
dir.create('../../gen/data-preparation')
dir.create('../../gen/data-preparation/input')
# We will load the needed data files from the internet. 
# It is all information that is not to do with the people that work on the 
# movies/series, but rather the characteristics of the movies/series themselves
print("directories made")

#1.1 install required packages
print("downloading required packages")
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


#1.2 Download all datasets
print("downloading data")
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

akas_data = akas_data[1:100,]
episode_data = episode_data[1:100,]
basics_data = basics_data[1:100,]
ratings_data = ratings_data[1:100,]


print("dataframes succesfully created")




write.csv(akas_data, file = "../../gen/data-preparation/input/akas_data.csv", fileEncoding = "UTF-8",row.names=FALSE )
write.csv(basics_data, file = "../../gen/data-preparation/input/basics_data.csv", fileEncoding = "UTF-8",row.names=FALSE )
write.csv(episode_data, file = "../../gen/data-preparation/input/episode_data.csv", fileEncoding = "UTF-8",row.names=FALSE )
write.csv(ratings_data, file = "../../gen/data-preparation/input/ratings_data.csv", fileEncoding = "UTF-8",row.names=FALSE )
print("csvs succesfully save")


