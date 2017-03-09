library("ggplot2")

my.ui <- fluidPage( theme = "style.css",
  
                 
  # Give the page a title
  titlePanel("Startups...."),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      checkboxGroupInput('success.type', label = "Choose the levels of success", choices = c("Comapnies the IPO'ed" = 'ipo', "Funding round type c and above" = 'c', "Funding round type b" = 'b', "Funding round type a" = 'a', "None of the above" = 'none'), selected = 'ipo'  )
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
