server <- function(input, output) {
  
  output$hist <- renderPlotly({
    
    
    plot_ly(x = ~rnorm(input$obs), 
            type = "histogram",
            marker = list(color = 'royalblue',
                          line = list(color = 'rgb(158,202,225)')),
            hoverinfo = 'x+y') %>%
      layout(title = sprintf("Histograma da distribuição normal com %s observações",input$obs),
             bargap = 0.01,
             xaxis = list(title = 'Normal(0,1)'),
             yaxis = list(title = 'Frequência'))
    
    # hist(rnorm(input$obs), col = "#75AADB", border = "white",
    #      xlab = "n()",
    #      main = sprintf("Histograma da distribuição normal com %s observações",input$obs))
    
  })
  # observe({print(input$obs)})
}