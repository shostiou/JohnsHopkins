## Johns Hopkins - Module 02 - R Programming
## Week 02 - Assignemnt
## calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors
## S. Hostiou - 06/03/2020 - Init

# Write a function that reads a directory full of files and reports the number of completely observed cases in each data file
# The function should return a data frame where the first column is the name of the file
# and the second column is the number of complete cases. A prototype of this function follows

complete <- function (directory, id = 1:332){
  # directory - indicates the directory of the csv file
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
  # dataframe creation
  my_df <- result[complete.cases(result), ]
  
  complete <- aggregate(cbind(count = ID) ~ ID, 
                        data = my_df, 
                        FUN = function(x){NROW(x)})
}  
  
  