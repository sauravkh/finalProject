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
    
    output$user <- renderText({
      answer <- paste0("Hi " ,input$user , ", this application helps you navigate your way through our visulatisations on the exhaustive data sets from crunchbase to learn more about how a startup grows and what myths about startup success are statistically true or not. ")
      return(answer)
    })
    
    output$degreeText <- renderText({
      
      return("It can be seen that the ratio of MBAs in successful start ups went up as the start ups proceeded in the funding rounds which implies that as the company grows it tends to employ more MBA graduates")
    })
    
    output$mapText <- renderText({
      return("What we have plotted is a map of startups in the USA according to their success rate. Companies that IPOed are displayed in red. Companies that got to series c funding but did not IPO are displayed in yellow. Companies that got to series b funding but not series c are displayed in green. Finally, companies that got to series a funding but not series b are displayed in blue. We have outlined our graph with the border of the U.S. in black to make it easier to visualize. The obvious startup hubs are the Seattle area, Silicon Valley, Southern California, and the New England coast. The number of startup companies found elsewhere is to be expected, as startup hubs tend to attract future startups. Notice that few of the companies founded out of startup hubs were very successful as most of these points are blue or green.")
    })
    
    output$r.text <- renderText({
      return("Here are scatter plots of the different funding rounds to show the number of relationships (x - axis) vs the amount of funding (y - axis) for differennt companies.")
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
    output$label <- renderText({
      return("Red represents companies that have IPOed, purple represents companies that have reaches series c funding, green represents series b funding, and blue series a funding.")
    })
}

shinyServer(my.server)