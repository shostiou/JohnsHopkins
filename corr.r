## Johns Hopkins - Module 02 - R Programming
## Week 02 - Assignemnt
## calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors
## S. Hostiou - 06/03/2020 - Init

# Write a function that takes a directory of data files and a threshold for complete cases 
# and calculates the correlation between sulfate and nitrate for monitor locations where the
# number of completely observed cases (on all variables) is greater than the threshold.
# The function should return a vector of correlations for the monitors that meet the threshold requirement.
# If no monitors meet the threshold requirement, then the function should return a numeric vector of length 0.

# Personal observation : need to call the previously defined complete.r function to get access
# first of all to the list of files containing non NAs + define which file to collect based on count.

corr <- function (directory, threshold = 0){
  # directory - indicates the directory of the csv file
  # threshold - threshold requirement
  
  # Inspired from the Web
  # Setting Working directory
  setwd("/cloud/project")
  setwd(directory)
  
  # First, let's make a call to the complete observations function
  my_complete <- complete(directory)
  # Check which IDs have a greater count than threshold
  my_id <- my_complete[my_complete$count > threshold,]$ID
  
  # Checking if Nas, then returning 0
  if (sum(my_id) == 0) 
    {
      corr <-0
    }
  # No Nas so performing corr calculation
  else 
    {
      # Reading file list based on indexes
      fnames <- list.files()[my_id]
      csv <- lapply(fnames, read.csv)
      # binding result into a dataframe
      result <- do.call(rbind, csv)
      # dataframe creation
      my_df <- result[complete.cases(result), ]
      
      # Correlation
      corr <- by(my_df, my_df$ID, FUN = function(x) {cor(x$sulfate, x$nitrate)})
      
    } 
    
} 
  
  
  