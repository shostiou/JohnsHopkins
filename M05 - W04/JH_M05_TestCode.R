## JOHNS HOPKINS - MODULE 05 - Reproducibility
## Week 04 - Module Final assignment



## INSTALLAING SPECIFIC LLIBRARIES
## ===============================

## Calling the tidyverse package
library(tidyverse)
library(varhandle)



## DATA PROCESSING
## ================


## Setting Working directory
setwd("~/projects/JohnsHopkins/M05 - W04")

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



## Getting Data
## ------------

## Donwloading raw data from the course Web site
## https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2
## Raw data is stored in csv (comma separated file)

fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
download.file(fileUrl, destfile="./data/rawstorm.bz2",method="libcurl")

## Unzipping the storm data file to "data" disrectory
# Unzipping data - byusing read.csv and bzfile commands
# Unzipped data is transferred to the rawstorm dataframe
rawstorm_df <- read.csv(bzfile("./data/rawstorm.bz2"),sep=',')


## Analyzing Data
## --------------

## QUESTION 1 : Across the United States, which types of events (EVTYPE Variable) are most harmful 
## with respect to population health?

## This question can be answered by focussing on data appearing in the "Fatalities" and "Injuries" columns of the dataset.
## Note that data stored in the dataset is reporting direct fatalities / direct injuries related to a specific storm event.

## Creating a subset to focus only on EVTYPE (type of events), Fatalities and injuries then building a pipe :
## grouping by EV_TYPE, Summarizing by sum of fatalities & injuries per event + arranging by descending order
## The resulting dataframe is stored in the "harmfulevent_df" variable
harmfulevent_df <- select(rawstorm_df,EVTYPE,FATALITIES,INJURIES) %>% group_by(EVTYPE) %>% 
  summarise(TOT_FATALITIES = sum(FATALITIES), TOT_INJURIES = sum(INJURIES)) %>% arrange(desc(TOT_FATALITIES), desc(TOT_INJURIES))
 




## QUESTION 2 : Across the United States, which types of events have the greatest economic consequences ?

## This question can be answered by focussing on data contained in the "Damage" Columns.
## Damage data is encoded into 4 columns :
## - PROPDMG : Property Damage
## - PROPGMGEXP : Property Damage expenses
## - CROPDMG : Crop Damage
## - CROPDMGEXP : Crop Damage expenses

## Creating a subset to focus only on EVTYPE (type of events) and damages thanks to a pipe.

dmgevent_df <- select(rawstorm_df,EVTYPE,PROPDMG,PROPDMGEXP,CROPDMG,CROPDMGEXP) %>% group_by(EVTYPE) #%>% 
  #summarise(TOT_FATALITIES = sum(FATALITIES), TOT_INJURIES = sum(INJURIES)) %>% arrange(desc(TOT_FATALITIES), desc(TOT_INJURIES))



## RESULTS
## ================

## Most Harmful Event
## ------------------

# Focussing on the 6 most impacting events in terms of total number of deaths and injuries, it appears that the most harmful
# event is TORNADO

head(harmfulevent_df)

# This observation can be confirmed by a plot showing the 6 most Fatel events
# Note that in order to arrange the plot in descending order, the factor levels need to be updated thanks to a pipe

head(harmfulevent_df) %>% mutate(EVTYPE=factor(EVTYPE, levels=EVTYPE)) %>%
ggplot(aes(EVTYPE, group=1)) + geom_line(aes(y=TOT_FATALITIES),color="darkred") +
  labs(title = "TOTAL FATALITIES / EVENT")



