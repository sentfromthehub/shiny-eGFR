library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("eGFR Calculator"),
  
  # Sidebar with inputs for eGFR calculation
  sidebarLayout(
    sidebarPanel(
      numericInput("creatinine", 
                   "Creatinine Level: (µmol/L)", 
                   value = 1, 
                   min = 0.5, 
                   max = 15),
      numericInput("age", 
                   "Age:", 
                   value = 30, 
                   min = 18, 
                   max = 100),
      selectInput("sex", 
                  "Sex:", 
                  choices = c("Female", "Male")),
      selectInput("race", 
                  "Race:", 
                  choices = c("Non-Black", "Black"))
    ),
    
    # Show the eGFR calculation
    mainPanel(
      textOutput("eGFR")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

}

# Run the application 
shinyApp(ui = ui, server = server)
