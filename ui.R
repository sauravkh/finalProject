my.ui <- fluidPage(
  
  # Give the page a title
  titlePanel("Startups...."),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      p("Side panel goes here ")
    ),
    
    # Create a spot for the barplot
    mainPanel(
       
      tabsetPanel(
        tabPanel("Tab 1"),
        tabPanel("Tab 2"),
        tabPanel("Tab 3")
        
      ),
      p("main panel goes here") 
    )
    
  )
  
)

shinyUI(my.ui)
