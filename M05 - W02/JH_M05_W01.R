## COURSERA JONHS HOPKINS - Module 05 - REPRODUCIBLE RESEARCH
## 2020/05/14 - Stephane's assignment - Week 02

## == CONTEXT ==========================================================

## Setting Working Directory
setwd("/cloud/project/M05 - W02/RepData_PeerAssessment1")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

setwd("./M05 - W02/RepData_Assessment1/")
# Unzipping data
zipF<- "activity.zip"
outDir <-"./data"
unzip(zipF,exdir=outDir)



# Reading CSV file
activity <- read.csv("./data/activity.csv")


# Number of steps taken per day
# Calling the dplyr package
library(dplyr)
# Building a pipe
activity_sum_day <- activity %>% na.omit() %>%  group_by(date) %>% summarize(sum_steps =sum(steps))
hist(activity_sum_day$sum_steps, breaks = 30, col="lightblue", main="total number of steps taken per day"
     ,xlab="sum of steps per day")


barplot(sum_steps ~ date ,data = activity_sum_day, col='lightblue', main="total number of steps taken per day", ylab="sum of steps per day")


<- group_by(activity,date)
summarize(activity_day,sum_steps =sum(steps,na.rm = TRUE))
          

