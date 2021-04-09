#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Libraries required for the project
library(shiny)
library(R.utils)
library(RSQLite)
library(tictoc)
library(stringr)
library(dplyr)
library(tidyr)

# Define UI for application that invites the user to type text and read a prediction
# of what could be the next word 
shinyUI(fluidPage(
    
    # Application title
    titlePanel("NEXT WORD PREDICTION - Shostiou's Johns Hopkins Capstone"),
    
    
    tabsetPanel(
        # Main tab panel
        tabPanel("Main", 
                 sidebarLayout(
                     sidebarPanel( 
                         h4("Predictions for the next word"),
                         br(),
                         br(),
                         br(),
                         textInput("user_text", "Please type some text in English", value = ""),
                         p('Please refer to the "Instructions" tab for details'),
                         br(),
                         br(),
                         br(),
                         img(src='coursera_logo.png', align = "center"),
                         br()
                     ), #sidebarPanel )
                     
                     # Displays predictions for the next word
                     mainPanel(
                         br(),
                         br(),
                         br(),
                         br(),
                         br(),
                         br(),
                         tableOutput("result")
                     ) # mainPanel )
                     
                 )  #sidebarLayout )
        ), # tabPanel )
        
        # instructions tab panel
        tabPanel("Instructions",
                 p(""),
                 h3("Instructions"),
                 p("This application is used to predict the next word from a string typed by the user."),
                 p("Please note that this program only builds prediction in the English language."),
                 p("The utilization of the application is straight forward : just type some text and check for predictions of the next word."),
                 p("This project concludes the Coursera Johns Hopkins' Data Science specilization."),
                 p(""),
                 h3('Details : '),
                 p("This program uses a combination of Markov chain rule & stupid backoff approaches "),
                 p("The algorithm was trained on samples (20%) of a set of 3 large text files : us_news, us_blogs and us_twitter."),
                 p("bi-grams, 3-grams and 4-grams have been built from the dataset."),
                 p("Frequency of words have been computed out of those n-grams : P(word_n|value of n-1 words)."),
                 p("This basically means : based on the last words typed by the user (4,3,2 last words), what is the probability to have the next word being word_n."),
                 p("As an initial attempt, considering the last 3 words typed by the user, the program tries to figure out if there is a match in its reference database. "),
                 p("If it exists, it returns 3 predictions for the next word by sorting results by highest probability."),
                 p("If no match is found, the program tries to find entries corresponding to 3-grams and so on."),
        ) # tabPanel )
    ) # tabSetPanel )
    
    
    
) # FluidPage )
)
