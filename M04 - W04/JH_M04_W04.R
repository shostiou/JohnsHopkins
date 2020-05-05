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
## ---------------
## fips: A five-digit number (represented as a string) indicating the U.S. county
## SCC: The name of the source as indicated by a digit string (see source code classification table)
## Pollutant: A string indicating the pollutant
## Emissions: Amount of PM2.5 emitted, in tons
## type: The type of source (point, non-point, on-road, or non-road)
## year: The year of emissions recorded


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
# Checking the list of Pollutant in the DF
unique(NEI$Pollutant)
# Return : only one Pollutant in the data frame
unique(NEI$type)
# Retuns : "POINT"    "NONPOINT" "ON-ROAD"  "NON-ROAD"


## NEI Data Frame
## ---------------
# Source Classification Code Table (Source_Classification_Code.rds): This table provides a mapping from the SCC digit strings 
## in the Emissions table to the actual name of the PM2.5 source. 
## The sources are categorized in a few different ways from more general to more specific 
## and you may choose to explore whatever categories you think are most useful. 
## For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

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


## QUESTION 2
## ----------
## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.
# Sum of emissions per year for baltimore
NEI_Balt <- NEI[NEI$fips == "24510",]    
NEI_Balt_group_year <- group_by(NEI_Balt,year)
total_pm25_Balt <- summarize(NEI_Balt_group_year,pm25_sum=sum(Emissions))
# Plotting the evolution of PM25 vs years for Baltimore with basic plotting system
png("plot2.png")
with(total_pm25_Balt, plot(year,pm25_sum
                      ,main="Evolution of total PM2.5 emissions in Baltimore"
                      , type = "l",col="blue", xlab ="Years", ylab="Total PM2.5"))
dev.off()



## QUESTION 3
## ----------
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources
## have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 
## 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
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

## QUESTION 4
## ----------
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
## Looking for the index of this pollutant in the SCC Data Frame
coalSCCIndex <- SCC[grep("coal",tolower(SCC$Short.Name)),]$SCC
# Removing Levels factors
coalSCCIndex <- levels(droplevels(coalSCCIndex))
# Filtering US DF based on Coal pollution SCC
us_coal <- filter(NEI_group_year,SCC %in% coalSCCIndex)
total_us_coal <- summarize(us_coal,pm25_sum_coal=sum(Emissions))
# Plotting the evolution of PM25 vs years with basic plotting system
png("plot4.png", width=520, height=480)
with(total_us_coal, plot(year,pm25_sum_coal
                      ,main="Evolution of PM2.5 COAL Related sources emissions in the US"
                      , type = "l",col="blue", xlab ="Years", ylab="Total PM2.5 - COAL"))
dev.off()


