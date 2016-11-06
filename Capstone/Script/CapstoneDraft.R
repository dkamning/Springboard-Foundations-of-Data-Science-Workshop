##Load libraries
library(dplyr)
library(data.table)

##0. Load data to data frame
titanic_dataset <- read.csv(file="./Data Wrangling/Exo2/titanic_original.csv"
                            , head = TRUE, sep=",")
str(titanic_dataset)