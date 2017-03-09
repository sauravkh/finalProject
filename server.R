library("ggplot2")


my.server <- function(input, output) { 
    
  # generates a plot of measurments vs stats
  output$plot <- renderPlot({
    graph <- ggplot(data = "something from reactive table") +
      geom_bar(mapping = aes(x = ..., y = ..., fill = ..), stat = "identity") + 
      xlab("X label som,ething") +
      ylab("Y label something")
    return(graph)
  })
}

shinyServer(my.server)