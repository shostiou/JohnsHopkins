## Johns Hopkins - Module 02 - R Programming
## Week 02 - Assignemnt
## calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors
## S. Hostiou - 06/03/2020 - Init

pollutantmean <- function (directory, pollutant, id = 1:332){
  # directory - indicates the directory of the csv file
  # pollutant - "sulfate" or "nitrate"
  # id - monitor Id vector to be used

  # Inspired from the Web
  # Setting Working directory
  setwd("/cloud/project")
  setwd(directory)
  # Reading file list based on indexes
  fnames <- list.files()[id]
  csv <- lapply(fnames, read.csv)
  # binding result into a dataframe
  result <- do.call(rbind, csv)

  pollutantmean <- 0

  # Performing calculation
    if (pollutant == "sulfate"){
    pollutantmean <- mean(result[!is.na(result[,"sulfate"]),"sulfate"])
    }
  else if (pollutant == "nitrate"){
    pollutantmean <- mean(result[!is.na(result[,"nitrate"]),"nitrate"])
  }
  # displaying result
  pollutantmean
}




  
