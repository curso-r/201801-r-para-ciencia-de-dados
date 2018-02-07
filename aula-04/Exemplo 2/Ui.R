ui <- fluidPage(
  
  titlePanel("Meu primeiro shiny app!"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "obs",
                  label = "Número de observações:",
                  min = 1,
                  max = 1000,
                  value = 100)
    ),
    
    mainPanel(
      plotOutput(outputId = "hist")
    )
  )
)