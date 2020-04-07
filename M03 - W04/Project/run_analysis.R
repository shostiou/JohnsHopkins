## COURSERA JONHS HOPKINS - Module 03 - READING DATA
## 2020/04/07 - Stephane's Project for Module 03
## Week 04

## PROJECT DESCRIPTION
## -------------------
## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set
## The goal is to prepare tidy data that can be used for later analysis.
## You will be required to submit: 
## 1) a tidy data set as described below
## 2) a link to a Github repository with your script for performing the analysis
## 3) a code book that describes the variables, the data, and any transformations
## or work that you performed to clean up the data called CodeBook.md
##
## You should also include a README.md in the repo with your scripts. 
##This repo explains how all of the scripts work and how they are connected.



## RAW DATA DESCRIPTION
## -------------------
## One of the most exciting areas in all of data science right now is wearable computing
## Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users
## The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone
## A full description is available at the site where the data was obtained:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Here are the data for the project:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



## PART 1 - Merging Training and Test Sets to create one Data Set
## --------------------------------------------------------------

## Setting Working Directory
setwd("/cloud/project/M03 - W04/Project")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

## Downloading the data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/dataset.zip")
## unzipping file to the data directory
unzip("./data/dataset.zip", exdir = "./data")

## Reading data Files
## Reading features file - 561 rows
features <- read.table("./data/UCI HAR Dataset/features.txt", sep =" ", header=FALSE)
features <- features$V2
## Reading Training set - 561 columns - 7352
train_set <- read.table("./data/UCI HAR Dataset/train/X_train.txt", sep ="", header=FALSE)
## Reading Test set - 561 columns - 2947 rows
test_set <- read.table("./data/UCI HAR Dataset/test/X_test.txt", sep ="", header=FALSE)
## Creating a new data frame merging test and train data
data_set <- merge(train_set, test_set, all=TRUE)
## updating column names of the dataset with the features names
colnames(data_set) <- features



## PART 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
## ------------------------------------------------------------------------------------------------
## Using grpe command combined with metacharacters
## Copying to the data_std_mean dataframe
data_std_mean <- data_set[,grep("mean()|std()", colnames(data_set))]







## Setting Working Directory
setwd("/cloud/project/M03 - W04/Project")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}








## QUESTION 1 - MANIPULATING TEXT
## ------------------------------------------
## The American Community Survey distributes downloadable data about United States communities. 
## Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
## and load the data into R. The code book, describing the variable names is here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
##
## Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
## What is the value of the 123 element of the resulting list?


## Downloading files from the Web
## ------------------------------------------
## CSV File
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/survey.csv", method = "curl")

## Code Book File
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(fileUrl, destfile="./data/survey_codebook.pdf", method = "curl")

## Recording download date
dateDownloaded <- Date()

## Reading downloaded data
surveyData <- read.table("./data/survey.csv", sep =",", header=TRUE)

## Applying strsplit on characters "wgtp"
surveyData_split <- strsplit(names(surveyData),"wgtp")
## value of the 123 th element
surveyData_split[123]



## QUESTION 2 - MANIPULATING TEXT
## ------------------------------------------
## Load the Gross Domestic Product data for the 190 ranked countries in this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
##
## Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 

## Downloading the Gross Domestic Product file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile="./data/GDP.csv", method = "curl")

## Reading downloaded data
GDPData <- read.csv("./data/GDP.csv", sep =",", header=TRUE)

## The GDP Data needs to be cleaned up
## Data only starts at the 6th row and columns don't all have a proper name
## Lets' affect a proper name
## Column 1 => CountryCode
## Column 2 => Ranking
## Column 3 => Short.Name
## Column 4 => GDP_2012
## Data stops at line 195 - comments are placed starting at line 237 + Global calculations.
GDPData <- read.csv("./data/GDP.csv", sep =",", header=FALSE, , nrow = 190, skip = 5, skipNul = TRUE)
## Suppressing useless columns
GDPData <- GDPData[,c(1:2,4:5)]
names(GDPData) <- c("CountryCode","Ranking","Short.Name","GDP_2012")

