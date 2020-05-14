---
title: "Reproducible Research: Peer Assessment 1"
author: "shostiou"
date: "14/05/2020"
output: 
  html_document:
    keep_md: true
---


## Loading and preprocessing the data

#### Loading the data

```r
    ## Reading csv file
    activity <- read.csv("./data/activity.csv")
    ## Controlling Head & Tail of the dataset
    head(activity)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```

```r
    tail(activity)
```

```
##       steps       date interval
## 17563    NA 2012-11-30     2330
## 17564    NA 2012-11-30     2335
## 17565    NA 2012-11-30     2340
## 17566    NA 2012-11-30     2345
## 17567    NA 2012-11-30     2350
## 17568    NA 2012-11-30     2355
```

The variables included in this dataset are:

* **steps**: Number of steps taking in a 5-minute interval (missing
    values are coded as `NA`)

* **date**: The date on which the measurement was taken in YYYY-MM-DD
    format

* **interval**: Identifier for the 5-minute interval in which
    measurement was taken


## What is mean total number of steps taken per day?

For this part of the assignment, the missing values of the dataset will be ignored  
The dplyr package will be used.






```r
    # Building a pipe
    activity_sum_day <- activity %>% na.omit() %>%  group_by(date) %>% summarize(sum_steps =sum(steps))
    # Plotting histogram total nb of steps taken each day
    hist(activity_sum_day$sum_steps, breaks = 30, col="lightblue", main="total number of steps taken per day"
     ,xlab="sum of steps per day")
```

![](PA1_shostiou_files/figure-html/total_nb_steps_day-1.png)<!-- -->




#### Number of steps taken per day



## What is the average daily activity pattern?



## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?
