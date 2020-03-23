## COURSERA JONHS HOPKINS - Module 03 - READING DATA
## 2020/03/23 - Stephane's assignment for Week 01

## Setting Working Directory
setwd("/cloud/project/M03 - W01")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

## Downloading HOUSE PRICES file from the Web
## ------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/microdata.csv", method = "curl")

## Recording download date
dateDownloaded <- Date()

## Reading downloaded data
microData <- read.table("./data/microdata.csv", sep =",", header=TRUE)


## Downloading NATURAL GAS file from the Web
## ------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="./data/NGAP.xlsx", method = "curl")

## Reading downloaded data
library(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("./data/NGAP.xlsx", sheetIndex=1, rowIndex = rowIndex, colIndex = colIndex)



