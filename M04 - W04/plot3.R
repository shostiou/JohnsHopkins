## COURSERA JONHS HOPKINS - Module 04 - EXPLORATORY DATA ANALYSIS
## 2020/05/04 - Stephane's assignment - Week 04 - Final
##
## PLOT 03
## --------------------------------------------------------------

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



## QUESTION 3
## ----------
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources
## have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
## 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
# calling the dplyr package
library(dplyr)
## For Baltimore, grouping data by year and type
NEI_Balt_group_year2 <- group_by(NEI_Balt,year,type)
## Summarizing data - total Emissions per year / type
total_pm25_Balt2 <- summarize(NEI_Balt_group_year2,pm25_sum=sum(Emissions))
## Calling the ggplot2 package
library(ggplot2)
# Plotting pollution based on type
png("plot3.png")
qplot(year,pm25_sum,data = total_pm25_Balt2, color = type, geom = "line", main="Evolution of total PM2.5 emissions in Baltimore by type of source")
dev.off()

