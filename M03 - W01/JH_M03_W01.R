## COURSERA JONHS HOPKINS - Module 03 - READING DATA
## 2020/03/23 - Stephane's assignment for Week 01

## Setting Working Directory
setwd("/cloud/project/M03 - W01")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

## Downloading HOUSE PRICES file from the Web
## ------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/microdata.csv", method = "curl")

## Recording download date
dateDownloaded <- Date()

## Reading downloaded data
microData <- read.table("./data/microdata.csv", sep =",", header=TRUE)


## Downloading NATURAL GAS file from the Web
## ------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile="./data/NGAP.xlsx", method = "curl")

## Reading downloaded data
library(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("./data/NGAP.xlsx", sheetIndex=1, rowIndex = rowIndex, colIndex = colIndex)


## Downloading BALTIMORE RESTAURANTS file from the Web
## ------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile="./data/restaurants.xml", method = "curl")

## Reading downloaded data
library(XML)
doc <- xmlTreeParse(sub("s", "", fileUrl), useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

## Getting access to ZipCode
## rootNode[[1]][[1]][[2]]
## <zipcode>21206</zipcode> 

## Extracting zip code information
zipcodelist <- xpathSApply(rootNode,"//zipcode",xmlValue)
## Grouping results
table(zipcodelist)



## he American Community Survey distributes downloadable data about 
## United States communities. Download the 2006 microdata survey about 
## housing for the state of Idaho using download.file() from here: 
## ---------------------------------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./data/micro.csv", method = "curl")

# install.packages("data.table")
library("data.table")
DT=fread(fileUrl)

## Tries to identify the fastest calculation 
print(system.time(DT[,mean(pwgtp15),by=SEX]))
print(system.time(sapply(split(DT$pwgtp15,DT$SEX),mean)))
print(system.time(mean(DT$pwgtp15,by=DT$SEX)))
print(system.time(tapply(DT$pwgtp15,DT$SEX,mean)))

## SWirl
install.packages("swirl")
packageVersion("swirl")
library(swirl)
install_from_swirl("Getting and Cleaning Data")
swirl()



