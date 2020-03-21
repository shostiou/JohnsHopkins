## COURSERA JONHS HOPKINS - Module 02 - R PROGRAMMING
## 2020/03/20 - Stephane's assignment for Week 04

## FUNCTION RANKHOSPITAL
## ---------------------
## Write a function calledrankhospitalthat takes three arguments:
## the 2-character abbreviated name of astate (state)
## an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).

##The function reads theoutcome-of-care-measures.csvfile and returns a character vector with
## the nameof the hospital that has the ranking specified by thenumargument.

## Thenumargument can take values “best”, “worst”,  or an integer indicating
## the ranking(smaller numbers are better)

## If the number given bynumis larger than the number of hospitals in thatstate
## then the function should return NA
## Hospitals that do not have data on a particular outcome shouldbe excluded
## from the set of hospitals when deciding the rankings.

rankhospital <- function(state, outcome, num = "best") 
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
  ## -----------------------------------------------------------------------------
  ## Building a new DF containing : Hospital.Name / State / Outcome_data
  my_df <- subset(outcome_data, State == state, select=c(2, 7,outcome_col))
  ## Renaming outcome column
  colnames(my_df)[3] <- "Mortality_Outcome"
  ## Dropping Not Available data
  my_df <- subset(my_df, Mortality_Outcome != "Not Available")
  
  ## Data Manipulation
  ## -----------------------------------------------------------------------------  
  ## The Mortality is coded in character, the column needs to be converted to numeric
  ## so that calculation can be applied
  my_df$Mortality_Outcome <- as.numeric(my_df$Mortality_Outcome)
  
  ## Sort result by ascending order
  my_result <- my_df[order(my_df$Mortality_Outcome,my_df$Hospital.Name),]
  
  
  ## Getting Max Index
  Max_index <- length(my_result$Mortality_Outcome)

  ## Building a vector where Mortality_Outcome values are stored
  #Mort_vector <- unique(my_result$Mortality_Outcome)
  #print(Mort_vector)
  
  ## Managing num values
  if (num=="best") 
    {
    Mort_index = 1
    }
  if (num=="worst") 
    {
    Mort_index = Max_index
    }  
  if (num>0 & num!="best" & num!="worst") 
    {
    Mort_index = num
    }    

  ## Getting & Reporting requested data
  my_return <- my_result[Mort_index,]
  print(my_return)
  
}
  
  
  
