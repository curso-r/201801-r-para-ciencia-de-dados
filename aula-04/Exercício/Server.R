function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  
  output$plot1 <- renderPlot({
    if(input$lm == F){
    ggplot(iris, aes_string(x = input$xcol, y =input$ycol))+
      geom_point(size = 3)+
      labs(title = sprintf('%s vs %s', input$xcol, input$ycol))
    }
    else
    {
      ggplot(iris, aes_string(x = input$xcol, y =input$ycol))+
        geom_point(size = 3)+
        geom_smooth(method = 'lm', se=F)+
        labs(title = sprintf('%s vs %s', input$xcol, input$ycol))
    }
  })
  
}