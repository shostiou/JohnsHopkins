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
  # Reading file list
  fnames <- list.files()
  csv <- lapply(fnames, read.csv)
  # binding result into a dataframe
  result <- do.call(rbind, csv)
  # removing NA
  result <- na.omit(result)
  pollutantmean <- 0
    
  # extracting lines equal to specific id
  df_calc <- result[which((result$ID >= min(id)) & (result$ID <= max(id))),]

  if (pollutant == "sulfate"){
    pollutantmean <- mean(df_calc[,"sulfate"])
    }
  if (pollutant == "nitrate"){
    pollutantmean <- mean(df_calc[,"nitrate"])
  }
  # displayong result
  pollutantmean
}
  
