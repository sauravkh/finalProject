library("ggplot2")
library("knitr")
library("plotly")
source("degrees.R")
my.server <- function(input, output) { 

  table <- reactive({
    if(input$success.type == 'a') {
      return(success.a.plot)
    }else if(input$success.type == 'ipo') {
      return(success.ipo.plot)
    }else if(input$success.type == 'b') {
      return(success.b.plot)
    }else {
      return(success.c.plot)
    }

  })

  # generates a plot of measurments vs stats
  #if(input$success.type == 'a'){
    output$plot <- renderPlotly({
      return(table())
    })
    
    output$total <- renderPlot({
      return(plot.total)
    })
    
    output$degreeText <- renderText({
      
      return("It can be seen that the ratio of MBAs in successful start ups went up as the start ups proceeded in the funding rounds which implies that as the company grows it tends to employ more MBA graduates")
    })
  # } else if(input$success.type == 'b'){
  #   output$plot <- renderPlotly({
  #     return(success.b.plot)
  #   })
  # } else if(input$success.type == 'c'){
  #   output$plot <- renderPlotly({
  #     return(success.c.plot)
  #   })
  # } else if(input$success.type == 'ipo'){
  #   output$plot <- renderPlotly({
  #     return(success.ipo.plot)
  #   })
  # }  else{
  #   output$plot <- renderPlot({
  #     return(total.plot)
  #   })
  # }
  

  
}

shinyServer(my.server)