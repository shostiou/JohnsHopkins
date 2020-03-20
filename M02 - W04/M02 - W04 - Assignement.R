## COURSERA JONHS HOPKINS - Module 02 - R PROGRAMMING
## 2020/03/20 - Stephane's assignment for Week 04



## FUNCTION BEST
## --------------
## This function takes two arguments:  the 2-character abbreviated name of a state and anoutcome name
## he function reads theoutcome-of-care-measures.csvfile and returns a character vectorwith  the  name
## of  the  hospital  that  has  the  best  (i.e.   lowest)  30-day  mortality  for  the  specified  outcomein that state. 
## The hospital name is the name provided in theHospital.Namevariable.
## The outcomes canbe one of “heart attack”, “heart failure”, or “pneumonia”
## Hospitals that do not have data on a particularoutcome should be excluded from the set of hospitals when deciding the rankings.
## If there is a tie for the best hospital for a given outcome, then the hospital names shouldbe sorted in alphabetical order and 
## the first hospital in that set should be chose

best <- function (state, outcome)
  {
  
  ## Check if outcome argument is correct
  ## ------------------------------------
  ## Building a list of valid outcome
  valid_outcome <- c("heart attack","heart failure","pneumonia")
  ## Checking if the outcome passed as an argument is valid
  valid_outcome_test <- outcome  %in% valid_outcome
  ## if not correct then returning an error message
  if (!valid_outcome_test)
    {
    print ("Error in best( $state $outcome ) : invalid outcome")
    }
   
  
  
  
  
  }