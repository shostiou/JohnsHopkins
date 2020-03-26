## COURSERA JONHS HOPKINS - Module 03 - READING DATA
## 2020/03/23 - Stephane's assignment for Week 02

## Personal tests - connecting to MySQL database
library("RMySQL")
## Connecting to Database where AEMP data is stored
myDB <- dbConnect(MySQL(),user="s03Y5pmEya",password="jliPwtRnyh",host="remotemysql.com")
## getting access to the list of datanbases
result<-dbGetQuery(myDB,"show databases;")
## Targeted database
SelectedDB <- result$Database[2]
## Listing tables from the selectedDB
myDB <- dbConnect(MySQL(),user="s03Y5pmEya",password="jliPwtRnyh",host="remotemysql.com", db=SelectedDB)
myDBTables <- dbListTables(myDB)
## Sending a query to the AEMP_V2_CAT Table
MyQuery <- dbSendQuery(myDB,"SELECT * FROM AEMP_V2_CAT LIMIT 5")
## fetching result
fetch(MyQuery)
dbDisconnect(myDB)