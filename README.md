# Series Renewal Analysis on IMDb
The purpose of this study is to explore what the most important factors are in whether or not a series is renewed for a second season.

## Motivation
The renewal of a TV series for a second season is a multifaceted decision shaped by several factors. Traditionally, networks and streaming platforms have relied on audience viewership, critical perception, and financial considerations to determine whether a show continues. However, with the expansion of streaming services and globalization of content, additional factors may now influence these decisions.
The goal of this research is to explore which factors influence the likelihood of renewal of a series for a second season. While this is an exploratory analysis, there are two factors that are expected to have a big impact on the renewal chances: genre and average ratings.

The genre of a TV show is expected to have a big impact on renewal likelihood, as certain genres are more popular than others and attract loyal audiences. For instance, crime dramas and reality TV have historically shown strong audience retention, making them more likely to be renewed (What’s Behind a Show Renewal, n.d.-b). On the other hand, niche or experimental genres with smaller followings may struggle to secure additional seasons, regardless of critical acclaim. Recognizing which genres have a higher likelihood of renewal can help producers and platforms optimize their content strategies.

Moreover, average ratings are frequently considered a key factor in renewal decisions. High ratings generally indicate strong audience engagement, suggesting that a show is well-received and likely to perform well in future seasons (Analyzing TV Ratings Systems - Examining the Influence of Viewership Data on Show Renewals | Common Good Ventures, 2001). However, the correlation between ratings and renewal is complex, as other factors – such as production costs, competition, and strategic objectives of the platform – can also influence the final decision. 
Based on these factors, the question arises to which factors in general influence the likelihood of series renewal, and in particular to what extent genre popularity and average ratings influence this likelihood.
The findings of this study can contribute to both academic and industry discussions by shedding light on the key factors that influence TV series renewal decisions. By identifying patterns in these decisions, this research can assist content creators, streaming platforms, and production companies in making more strategic and data-driven choices regarding future productions. Understanding these trends can also help media executives allocate resources more effectively and develop content that aligns with audience preferences.

Furthermore, the automated and reproducible workflow used in this study ensures that the research process remains transparent and accessible. This not only enhances the reliability of the findings but also makes the study a valuable resource for other students, researchers, and the broader scientific community. Future studies can build upon this framework to explore additional factors influencing the renewal of TV series, contributing to a deeper understanding of decision-making in the entertainment industry.

## Data
The data for this study was obtained from IMDb via https://developer.imdb.com/non-commercial-datasets/. This website contains seven different datasets with information from IMDb. For this study, the following four datasets were used: 'title.akas', 'title.basics', 'title.episode' and 'title.ratings'.  The following table gives an overview of all variables in the final dataset used for this study. 



| Variable name     | Variable description      | Scale | 
|-----------------|-----------------|-----------------|
| tconst                | Alphanumeric identifier of an episode                                                         |  Nominal  | 
| parentTconst    | Alphanumeric identifier of a TV series                                                      |  Nominal  |
| primaryTitle    | The title used by the makers on promotional materials                           |    Nominal    | 
| originalTitle     | The original title in the original language                                               | Nominal       | 
| isAdult                   | Whether or not the series is an adult show (0: non-adult, 1: adult)   | Boolean       |
| startYear             | The release year of the title                                                                           | Ratio         |
| endYear                   | The final year a series was produced                                                             |   Ratio           |
| Genre1                    | The first genre of the series (some series have multiple genres)    | Nominal       |
| Genre2                    | If available, the second genre of the series                                          | Nominal   |                           
| Genre3                    | If applicable, the third genre of the series                                            | Nominal       |                    
| title                     | Title of the series                                                                 | Nominal |
| averageRating     | The weighted average of all individual user ratings                             | Interval  |
| region     | The region for this version of the title                              | Nominal  |
| language     | Language of the title                             | Nominal  |
| numVotes              | The number of votes a series has received                                                   | Ratio         |                           
| Renewed                   | Whether the series has at least a second season (0: not renewed, 1: renewed)  | Boolean   |                   
| Genre1_encoded    | Encoded version of the 1st genre  | Nominal |                           
| Genre2_encoded    | Encoded version of the 2nd genre  | Nominal |                           
| Genre3_encoded    | Encoded version of the 3rd genre  | Nominal | 
                         
The final dataset contains 180756 observations with 20 variables.

## Method
To explore what factors influence the likelihood of series renewal, we will conduct a logistic regression analysis. The renewal status will be the dependent variable, while isAdult, startYear, endYear, Genre1_encoded, Genre2_encoded, Genre3_encoded, averageRating and numVotes are the independent variables. These are either numerical or dummy encoded. According to Lee and Wang (2003), logistic regression is a useful method for analyzing binary variables, which is our dependent variable, because it models and predicts the probability of a specific outcome. This method is useful as it can handle both continuous and categorical predictors, making it versatile for various types of data.
For deployment, the results will be communicated through a PDF report, ensuring accessibility and clarity for potential users. The structured format will effectively present conclusions, making it easy to interpret key findings.

## Preview of Findings 
The logistic regression analysis reveals that six independent variables (IVs) significantly impact the likelihood of show renewal. These are startYear, endYear, Genre1_encoded, Genre2_encoded, Genre3_encoded, and numVotes.
The results of the logistic regression will be compiled into a PDF document, where the detailed analysis will be presented.

The model demonstrates that the likelihood of renewal is significantly affected by the start and end years, genre, and the number of votes. Older shows and specific genres tend to have a higher chance of cancellation, whereas newer shows and those with more votes have a better chance of renewal. On the other hand, classification as an adult series and the average rating do not significantly influence renewal decisions.

## Repository Overview 

```bash
├── reporting
|    └── report.Rmd
├── src
|    ├── analysis
|    |    └── analysis.R
|    └── data-preparation
|        ├── 1_Loading_data.R
|        ├── 2_ data_construction.R
|        ├── 3_data_cleaning.R
|        └── 4_data_EDA.R
├── .gitignore
├── README.md
└── makefile

```
    
## Dependencies 

Please also ensure [R](https://cran.r-project.org/bin/windows/base/) and [Make](https://gnuwin32.sourceforge.net/packages/make.htm) are installed on your local device. Follow [this](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/) tutorial that explains how to properly install R. To execute specific sections of our code, the following packages must be installed in R:

```bash
library(tidyverse)
library(knitr)
library(glue)
library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)
library(haven)
library(car)
library(lmtest)
library(data.table)
```

## Running Instructions 

This whole project can be run by using Make. Please follow the instructions below.

**Running The Code By Make**

1. Fork this repository
2. Open your command line/terminal and run the following code:

```bash
https://github.com/course-dprep/series-renewal-analysis-IMDb
```

3. Set your working directory to series-renewal-analysis-IMDb and run the following command:

```bash
make
```

When make has successfully run all the code, it will generate a table showing the output of the regression analysis.

To clean the data of all raw and unnecessary data files created during the pipeline, run the following code in the command line/terminal:

```bash
make clean
```


## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 1 members: [S. Broers](https://github.com/stanbroers1), [I. van der Heiden](https://github.com/ivdh1), [M. der Kinderen](https://github.com/mariekedk18), [E. Kuipers](https://github.com/Emmakuipers) & [L. Last](https://github.com/lukalast)