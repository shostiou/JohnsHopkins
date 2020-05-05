## COURSERA JONHS HOPKINS - Module 04 - EXPLORATORY DATA ANALYSIS
## 2020/05/04 - Stephane's assignment - Week 04 - Final

## == CONTEXT ==========================================================

## Setting Working Directory
setwd("./projects/JohnsHopkins/M04 - W04")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

## Downloading files from the Web
## ------------------------------------------
## Getting Datafile from the Web
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./data/Pollution.zip", method = "curl")
## Unzipping the file
zipF<- "/cloud/project/M04 - W04/data/Pollution.zip"
outDir<-"/cloud/project/M04 - W04/data"
unzip(zipF,exdir=outDir)

## Reading Files
## -------------------------------------------
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## == DATA EXPLORATION ==========================================================

## NEI Data Frame
print("NEI - Head")
head(NEI)
print("NEI - Tail")
tail(NEI)
print("NEI Summary")
summary(NEI)
print("NEI - str")
str(NEI)
print("NEI - NAs")
# Number of NAs
sum(is.na(NEI))
# There are no NAs the dataset has already been cleaned up.

## NEI Data Frame
print("SCC - Head")
head(SCC)
print("SCC - Tail")
tail(SCC)
print("SCC Summary")
summary(SCC)
print("SCC - str")
str(SCC)
print("SCC - NAs")
# Number of NAs
sum(is.na(SCC))
# There are 20330 NAs which is quite important
# Proportion of NAs
sum(is.na(SCC)) / (dim(SCC)[1] * dim(SCC)[2])
# Around 11.5% of NAs









