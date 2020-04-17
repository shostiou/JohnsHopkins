## COURSERA JONHS HOPKINS - Module 04 - EXPLORATORY ANALYSIS
## 2020/04/17 - Stephane's Assignment for Week 01
## PLOT 3 - Multiple Scatter plot
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
## The dataset is made of 9 columns  and 2075259 rows 

## Estimating memory usage
nrows_dataset = 2075259
ncols_dataset = 9
MemUsage_dataset = ncols_dataset * nrows_dataset * 8
paste("Memory Usage Estimation Mb :",MemUsage_dataset /1000000)
# Result : 149 Mb
# Considering that I am currently executing R Studio under a virtual environment with limited RAM (1 GB), there is enough
# memory available to upload the complete dataset


## PART 3 - Loading & Cleaning Data
## --------------------------------------------------------
## 
## Lets' use the readr package to upload the dataset
library(readr)
## Note that the file uses ";" separators => delim parameter has to be set
power <- read_delim("./data/household_power_consumption.txt",delim=";",col_names=TRUE)

## Converting Date variable to data format by calling the lubridate package
library(lubridate)
power$Date<-dmy(power$Date)

## Subseting dataset to focus only 
power_DF <- power[which(power$Date >="2007-02-01" & power$Date <= "2007-02-02"),]

## Cleaning the Data set
## Looking for ? values (corresponding to NAs)
library(dplyr)
power_DF<-select(power_DF,-contains("?"))



## PART 4 - Plotting Scatter Plot of submeters
## --------------------------------------------------------
##
## Merging Date & Time columns to get a proper time stamping reference
## Let's use the lubridate package
time_base <- with(power_DF, ymd(power_DF$Date) + hms(power_DF$Time))

## Using the basic plotting system
dev.off()
png("plot3.png", width=480, height=480)

## Drawing the scatter plots
plot(time_base,power_DF$Sub_metering_1 ,type="l",,xlab="",ylab="Energy sub metering",col="black")
lines(time_base,power_DF$Sub_metering_2 ,type="l",col="red")
lines(time_base,power_DF$Sub_metering_3 ,type="l",col="blue")
## Adding a legend
legend("topright" , col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))

dev.off()
