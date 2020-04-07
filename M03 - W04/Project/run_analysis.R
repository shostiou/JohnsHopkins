## COURSERA JONHS HOPKINS - Module 03 - READING DATA
## 2020/04/07 - Stephane's Project for Module 03
## Week 04

## PROJECT DESCRIPTION
## -------------------
## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set
## The goal is to prepare tidy data that can be used for later analysis.
## You will be required to submit: 
## 1) a tidy data set as described below
## 2) a link to a Github repository with your script for performing the analysis
## 3) a code book that describes the variables, the data, and any transformations
## or work that you performed to clean up the data called CodeBook.md
##
## You should also include a README.md in the repo with your scripts. 
##This repo explains how all of the scripts work and how they are connected.



## RAW DATA DESCRIPTION
## -------------------
## One of the most exciting areas in all of data science right now is wearable computing
## Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users
## The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone
## A full description is available at the site where the data was obtained:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Here are the data for the project:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



## PART 1 - Merging Training and Test Sets to create one Data Set
## --------------------------------------------------------------

## Setting Working Directory
setwd("/cloud/project/M03 - W04/Project")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

## Downloading the data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/dataset.zip")
## unzipping file to the data directory
unzip("./data/dataset.zip", exdir = "./data")

## Reading X data Files
## Reading features file - 561 rows
features <- read.table("./data/UCI HAR Dataset/features.txt", sep =" ", header=FALSE)
features <- features$V2
## Reading Training set - 561 columns - 7352
train_set <- read.table("./data/UCI HAR Dataset/train/X_train.txt", sep ="", header=FALSE)
## Reading Test set - 561 columns - 2947 rows
test_set <- read.table("./data/UCI HAR Dataset/test/X_test.txt", sep ="", header=FALSE)
## Creating a new data frame merging test and train data
data_set <- merge(train_set, test_set, all=TRUE)
## updating column names of the dataset with the features names
colnames(data_set) <- features



## PART 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
## ------------------------------------------------------------------------------------------------
## Using grpe command combined with metacharacters
## Copying to the data_std_mean dataframe
data_std_mean <- data_set[,grep("mean()|std()", colnames(data_set))]



## PART 3 - Uses descriptive activity names to name the activities in the data set 
## ------------------------------------------------------------------------------------------------
## Reading y Training set - 7352 rows
y_train_set <- read.table("./data/UCI HAR Dataset/train/y_train.txt", sep ="", header=FALSE)
## Reading y Test set - 5- 2947 rows
y_test_set <- read.table("./data/UCI HAR Dataset/test/y_test.txt", sep ="", header=FALSE)
## Creating a new data frame merging test and train data
y_data_set <- merge(y_train_set, y_test_set, all=FALSE)