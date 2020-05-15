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

# Calculation of mean and median values per day
mean_step_day = mean(activity_sum_day$sum_steps)
median_step_day = median(activity_sum_day$sum_steps)

activity_test <- activity %>% na.omit()
plot(activity_test$interval,activity_test$steps, type='l')

activity_avg_day <- activity %>% na.omit() %>%  group_by(interval) %>% summarize(avg_steps =mean(steps))
plot(activity_avg_day$interval,activity_avg_day$avg_steps, type='l')
          
plot(activity_avg_day$interval,activity_avg_day$avg_steps, type='l', col='darkblue'
     ,main="Average number of steps - over days", xlab="Time interval",ylab="Nb of steps - averaged over days")


# Setting a vector containing indexes containing a NA
na_vector <- which(is.na(activity))
# Target
target<-activity[which(is.na(activity)),1]
# Source
source<-activity_avg_day[which(is.na(activity)),2]


activity_filled <- activity
activity_filled[which(is.na(activity)),1] <- activity_avg_day[which(is.na(activity)),2]



activity_filled <- activity
activity_filled[which(is.na(activity_filled)),1] <- activity_avg_day[which(is.na(activity_filled)),2]


activity[is.na(select(activity,c('steps','interval')))]

shop.data %>% 
    group_by(hour) %>%
    mutate(profit= replace(profit, is.na(profit), mean(profit, na.rm=TRUE)))


test <- activity %>% group_by(date) %>% mutate(steps=replace(steps, is.na(steps), mean(steps, na.rm=TRUE)))

for (i in which(is.na(activity)))
    {
    
    }



activity_sum_day_fill <- activity_filled %>% na.omit() %>%  group_by(date) %>% summarize(sum_steps =sum(steps))
# Plotting histogram total nb of steps taken each day
hist(activity_sum_day_fill$sum_steps, breaks = 30, col="lightgreen", main="total number of steps taken per day NAs filled"
     ,xlab="sum of steps per day")  


mean_step_day_f = mean(activity_sum_day_fill$sum_steps)
median_step_day_f = median(activity_sum_day_fill$sum_steps)
# Printing the result
paste("mean number of steps per day:",mean_step_day_f)
paste("median number of steps per day:",median_step_day_f)
# Differences
paste("Mean difference with dataset containing reoved NAs:",mean_step_day - mean_step_day_f)
paste("Median difference with dataset containing reoved NAs:",median_step_day - median_step_day_f)







# Creating a factor variable - weekends Y/N ?

activity_sum_day_fill




activity_sum_day_fill$date <- as.Date(activity_sum_day_fill$date, format = "%Y-%m-%d")
library(lubridate)
wday(activity_sum_day_fill$date, label = TRUE)

f<-rep(0:1,each=50)

#Factor variable 
f<-(wday(activity_sum_day_fill$date) == 1) | (wday(activity_sum_day_fill$date) == 7)
f<-factor(f,labels=c("weekday","weekend"))

activity_avg_day_f <- activity %>% na.omit() %>%  group_by(interval) %>% summarize(avg_steps =mean(steps))
plot(activity_avg_day$interval,activity_avg_day$avg_steps, type='l', col='darkblue'
     ,main="Average number of steps - over days", xlab="Time interval",ylab="Steps - averaged over days")


