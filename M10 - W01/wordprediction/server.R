#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
# Libraries required for the project
library(shiny)
library(R.utils)
library(RSQLite)
library(stringr)
library(tidyr)

# Define server logic required to predict the next word
shinyServer(
  
    function(input, output) {
        
        
       output$result <- renderTable({

            #reading input
            my_string <- gsub('[[:punct:] ]+',' ',input$user_text)
            my_string <- tolower(my_string)
            my_string <- trimws(my_string, "r")
            
            # connecting to database  
            mydb <- dbConnect(RSQLite::SQLite(), "ngrams_db_prob.sqlite")
            
            # Counting the number of words in the string
            nb_words <- str_count(my_string,"\\S+")
            word_1=''
            word_2=''
            word_3=''
            
            # init of the variable used to check if a result exists
            is_result <- 0
            
            # Looking for 4-grams
            if (nb_words >=3)
            {
                # Getting the words  
                word_1 = word(my_string,-1)
                word_2 = word(my_string,-2)
                word_3 = word(my_string,-3)
                
                # Building query to the DB  
                query4g <- paste0("SELECT word4 AS predicted,prob_n as probability  FROM fourgram_prob WHERE word3 LIKE '", word_1, 
                                  "' AND word2 LIKE '",word_2,
                                  "' AND word1 LIKE '",word_3,"' ORDER BY prob_n DESC LIMIT 3")
                result <- dbGetQuery(mydb, query4g)
                
                # Looking for an empty result
                is_result <- nrow(result)
                
            } 
            
            
            # Looking for 3-grams
            if ( ((nb_words ==2)| (is_result == 0)) & !(nb_words==1))
            {
                # Getting the words  
                word_1 = word(my_string,-1)
                word_2 = word(my_string,-2)
                
                # Building query to the DB  
                query3g <- paste0("SELECT word3 AS predicted,prob_n as probability FROM trigram_prob WHERE word2 LIKE '", word_1, 
                                  "' AND word1 LIKE '",word_2,"' ORDER BY prob_n DESC LIMIT 3")
                result <- dbGetQuery(mydb, query3g)
                
                # Looking for an empty result
                is_result <- nrow(result)
                
            } 
            
            # Looking for 2-grams
            if ((nb_words ==1)| (is_result == 0) )
            {
                # Getting the words  
                word_1 = word(my_string,-1)
                
                # Building query to the DB  
                query2g <- paste0("SELECT word2 AS predicted,prob_n as probability FROM bigram_prob WHERE word1 LIKE '", word_1,"' ORDER BY prob_n DESC LIMIT 3")
                result <- dbGetQuery(mydb, query2g)

            } 
        
            
            dbDisconnect(mydb)

        # Returning the result         
        result
       })        
            
    })
    

