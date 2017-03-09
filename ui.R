library("ggplot2")

my.ui <- fluidPage( theme = "style.css",
  
                 
  # Give the page a title
  titlePanel("Startups...."),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      radioButtons('success.type', label = "Choose the levels of success", choices = c("Comapnies the IPO'ed" = 'ipo', "Funding round type c and above" = 'c', "Funding round type b" = 'b', "Funding round type a" = 'a', "None of the above" = 'none'), selected = 'ipo'  ),
      sliderInput('year', "Which year", min = 1901, max = 2013, value = 2013 )
      
      ,width = 3), 
    # Create a spot for the barplot
    mainPanel(
      navbarPage(strong("StartUp"),        

                 tabPanel("About"),
                 tabPanel("Degrees", plotOutput('degree.plot')),
                 tabPanel("Relationships"),
                 tabPanel("Startup Hubs"),
                 position = "static-top"

      )
    )
    
  )
  
)

shinyUI(my.ui)
