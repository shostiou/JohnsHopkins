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
# library(tm)
library(dplyr)
library(tidyr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Next word prediction - Johns Hopkins Capstone"),
    
    
    tabsetPanel(
        # Main tab panel
        tabPanel("Main", 
                 sidebarLayout(
                     sidebarPanel( 
                         
                         p(''),
                         p('please select "Instructions" tab for help'),
                         p(''),
                         textInput("user_text", "Please type some text", value = "")
                     ), #sidebarPanel )
                     
                     # Show a plot of the generated distribution
                     
                     mainPanel(
                         h4("Next word prediction"),
                         tableOutput("result")
                     ) # mainPanel )
                     
                 )  #sidebarLayout )
        ), # tabPanel )
        # instructions tab panel
        tabPanel("Instructions",
                 p(""),
                 h2("User instructions"),
                 p("This application is used to do a basic exploration of the trees data set."),
                 p("It will automatically build a scatter plot between 2 variables of the data set"),
                 p(""),
                 h3('Step by step approach : '),
                 p("1. Please start by selecting the variable to be displayed on the x axis"),
                 p("2. Please start by selecting the variable to be displayed on the y axis"),
                 p("3. Please adjust the color of the plot according to your preferences"),
                 p("4. Please adjust the size of the scatter plot points according to your preferences"),
        ) # tabPanel )
    ) # tabSetPanel )
    
    
    
) # FluidPage )
)
