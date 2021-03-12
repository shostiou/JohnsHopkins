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
library(ggplot2)
library(tidyverse)
# calling the trees dataset
data(trees)

# trees variables list
trees_var <- colnames(trees)
#trees_var <-  c("Girth" = "Girth",
#                "Height" = "Height",
#                "Volume" = "Volume")

# list of colors for user choice
color_var <- c("black","green","blue","orange")


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Exploration of the trees dataset"),


        tabsetPanel(
            # Main tab panel
            tabPanel("Main", 
                     sidebarLayout(
                        sidebarPanel( 
                     
                            p(''),
                            p('please select "Instructions" tab for help'),
                            p(''),
                            selectInput("x_var","Select the x-axis variable",choices=trees_var),
                            selectInput("y_var","Select the y-axis variable",choices=trees_var),
                            radioButtons("radio_color","Select color of the plot",color_var)
                                    ), #sidebarPanel )

                     # Show a plot of the generated distribution
                     
                     mainPanel(
                         h4("Trees Dataset scatter plot"),
                         plotOutput("treesplot")
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
                     h3('User Actions : '),
                     p("1. Please start by selecting the variable to be displayed on the x axis"),
                     p("2. Please start by selecting the variable to be displayed on the y axis"),
                     p("3. Please adjust the color of the plot according to your preferences")
                    ) # tabPanel )
        ) # tabSetPanel )



    ) # FluidPage )
)
