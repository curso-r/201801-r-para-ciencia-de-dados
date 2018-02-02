fluidPage(
  headerPanel('Exercicio'),
  
  sidebarPanel(
    selectInput('xcol', 'Variável X', names(iris)),
    selectInput('ycol', 'Variável Y', names(iris),
                selected=names(iris)[[2]]),
    checkboxInput('lm', 'Adicionar Reta de Regressão', value = F)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)