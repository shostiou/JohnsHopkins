## Johns Hopkins - Building data products.  
##
## Working with Shiny gadgets

library(shiny)
library(miniUI)


# My function

pickTrees <- function() {
  
  ui <- miniPage(
    gadgetTitleBar("Selectionnez des points avec la souris"),
    miniContentPanel(
      plotOutput("plot",height="100%",brush="brush")
      )
  )
  
  server <- function(input,output,session){
    output$plot <- renderPlot({
      plot(trees$Girth, trees$Volume,main="Trees!",
           xlab = "Girth", ylab="Volume")
    })
    observeEvent(input$done,{
      stopApp(brushedPoints(trees,input$brush, 
                            xvar="Girth", yvar="Volume"))
  })
  }
  
 # Calling the gadget  
  runGadget(ui,server)
}



# Googlevis

suppressPackageStartupMessages(library(googleVis))
M <- gvisMotionChart(Fruits,"Fruit","Year",
                     options = list(width=600,height=400))


P <- gvisGeoChart(Exports,locationvar = "Country",
                  colorvar = "Profit",
                     options = list(width=600,height=400))
print(P,"chart")




# Quiz 1 Question 5

library(shiny)
library(miniUI)

pickXY <- function() {
  ui <- miniPage(
    gadgetTitleBar("Select Points by Dragging your Mouse"),
    miniContentPanel(
      plotOutput("plot", height = "100%", brush = "brush")
    )
  )
  
  server <- function(input, output, session) {
    output$plot <- renderPlot({
      plot(data_frame$X, data_frame$Y, main = "Plot of Y versus X",
           xlab = "X", ylab = "Y")
    })
    observeEvent(input$done, {
      stopApp(brushedPoints(data_frame, input$brush,
                            xvar = "X", yvar = "Y"))
    })
  }
  
  runGadget(ui, server)
}

my_data <- data.frame(X = rnorm(100), Y = rnorm(100))

pickXY(my_data)
