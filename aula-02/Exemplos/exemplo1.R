# Pacotes -----------------------------------------------------------------
library(dplyr)
library(readr)
library(rpart)
library(rpart.plot)

# Ler os dados ------------------------------------------------------------
titanic <- read_csv('https://github.com/curso-r/pu.modelos/raw/master/data/titanic-train.csv')

titanic2<-titanic
titanic2$Survived <- as.factor(titanic2$Survived)

# Ajuste ------------------------------------------------------------------
class(x~y)

arvore <- rpart(Survived ~ Sex + Age + Pclass, 
                # control = rpart.control(cp = 0.001),
                data = titanic2)

str(arvore)

summary(arvore)

rpart.plot(arvore)

titanic <- titanic %>%
  mutate(Prob_arvore = predict(arvore, newdata = titanic, type = 'prob')[,2])

classes <- predict(arvore, newdata = titanic, type = 'class')



# # ROC
# library(tidyverse)
# cortes <- seq(0,1,by = 0.01)
# valores <- map_df(cortes, function(x){
#   tabela <- table(
#     titanic$Survived, 
#     factor(probabilidades[,2] > x, levels = c("FALSE", "TRUE"))
#   )
#   data_frame(
#     corte = x,
#     FPR = tabela[1,2]/sum(tabela[1,]),
#     TPR = tabela[2,2]/sum(tabela[2,]),
#     TNR = tabela[1,1]/sum(tabela[1,]),
#     FNR = tabela[2,1]/sum(tabela[2,])
#   )
# })
# 
# ggplot(valores, aes(x = FPR, y = TPR)) + 
#   geom_step() + 
#   geom_abline(color = 'blue', linetype = 'dashed')
# 
# 
# # Função de custo
# 
# valores %>%
#   mutate(custo = FPR + FNR) %>%
#   ggplot(aes(x = corte, y = custo)) +
#   geom_line()
