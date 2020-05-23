## JOHNS HOPKINS - MODULE 05 - Reproducibility
## Week 04 - Module Final assignment

## Setting Working directory
setwd("/cloud/project/M05 - W04")

## Preparing a directory to store data
if (!file.exists("data"))
{
    dir.create("data")
}

## Abstract
## Storms and other severe weather events can cause both public health and economic problems for communities and municipalities. 
## Many severe events can result in fatalities, injuries, and property damage, and preventing such outcomes to the extent 
## possible is a key concern.

## As part of the Coursera Johns Hopkins Data Science specialization, 
## this project involves exploring the U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database
## and answer some basic questions about severe weather events.


## Donwloading raw data from the course Web site
## https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2
## Raw data is stored in csv (comma separated file)

fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
download.file(fileUrl, destfile="./data/rawstorm.zip", method = "curl")

## Unzipping the storm data file to "data" disrectory
# Unzipping data - byusing read.csv and bzfile commands
# Unzipped data is transferred to the rawstorm dataframe
rawstorm_df <- bzfile("./data/rawstorm.zip")




