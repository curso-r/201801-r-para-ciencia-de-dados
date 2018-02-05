library(shiny)
library(plotly)

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
      plotlyOutput(outputId = "hist")
    )
  )
)

server <- function(input, output) {
  
  output$hist <- renderPlotly({
    
    
    plot_ly(x = ~rnorm(input$obs), 
            type = "histogram",
            marker = list(color = 'royalblue',
                          line = list(color = 'rgb(158,202,225)')),
            hoverinfo = 'x+y') %>%
      layout(bargap = 0.01,
             xaxis = list(title = 'Normal(0,1)'),
             yaxis = list(title = 'Frequência'))
    
  })
}

shinyApp(ui, server)