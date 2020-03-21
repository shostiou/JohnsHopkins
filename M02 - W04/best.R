## COURSERA JONHS HOPKINS - Module 02 - R PROGRAMMING
## 2020/03/20 - Stephane's assignment for Week 04



## FUNCTION BEST
## --------------
## This function takes two arguments:  the 2-character abbreviated name of a state and anoutcome name
## he function reads theoutcome-of-care-measures.csvfile and returns a character vectorwith  the  name
## of  the  hospital  that  has  the  best  (i.e.   lowest)  30-day  mortality  for  the  specified  outcomein that state. 
## The hospital name is the name provided in theHospital.Namevariable.
## The outcomes canbe one of “heart attack”, “heart failure”, or “pneumonia”
## Hospitals that do not have data on a namesparticularoutcome should be excluded from the set of hospitals when deciding the rankings.
## If there is a tie for the best hospital for a given outcome, then the hospital names shouldbe sorted in alphabetical order and 
## the first hospital in that set should be chose

best <- function (state, outcome)
  {
  
  ## Read outcome data
  ## -----------------
  outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check if the outcome argument is correct
  ## ----------------------------------------
  ## Building a list of valid outcome
  valid_outcome <- c("heart attack","heart failure","pneumonia")
  ## Checking if the outcome passed as an argument is valid converting outcome to lowercase for testing
  valid_outcome_test <- tolower(outcome)  %in% valid_outcome
  ## if not correct then stopping & returning an error message
  if (!valid_outcome_test)
    {
    # Reporting invalid outcome message
    stop ("invalid outcome")
  }
  
  ## Check if the state argument is correct
  ## ----------------------------------------
  ## Building a list of valid state
  valid_state <- unique(outcome_data[,"State"])
  ## Checking if the state passed as an argument is valid converting it to uppercase for testing
  valid_state_test <- toupper(state)  %in% valid_state  
  ## if not correct then stopping & returning an error message
  if (!valid_state_test)
  {
    # Reporting invalid state message
    stop ("invalid state")
  }
  
  ## Analyzing Data
  ## --------------
  
  ## Selecting dataframe column accorind to the outcome specified as argument
  ## Heart attack => column 11
  if (tolower(outcome)=="heart attack"){
    outcome_col=11
  }
  ## Heart failure => column 17
  if (tolower(outcome)=="heart failure"){
    outcome_col=17
  }  
  ## pneumonia => column 23
  if (tolower(outcome)=="pneumonia"){
    outcome_col=23
  }    
  
  ## subseting the dataframe
  ## Building a new DF containing : Hospital.Name / State / Outcome_data
  my_df <- subset(outcome_data, State == state, select=c(2, 7,outcome_col))
  ## Renaming outcome column
  colnames(my_df)[3] <- "Mortality_Outcome"
  ## Dropping Not Available data
  my_df <- subset(my_df, Mortality_Outcome != "Not Available")
  ## Finding the minimum Mortality for the outcome
  ## The Mortality is coded in character, the column needs to be converted to numeric
  ## so that the min function can be applied
  my_df$Mortality_Outcome <- as.numeric(my_df$Mortality_Outcome)
  min_mort = min(my_df$Mortality_Outcome)
  ## Finding the best hospitals
  my_result <- subset(my_df, Mortality_Outcome == min_mort)
  ## Sort result by ascending order
  my_result <- my_result[order(my_result$Hospital.Name),]
  ## Printing The best hospital name
  print(my_result[1,1])
  }