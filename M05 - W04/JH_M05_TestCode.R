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
## - PROPGMGEXP : Alphabetical characters used to signify magnitude include “K” for thousands, “M” for millions, and “B” for billions. 
## - CROPDMG : Crop Damage
## - CROPDMGEXP : Alphabetical characters used to signify magnitude include “K” for thousands, “M” for millions, and “B” for billions.

## Creating a subset to focus only on EVTYPE (type of events) and damages thanks to a pipe.

dmgevent_df <- select(rawstorm_df,EVTYPE,PROPDMG,PROPDMGEXP,CROPDMG,CROPDMGEXP) %>% group_by(EVTYPE) #%>% 
  #summarise(TOT_FATALITIES = sum(FATALITIES), TOT_INJURIES = sum(INJURIES)) %>% arrange(desc(TOT_FATALITIES), desc(TOT_INJURIES))

## Let's check if the data is consistent


## Checking the consistency of the data stored in the PROPDMGEXP column.
## - Is there nas ?
## - are alphabetical characters conform to desciption : "k","M" or "B" ?

sum(is.na(dmgevent_df$PROPDMG))
sum(is.na(dmgevent_df$PROPDMGEXP))
## There is no nas
unique(dmgevent_df$PROPDMGEXP)
## A bunch of values aren' conform to description : "+, 0, 5, 6, h, H, etc."
## Let's determine the number of inconsistent records
sort(summary(dmgevent_df$PROPDMGEXP))
## It appears that the majority of the events are correctly encoded with values "","K" or "M"
## Rejecting the other values can be considered as part of the data cleanin process


## Checking the consistency of the data stored in the CROPDMGEXP column.
## - Is there nas ?
## - are alphabetical characters conform to desciption : "k","M" or "B" ?

sum(is.na(dmgevent_df$CROPDMG))
sum(is.na(dmgevent_df$CROPDMGEXP))
## There is no nas
unique(dmgevent_df$CROPDMGEXP)
## A bunch of values aren' conform to description : "?","m","2" etc."
## Let's determine the number of inconsistent records
sort(summary(dmgevent_df$CROPDMGEXP))
## It appears that the majority of the events are correctly encoded with values "","K" or "M"
## Rejecting the other values can be considered as part of the data cleanin process


## Data Cleaning
## As a first step, data cleaning will consist in keeping correctly encoded values 
## let's define a vector of "correct amount characters" amount_char_v 
amount_char_v <- c("","K","M","B")
# Extracting proper data from the dataframe using the previous verctor
dmgevent_clean_df <- dmgevent_df %>% filter(PROPDMGEXP %in% amount_char_v,CROPDMGEXP %in% amount_char_v)
# Correction factor levels
dmgevent_clean_df <- droplevels(dmgevent_clean_df)



## Preprocessing : Calculating cumulated damages
## This operations requires to merge information contained on xxxDMG and xxxDMGEXP columns into numerical values
## ie if the value of xxxDMGEXP = K => then xxxDMG value will be multiplied by 1000
dmgevent_clean_df <- dmgevent_clean_df %>% 
  mutate(PROPDMGEXP_num = 
    case_when(
      PROPDMGEXP=="" ~ 1,
      PROPDMGEXP=="K" ~ 1000,
      PROPDMGEXP=="M" ~ 1000000,
      PROPDMGEXP=="B" ~ 1000000000)
    )

dmgevent_clean_df <- dmgevent_clean_df %>% 
  mutate(CROPDMGEXP_num = 
           case_when(
             CROPDMGEXP=="" ~ 1,
             CROPDMGEXP=="K" ~ 1000,
             CROPDMGEXP=="M" ~ 1000000,
             CROPDMGEXP=="B" ~ 1000000000)
  )  


## Adding a column to the DF containing the total damages costs (Property + Crop damages)
dmgevent_clean_df <- mutate(dmgevent_clean_df, TOTDMG = PROPDMG*PROPDMGEXP_num + CROPDMG*CROPDMGEXP_num)

## Subsetting the DF in order to report total damage costs grouped by events and sorted in desc order
dmgcost_df  <- select(dmgevent_clean_df,EVTYPE,TOTDMG) %>% group_by(EVTYPE) %>% summarise(TOT_DAM_COST = sum(TOTDMG)) %>% 
                                                                                       arrange(desc(TOT_DAM_COST))

# It appears that there are encoding errors in the encoding of the "Thunderstorm Winds" events.
# The same event is encoded under 3 designations : TSTM WIND, THUNDERSTORM WIND, THUNDERSTORM WINDS
# A final cleaning step has to be done for results to be representatives to assign homogeneous categories
dmgcost_df[which(dmgcost_df$EVTYPE=="TSTM WIND"),] <- dmgcost_df[which(dmgcost_df$EVTYPE=="THUNDERSTORM WIND"),]
dmgcost_df[which(dmgcost_df$EVTYPE=="THUNDERSTORM WINDS"),] <- dmgcost_df[which(dmgcost_df$EVTYPE=="THUNDERSTORM WIND"),]


## Final Merging after correcting Thuderstorm Wind category
dmgcost_df  <- dmgcost_df %>% group_by(EVTYPE) %>% summarise(TOT_DAM_COST = sum(TOT_DAM_COST)) %>% arrange(desc(TOT_DAM_COST))



## RESULTS
## ================

## Most Harmful Event
## ------------------

# Focussing on the 6 most impacting events in terms of total number of deaths and injuries, it appears that the most harmful
# event is TORNADO

head(harmfulevent_df)

# This observation can be confirmed by a plot showing the 6 most Fatal events
# Note that in order to arrange the plot in descending order, the factor levels need to be updated thanks to a pipe

head(harmfulevent_df) %>% mutate(EVTYPE=factor(EVTYPE, levels=EVTYPE)) %>%
ggplot(aes(EVTYPE, group=1)) + geom_line(aes(y=TOT_FATALITIES),color="darkred") +
  labs(title = "TOTAL FATALITIES / EVENT")

# This observation can be confirmed by a plot showing the 6 most events bringing the higgestes injuries
# Note that in order to arrange the plot in descending order, the factor levels need to be updated thanks to a pipe

head(harmfulevent_df) %>% mutate(EVTYPE=factor(EVTYPE, levels=EVTYPE)) %>%
  ggplot(aes(EVTYPE, group=1)) + geom_line(aes(y=TOT_INJURIES),color="darkblue") +
  labs(title = "TOTAL INJURIES / EVENT")



## Event having the greatest economical impact
## -------------------------------------------

# Focussing on the 6 most impacting events in terms of economical aspect, it appears that the most significant event is 
# event is Thunderstorm Winds.
head(dmgcost_df)
# It appears that the event having, by far, the greatest economical impact is Thunderstorm Wind

# Let's confirm this observation with a plot

head(dmgcost_df) %>% mutate(EVTYPE=factor(EVTYPE, levels=EVTYPE)) %>%
  ggplot(aes(EVTYPE, group=1)) + geom_line(aes(y=TOT_DAM_COST),color="darkgreen") +
  labs(title = "TOTAL DAMAGE COST / EVENT")





