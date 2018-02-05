library(shiny)

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

server <- function(input, output) {
  
  output$hist <- renderPlot({
    
    hist(rnorm(input$obs), col = "#75AADB", border = "white",
         xlab = "Vc ",
         main = sprintf("Histograma da distribuição normal com %s observações",input$obs))
    
  })
  
}

shinyApp(ui=ui, server = server)