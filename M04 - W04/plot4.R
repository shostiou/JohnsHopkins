## COURSERA JONHS HOPKINS - Module 04 - EXPLORATORY DATA ANALYSIS
## 2020/05/04 - Stephane's assignment - Week 04 - Final
##
## PLOT 04
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

## QUESTION 4
## ----------
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
## Looking for the index of this pollutant in the SCC Data Frame
# calling the dplyr package
library(dplyr)

coalSCCIndex <- SCC[grep("coal",tolower(SCC$Short.Name)),]$SCC
# Removing Levels factors
coalSCCIndex <- levels(droplevels(coalSCCIndex))
# Filtering US DF based on Coal pollution SCC
NEI_group_year <- group_by(NEI,year)
us_coal <- filter(NEI_group_year,SCC %in% coalSCCIndex)
total_us_coal <- summarize(us_coal,pm25_sum_coal=sum(Emissions))
# Plotting the evolution of PM25 vs years with basic plotting system
png("plot4.png", width=520, height=480)
with(total_us_coal, plot(year,pm25_sum_coal
                         ,main="Evolution of PM2.5 COAL Related sources emissions in the US"
                         , type = "l",col="blue", xlab ="Years", ylab="Total PM2.5 - COAL"))
dev.off()


