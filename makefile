# Top-level target
first_rule: gen/data-preparation/output/TV_series_data_clean.csv report.pdf


# Ensure all required input files are created in a single execution of Loading_data.R
gen/data-preparation/input/akas_data.csv gen/data-preparation/input/basics_data.csv gen/data-preparation/input/episode_data.csv gen/data-preparation/input/ratings_data.csv: src/data-preparation/1_Loading_data.R
	Rscript src/data-preparation/1_Loading_data.R
	touch gen/data-preparation/input/akas_data.csv gen/data-preparation/input/basics_data.csv gen/data-preparation/input/episode_data.csv gen/data-preparation/input/ratings_data.csv

# Data Construction step
gen/output/TV_series_data_genre.csv: src/data-preparation/2_data_construction.R gen/data-preparation/input/akas_data.csv gen/data-preparation/input/basics_data.csv gen/data-preparation/input/episode_data.csv gen/data-preparation/input/ratings_data.csv
	Rscript src/data-preparation/2_data_construction.R	

# Data Cleaning step
gen/data-preparation/output/TV_series_data_clean.csv: src/data-preparation/3_data_cleaning.R gen/output/TV_series_data_genre.csv
	Rscript src/data-preparation/3_data_cleaning.R

report.pdf: reporting/report.Rmd 
	R -e 'rmarkdown::render(input = "reporting/report.Rmd ", output_file = "report.pdf")'

