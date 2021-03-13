#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Libraries required for the project
library(shiny)
library(ggplot2)


# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {

    output$treesplot <- renderPlot({

        # generate the variables to be displayed (link with UI)
        #print("The value of x is ", input$x_var)
        x    <- trees[,input$x_var]
        y    <- trees[,input$y_var]
        # color pf the plot
        plt_col <- input$radio_color
        # point size
        pt_size <- input$pt_size
        # ggplot2 to build the plot
        ggplot()+
            geom_point(mapping=aes(x=x,y=y),col=plt_col, size=pt_size)+xlab(input$x_var)+ylab(input$y_var)
        

    })

})
