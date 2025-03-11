TV_series_data_final.csv: 4_data_EDA.R TV_series_data_clean.csv
	R --vanilla < 4_data_EDA.R

TV_series_data_clean.csv: 3_data_cleaning.R TV_series_data_genre.csv
	R --vanilla < 3_data_cleaning.R

TV_series_data_genre.csv: 2_data_construction.R akas_data.csv basics_data.csv episode_data.csv ratings_data.csv
	R --vanilla < 2_data_construction.R	

akas_data.csv basics_data.csv episode_data.csv ratings_data.csv: 1_Loading_data.R
	R --vanilla < 1_Loading_data.R