library(shiny)
library(shinydashboard)

# Define UI
ui <- dashboardPage(
  
  # Application title
  dashboardHeader(title = "eGFR Calculator"),
  
  # Sidebar with inputs for eGFR calculation
  dashboardSidebar(
    numericInput("creatinine", 
                 "Serum Creatinine:", 
                 value = 1, 
                 min = 0.5, 
                 max = 15),
    radioButtons("units", 
                 "Units:", 
                 choices = c("mg/dL", "mmol/L")),
    numericInput("age", 
                 "Age:", 
                 value = 30, 
                 min = 18, 
                 max = 100),
    selectInput("sex", 
                "Sex:", 
                choices = c("Female", "Male"))
  ),
  # Show the eGFR calculation
  dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
    valueBoxOutput("eGFR")
  )
)

# Define server logic
server <- function(input, output) {
  eGFR <- reactive({
    # Validate user inputs
    validate(
      need(input$age >= 18 && input$age <= 100, "Please enter an age between 18 and 100."),
      need(input$creatinine > 0, "Please enter serum creatinine in mg/dL.")
    )
    # Determine the constants based on sex. 
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
    eGFR <- 142 * min_value^alpha * max_value^-1.200 * 0.9938^input$age * sex_constant
    
    eGFR
})
  
  output$eGFR <- renderValueBox({
    eGFR_value <- eGFR()
    
    # Determine color and subtitle based on eGFR value
    if (eGFR_value > 90) {
      color <- "green"
      subtitle <- "Normal kidney function"
    } else if (eGFR_value >= 60) {
      color <- "yellow"
      subtitle <- "Mildly decreased kidney function"
    } else if (eGFR_value >= 45) {
      color <- "orange"
      subtitle <- "Mildly to moderately decreased kidney function"
    } else if (eGFR_value >= 30) {
      color <- "red"
      subtitle <- "Moderately to severely decreased kidney function"
    } else if (eGFR_value >= 15) {
      color <- "maroon"
      subtitle <- "Severely decreased kidney function"
    } else {
      color <- "black"
      subtitle <- "Kidney failure"
    }
    # Return the eGFR as reactive color-coded value
    valueBox(
      HTML(paste("<strong>", round(eGFR_value, 0), "</strong>", 
                  "<span style='font-size:80%; opacity: 0.7;'> mL/min/1.73m<sup>2</sup></span>")),
      subtitle = subtitle,
      color = color,
      icon = icon("heartbeat")
    )
  })
}


# Run the application 
shinyApp(ui = ui, server = server)
