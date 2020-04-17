## COURSERA JONHS HOPKINS - Module 04 - EXPLORATORY ANALYSIS
## 2020/04/11 - Reading instructor's book
## =======================================================
##
##
## Setting Working Directory
setwd("/cloud/project/M04 - W01")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}


## Reading the file
library(readr)
ozone <- read_csv("data/hourly_44201_2014.csv",n_max =1000000,col_types = "ccccinnccccccncnncccccc")
## Makes the column names correct
names(ozone)<-make.names(names(ozone))

## Quick check of data content
str(ozone)
nrow(ozone)
ncol(ozone)
table(ozone$Time.Local)

library(dplyr)
filter(ozone, Time.Local == "13:14") %>% select(State.Name, County.Name, Date.Local,Time.Local, Sample.Measurement)

