## COURSERA JONHS HOPKINS - Module 04 - EXPLORATORY DATA ANALYSIS
## 2020/05/04 - Stephane's assignment - Week 04 - Final
##
## PLOT 01
## --------------------------------------------------------------

## == CONTEXT ==========================================================

## Setting Working Directory
setwd("/Home/projects/JohnsHopkins/M04 - W04")

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
## ---------------
## fips: A five-digit number (represented as a string) indicating the U.S. county
## SCC: The name of the source as indicated by a digit string (see source code classification table)
## Pollutant: A string indicating the pollutant
## Emissions: Amount of PM2.5 emitted, in tons
## type: The type of source (point, non-point, on-road, or non-road)
## year: The year of emissions recorded

## SCC Data Frame
## ---------------
# Source Classification Code Table (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings 
## in the Emissions table to the actual name of the PM2.5 source. 
## The sources are categorized in a few different ways from more general to more specific 
## and you may choose to explore whatever categories you think are most useful. 
## For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

## == ASSIGNMENT QUESTIONS ================================

## QUESTION 1
## ----------
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system,
## make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# calling the dplyr package
library(dplyr)
# Sum of emissions per year
NEI_group_year <- group_by(NEI,year)
total_pm25 <- summarize(NEI_group_year,pm25_sum=sum(Emissions))
# Plotting the evolution of PM25 vs years with basic plotting system
png("plot1.png")
with(total_pm25, plot(year,pm25_sum
                      ,main="Evolution of total PM2.5 emissions in the US"
                      , type = "l",col="blue", xlab ="Years", ylab="Total PM2.5"))
dev.off()

