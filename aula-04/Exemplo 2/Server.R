server <- function(input, output) {
  
  output$hist <- renderPlot({
    
    hist(rnorm(input$obs), col = "#75AADB", border = "white",
         xlab = "n()",
         main = sprintf("Histograma da distribuição normal com %s observações",input$obs))
    
  })
  # observe({print(input$obs)})
}