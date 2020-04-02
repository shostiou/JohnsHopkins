## COURSERA JONHS HOPKINS - Module 03 - READING DATA
## 2020/04/02 - Stephane's assignment for Week 03

## Setting Working Directory
setwd("/cloud/project/M03 - W03")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

## QUESTION 1 - LOGICAL VECTOR
## ------------------------------------------
## The American Community Survey distributes downloadable data about United States communities. 
## Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
## and load the data into R. The code book, describing the variable names is here:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

## Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 
## worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() 
## function like this to identify the rows of the data frame where the logical vector is TRUE. 


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

## Building the Logical Vector
## Household greater than 10 acres => ACR (Lot Size) == 3
## Selling more than 10k$ of agricultural products => AGS == 6
agricultureLogical <- (surveyData$ACR == 3 & surveyData$AGS == 6)
## Extracting data from the dataset
My_result <- surveyData[which(agricultureLogical),]
head(My_result, n=3)


## QUESTION 2 - Manipulating Images
## ------------------------------------------
## Using the jpeg package read in the following picture of your instructor into R
## https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
## Use the parameter native=TRUE. What are the 30th and 80th quantiles of the
## resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

## calling the jpeg library
library(jpeg)

## Downloading the image file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile="./data/jeff.jpg", method = "curl")

## Reading the file thanks to the jpeg package
## Reading downloaded data
JeffPhoto <- readJPEG("./data/jeff.jpg", native = TRUE)

## Checking the quantiles as requested
My_quantile <- quantile(JeffPhoto, probs =c(0.3,0.8))
## OK good
##      30%       80% 
##-15258512 (need to add 638 to this result) -10575416


## QUESTION 3 - Merging Data
## ------------------------------------------
## Load the Gross Domestic Product data for the 190 ranked countries in this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
## Load the educational data from this data set:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
## Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in 
## descending order by GDP rank (so United States is last). What is the 13th country in the resulting data 
## frame?

## Downloading the Gross Domestic Product file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile="./data/GDP.csv", method = "curl")

## Downloading the educational data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile="./data/edu.csv", method = "curl")



