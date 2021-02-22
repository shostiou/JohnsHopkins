#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(
        titlePanel('Plot Random Number'),
        sidebarLayout(
            sidebarPanel(
                numericInput("numeric","How many random numbers to be plotted ?",
                             value=1000,min=1,max=1000,step=1),
                sliderInput("sliderX","pick min & Max values of X",
                            -100,100,value=c(-50,50)),
                sliderInput("sliderY","pick min & Max values of X",
                            -100,100,value=c(-50,50)),
                checkboxInput("show_xlab","Show / Hide X label",value=TRUE),
                checkboxInput("show_ylab","Show / Hide Y label",value=TRUE),
                checkboxInput("show_title","Show / Hide Title",value=FALSE)
            ),
        mainPanel(
            h3('Graph of Random Points'),
            plotOutput("plot1")
        )
        )
    )
    
)

