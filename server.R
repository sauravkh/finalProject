library("ggplot2")
library("knitr")
library("plotly")
source("degrees.R")
source("offices.R")
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
  

  output$scatter <- renderPlot({
    return(everything)
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

    output$r.ipo <- renderPlot({
      return(funding.and.relations.plot.ipos)
    })
    output$r.a <- renderPlot({
      return(funding.and.relations.plot.a)
    })
    output$r.b <- renderPlot({
      return(funding.and.relations.plot.b)
    })
    output$r.c <- renderPlot({
      return(funding.and.relations.plot.c)
    })
}

shinyServer(my.server)