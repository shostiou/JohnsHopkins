## COURSERA JONHS HOPKINS - Module 03 - READING DATA
## 2020/03/23 - Stephane's assignment for Week 01

## Setting Working Directory
setwd("/cloud/project/M03 - W02")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}


## QUESTION 1 - Getting data from the GitHub API
## ------------------------------------------
## Register an application with the Github API here https://github.com/settings/applications. 
## Access the API to get information on your instructors repositories
## (hint: this is the url you want "https://api.github.com/users/jtleek/repos").
## Use this data to find the time that the datasharing repo was created. What time was it created?


library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "73567e366a2526f748c1",
                   secret = "34c592af26b8665f527b7d60dac6d8bdf0bf7e03"
)

# 3. Get OAuth credentials
#github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
## as seen in the forum, there is an issue with oauth2.0 identification => 1.0 shall be used instead.
github_token <- oauth1.0_token(oauth_endpoints("github"), myapp)


# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

stop_for_status(req)
json1 = content(req)
json2 = jsonlite::fromJSON(json1)
json1[[16]]$created_at



## QUESTION 2; 3 - sqldf package
## ------------------------------------------
## The sqldf package allows for execution of SQL commands on R data frames. 
## We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.
## Download the American Community Survey data and load it into an R object called 

## Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 
## worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() 
## function like this to identify the rows of the data frame where the logical vector is TRUE. 

## Setting Working Directory
setwd("/cloud/project/M03 - W02")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

## Downloading HOUSE PRICES file from the Web
## ------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="./data/survey.csv", method = "curl")

## Recording download date
dateDownloaded <- Date()

## Reading downloaded data
acs <- read.table("./data/survey.csv", sep =",", header=TRUE)

## Installing the library
## install.packages("sqldf")

library(RMySQL)  ## This library has to be installed as well !
library(sqldf)

## Giving a try
## It is necessary to specify the driver prior using it.
options(sqldf.driver = "SQLite")
sqldf("select pwgtp1 from acs where AGEP < 50")

sqldf("select distinct AGEP from acs") == unique(acs$AGEP)


## QUESTION 4 - Reading from HTML
## ------------------------------------------
## How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
## http://biostat.jhsph.edu/~jleek/contact.html
## (Hint: the nchar() function in R may be helpful)

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode = readLines(con)
close(con)

nchar( htmlcode[10])
nchar( htmlcode[20])
nchar( htmlcode[30])
nchar( htmlcode[100])



## QUESTION 5 - 
## Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
## https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
## (Hint this is a fixed width file format)

## Setting Working Directory
setwd("/cloud/project/M03 - W02")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}

## ------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile="./data/indices.for", method = "curl")

## A specific package exists to read fixed width file format
x <- read.fwf(file="./data/indices.for",skip=4, widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))
sum(x$V4)

