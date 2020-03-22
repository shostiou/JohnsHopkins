## COURSERA JONHS HOPKINS - Module 02 - R PROGRAMMING
## 2020/03/20 - Stephane's assignment for Week 04

## FUNCTION RANKALL
## ---------------------

## Write a function called rankallthat takes two arguments: 
## an outcome name (outcome) and a hospital rank-ing (num).
## The function reads theoutcome-of-care-measures.csvfile and 
## returns a 2-column data frame containing the hospital in each 
## state that has the ranking specified in num. 
## or example the function call rankall("heart attack", "best")would return a data frame
## containing the names of the hospitals thatare the best in their respective states for 
## 30-day heart attack death rates.
## The function should return a valuefor every state (some may beNA)
## The first column in the data frame is namedhospital, which contains the hospital name, 
## and the second column is namedstate, which contains the 2-character abbreviation forthe state name
## Hospitals that do not have data on a particular outcome should be excluded from the set ofhospitals
## when deciding the rankings

## The function should check the validity of its arguments.  
## If an invalid outcomevalue is passed to rankall,the function should throw an error via 
## the stop function with the exact message “invalid outcome”. 
## If the number given bynumis larger than the number of hospitals in that state, 
## then the function should return NA.


rankall <- function(outcome, num = "best") 
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

  ## Selecting dataframe column accordind to the outcome specified as argument
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
  my_df <- subset(outcome_data, select=c(2, 7,outcome_col))
  ## Renaming outcome column
  colnames(my_df)[3] <- "Mortality_Outcome"
  ## Dropping Not Available data
  my_df <- subset(my_df, Mortality_Outcome != "Not Available")  
  
  ## Data Manipulation
  ## -----------------------------------------------------------------------------  
  ## The Mortality is coded in character, the column needs to be converted to numeric
  ## so that calculation can be applied
  my_df$Mortality_Outcome <- as.numeric(my_df$Mortality_Outcome)
  
  
  ## For Loop
  ## ------------------------------------------------------------------------------
  ## A for loop will be required to go through all states and get the required data
  ## Building a vector containing the list of the states
  State_vector <- sort(unique(my_df$State))
  
  ## building index for result_df + resul_df init
  state_result_df <- data.frame(hospital=character(),
                          state = character())

  for (my_index in State_vector)
  {
    ## State subset
    my_state_df <- subset(my_df, State == my_index)
    
    ## Sort result by ascending order
    my_state_df <- my_state_df[order(my_state_df$Mortality_Outcome,my_state_df$Hospital.Name),]
    
    ## Managing num values
    ## Getting the max index for the state => worst calculation
    Max_index <- length(my_state_df$Mortality_Outcome)
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
    my_state_df <- my_state_df[Mort_index,]
    ## Adding observations to dataframe
    ## Creating a transfert DF for rbind
    transfert_df <- data.frame(my_state_df$Hospital.Name[1],my_index)
    names(transfert_df)<-c("hospital","state")

    ## binding result
    state_result_df <- rbind(state_result_df,transfert_df)
    
  }
  state_result_df 
  
}
