## COURSERA JONHS HOPKINS - Module 03 - READING DATA
## 2020/03/23 - Stephane's assignment for Week 01

## Setting Working Directory
setwd("/cloud/project/M03 - W02")

## Preparing a directory to store data
if (!file.exists("data"))
{
  dir.create("data")
}


## Getting data from the GitHub API
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

