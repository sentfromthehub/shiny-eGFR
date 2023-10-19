library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("eGFR Calculator"),
  
  # Sidebar with inputs for eGFR calculation
  sidebarLayout(
    sidebarPanel(
      numericInput("creatinine", 
                   "Serum Creatinine: (µmol/L)", 
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
    ),
    
    # Show the eGFR calculation
    mainPanel(
      textOutput("eGFR")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$eGFR <- renderText({
    # Determine the constants based on sex
    if (input$sex == "Female") {
      kappa <- 0.7
      alpha <- -0.241
      sex_constant <- 1.012
    } else {
      kappa <- 0.9
      alpha <- -0.302
      sex_constant <- 1
    }
    
    # Calculate the minimum and maximum of Scr/kappa or 1.0
    min_value <- min((input$creatinine/kappa), 1)
    max_value <- max((input$creatinine/kappa), 1)
    
    # Calculate eGFR
    eGFR <- 142 * min_value^alpha * max_value^-1.209 * 0.993^input$age * sex_constant
    
    # Return the eGFR as a string
    paste("eGFR:", round(eGFR, 2))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
