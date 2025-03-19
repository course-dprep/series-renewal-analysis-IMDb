# All source code related to the analysis.

# Load necessary libraries
install.packages(haven)
install.packages(data.table)

library(haven)
library(data.table)

setDT(TV_series_data_clean)

# Convert the binary variable (isAdult) and encoded genre columns to factors if necessary
TV_series_data_clean[, isAdult := as.factor(isAdult)]  # Make sure isAdult is treated as a factor
TV_series_data_clean[, Genre1_encoded := as.factor(Genre1_encoded)]
TV_series_data_clean[, Genre2_encoded := as.factor(Genre2_encoded)]
TV_series_data_clean[, Genre3_encoded := as.factor(Genre3_encoded)]

# Change averageRating, Genre1_encoded, Genre2_encoded and Genre3_encoded to numeric
TV_series_data_clean$averageRating <- as.numeric(as.character(TV_series_data_clean$averageRating))
TV_series_data_clean$Genre1_encoded <- as.numeric(as.character(TV_series_data_clean$Genre1_encoded))
TV_series_data_clean$Genre2_encoded <- as.numeric(as.character(TV_series_data_clean$Genre2_encoded))
TV_series_data_clean$Genre3_encoded <- as.numeric(as.character(TV_series_data_clean$Genre3_encoded))

# Logistic regression model
log_reg <- glm(Renewed ~ isAdult + startYear + endYear + Genre1_encoded + + Genre2_encoded + Genre3_encoded + averageRating + numVotes,
             data = TV_series_data_clean, 
             family = binomial)

# Summary of the model
summary(log_reg)

# Linearity -> Box-Tidwell test
library(car)
boxTidwell(Renewed ~ isAdult + startYear + endYear + Genre1_encoded + + Genre2_encoded + Genre3_encoded + averageRating + numVotes,
           data = TV_series_data_clean)
## ?? Gets the following error: Error in boxTidwell.default(y, X1, X2, max.iter = max.iter, tol = tol,  : 
## the variables to be transformed must have only positive values
## In addition: Warning message:
## In model.response(mf, "numeric") :
## using type = "numeric" with a factor response will be ignored
##### I can't fix this!

# Independence
library(lmtest)
dwtest(log_reg)

# Multicollinearity  (vif)
library(car)
vif(log_reg)