## COURSERA JONHS HOPKINS - Module 03 - READING DATA
## 2020/04/06 - Stephane's assignment for Week 04
## Quiz

## Setting Working Directory
setwd("/cloud/project/M03 - W03")

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


