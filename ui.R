library("ggplot2")
library("knitr")
library("plotly")

my.ui <- fluidPage( theme = "style.css",
  
                 
  # Give the page a title
  titlePanel("StartUp"),
  # Displays intro text
  p(h2(textOutput('user'))),
  # creates a dialog for user name input
  modalDialog(h3("Hey, what's your name?"),textInput("user", label = "",placeholder = 'Type here..'), title = NULL, footer = modalButton("Let me in"),
              size = "s", easyClose = FALSE, fade = TRUE),
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      radioButtons('success.type', label = "Choose the levels of success", choices = c("Comapnies the IPO'ed" = 'ipo', "Funding round type c and above" = 'c', "Funding round type b" = 'b', "Funding round type a" = 'a'), selected = 'ipo'  )
      #sliderInput('year', "Which year", min = 1901, max = 2013, value = 2013 )
      
      ,width = 3), 
    # Create a spot for the barplot
    mainPanel(
      navbarPage(strong("StartUp"),        

                 tabPanel("About", includeMarkdown("About.md")),
                 tabPanel("Degrees",textOutput("degreeText"),br(), em(h3("Number of members with their respective degrees in the chosen funding round")),plotlyOutput('plot'), br(),em(h3("Total number of members with their respective degrees ")), plotOutput('total')),
                 tabPanel("Startup Hubs",textOutput('mapText'), br(), plotOutput('scatter')),
                 tabPanel("Relationships", br(),textOutput('r.text'),br(), plotOutput("r.ipo"), br(), plotOutput("r.a") , br(), plotOutput("r.b") , br(), plotOutput("r.c")),
                 position = "static-top"

      )
    )
    
  )
  
)

shinyUI(my.ui)