## Suppressing Thousands separators
## This is done thanks to the gsub function
GDPData$GDP_2012 <- unlist(lapply(GDPData$GDP_2012, function(x) as.numeric(gsub("\\,", "", as.character(x)))))
## Averaging the values of GDP
mean(GDPData$GDP_2012)


## QUESTION 3 - MANIPULATING TEXT
## ------------------------------------------
## In the data set from Question 2 what is a regular expression that would allow you to count the number of 
## countries whose name begins with "United"? Assume that the variable with the country names in it is 
## named countryNames. How many countries begin with United? 
countryNames <- GDPData$Short.Name
countryNames <- as.character(countryNames)

## Answering the question
grep("^United",countryNames)
## 3 countries beginning with United
## [1] "United States"        "United Kingdom"       "United Arab Emirates"


## QUESTION 4 - MANIPULATING TEXT
## ------------------------------------------
## Load the Gross Domestic Product data for the 190 ranked countries in this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
## Load the educational data from this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
## Match the data based on the country shortcode. 

## Of the countries for which the end of the fiscal year is available, how many end in June? 

## Downloading the Gross Domestic Product file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile="./data/GDP.csv", method = "curl")

## Downloading the educational data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile="./data/edu.csv", method = "curl")

## Reading downloaded data
GDPData <- read.csv("./data/GDP.csv", sep =",", header=TRUE)
EduData <- read.csv("./data/edu.csv", sep =",", header=TRUE)


## The Educational Data needs to be cleaned up
## Let's suppress rows which aren't countries (ie. "World") by removing rows 
## not having any "Currency Unit" specified (blank value not NA)
EduData <- EduData[(!(EduData$Currency.Unit=="")),]
write.csv(EduData,"./data/EduData.csv")

## The GDP Data needs to be cleaned up
## Data only starts at the 6th row and columns don't all have a proper name
## Lets' affect a proper name
## Column 1 => CountryCode
## Column 2 => Ranking
## Column 3 => Short.Name
## Column 4 => GDP_2012
## Data stops at line 195 - comments are placed starting at line 237 + Global calculations.
GDPData <- read.csv("./data/GDP.csv", sep =",", header=FALSE, , nrow = 190, skip = 5, skipNul = TRUE)
## Suppressing useless columns
GDPData <- GDPData[,c(1:2,4:5)]
names(GDPData) <- c("CountryCode","Ranking","Short.Name","GDP_2012")
## Suppressing Thousands separators
GDPData$GDP_2012 <- unlist(lapply(GDPData$GDP_2012, function(x) as.numeric(gsub("\\,", "", as.character(x)))))
## Writing CSV file
write.csv(GDPData,"./data/GDPData.csv")

## Lets' merge data now that it is cleaned
intersect(names(GDPData),names(EduData))
## Note that all countries don't have a rank
MergedData <- merge(GDPData,EduData, by.x="CountryCode", by.y="CountryCode",all=FALSE)
## Sorting by GDP Rank Descending
Merged_Ordered <- MergedData[order(MergedData$GDP_2012, decreasing = TRUE),]
## Writing CSV file
write.csv(Merged_Ordered,"./data/GMerged_Ordered.csv")

## The Fiscal year end is specified in the column "Special.Notes"
Fiscal_info <- Merged_Ordered$Special.Notes
## Looking for "Fiscal year end: June" 
Fiscal_info_June <- grep("Fiscal year end: June",Fiscal_info)
length(Fiscal_info_June)
## 13 countries.


## QUESTION 5 - Getting Stocks Prices
## ------------------------------------
## You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly
## traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock 
## price and get the times the data was sampled.

## How many values were collected in 2012? How many values were collected on Mondays in 2012?

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# Checking that sample Times are stored in Date Format
class(sampleTimes[1])

# Checking samples recorded in 2012
library(lubridate)
sampleTimesYear <- year(sampleTimes)
sample2012 <- sampleTimesYear[sampleTimesYear == 2012]
length(sample2012)
# 250 observations
# Now Looking for Mondays in 2012
sampleTimesM2012 <- sampleTimes[(weekdays(sampleTimes) == "Monday") & year(sampleTimes) == 2012 ]
length(sampleTimesM2012)
# 47 observations of Mondays in 2012



