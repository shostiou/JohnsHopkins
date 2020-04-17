## COURSERA JONHS HOPKINS - Module 04 - EXPLORATORY ANALYSIS
## 2020/04/17 - Stephane's Assignment for Week 01
##
## Electric Power Consumption dataset
## =======================================================
##
##
## This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets.
## This code performs basics steps of exploratory data analysis



## PART 1 - Collecting Data
## --------------------------------------------------------

## Setting Working Directory
setwd("/cloud/project/M04 - W01")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

## Downloading the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/powerconsumption.zip")
## unzipping file to the data directory
unzip("./data/powerconsumption.zip", exdir = "./data")


## PART 2 - Estimating Memory usage of the data set
## --------------------------------------------------------
## 
## The dataset is made of 9 columns - 1 of thoses uses "date", 1 uses "time" format
## while 7 of them are used to store real format values (float)
## Loading pryr library to estimate Memory usage
library(pryr)
## declaring test variables to estimate memory usage
date_test <- as.Date("17/04/2020",format = "%d/%m/%y")
time_test <- strftime(Sys.time(),"%H:%M:%S")
float_test <- 123.123
## Estimating memory usage
nrows_dataset = 2075259
MemUsage_dataset = (object_size(date_test) + object_size(time_test) + 7*object_size(float_test))*nrows_dataset
paste("Memory Usage Estimation :",MemUsage_dataset)
## Estimated Memory = 1.64 GB => Almost 3 Gb (x2 factor) will be required to load data properly
## Considering that I am currently executing R Studio under a virtual environment with limited RAM (1 GB),
## I'll have to consider working only on a subset of the dataset.
## only relevant data (rom the dates 2007-02-01 and 2007-02-02) will be uploaded for this project


## PART 3 - Loading Data
## --------------------------------------------------------
## 
## Lets' use the readr package to upload the subset of our dataset
library(readr)
## Note that the file uses ";" separators => the read_csv2 function will be used
power <- read_csv2("./data/household_power_consumption.txt",col_names=TRUE,skip = 21997, nrow = 66638-21997)




