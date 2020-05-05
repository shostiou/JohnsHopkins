## COURSERA JONHS HOPKINS - Module 04 - EXPLORATORY DATA ANALYSIS
## 2020/05/04 - Stephane's assignment - Week 04 - Final
##
## PLOT 05
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



## QUESTION 6
## ----------
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County
## California "06037". Which city has seen greater changes over time in motor vehicle emissions?
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# calling the dplyr package
library(dplyr)
library(ggplot2)

## Data for BAltimore
NEI_Balt <- NEI[NEI$fips == "24510",]    
NEI_Balt_group_year <- group_by(NEI_Balt,year)
## Data for Los Angeles
NEI_LA <- NEI[NEI$fips == "06037",]    
NEI_LA_group_year <- group_by(NEI_LA,year)

## Looking for the index of vehicle pollution source in the SCC 
vehSCCIndex <- SCC[grep("veh",tolower(SCC$Short.Name)),]$SCC
# Removing Levels factors
vehSCCIndex <- levels(droplevels(vehSCCIndex))

# Filtering Baltimore DF based on Veh pollution SCC
balt_veh <- filter(NEI_Balt_group_year,SCC %in% vehSCCIndex)
total_balt_veh <- summarize(balt_veh,pm25_sum =sum(Emissions))
LA_veh <- filter(NEI_LA_group_year,SCC %in% vehSCCIndex)
total_LA_veh <- summarize(LA_veh,pm25_sum =sum(Emissions))
# Merging the dataframes
#merged_LA_balt <- merge(total_balt_veh, total_LA_veh, by.x = "year", by.y ='year', all = TRUE)
merged_LA_balt <- total_balt_veh %>%  mutate(City = 'Baltimore') %>% bind_rows(total_LA_veh %>%  mutate(City = 'Los Angeles'))


# Comparing the evolution of vehicule polution between LA and Baltimore
png("plot6.png", width=640, height=480)
bal_LA_plot <- ggplot(merged_LA_balt,aes(y = pm25_sum, x = year,color = City)) + geom_line() 
print(bal_LA_plot  + ggtitle("Comparing evolution of vehicule pollution between Baltimore & LA"))
dev.off()


