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
