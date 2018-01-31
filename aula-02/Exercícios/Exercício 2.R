#Pacotes -----------------------------------------------------
library(dplyr)
library(ggplot2)

# Gerar dados -------------------------------------------------------------
titanic <- read_csv('https://github.com/curso-r/pu.modelos/raw/master/data/titanic-train.csv')

summary(titanic$Age)
titanic<- titanic %>% 
  mutate(Age = if_else(is.na(Age),mean(base_1$Age, na.rm = T),Age))
# Separando a base -----------------------------------------------------
set.seed(01021991)
base_1<- sample_frac(titanic, 0.7)
base_2<- titanic %>% anti_join(base_1, by =c('PassengerId'))





# Modelo ---------------------------------------------------------------

fit_1 <- glm(Survived~Pclass+Sex+Age, base_1, family = binomial(link = 'logit'))
summary(fit_1)

# Aderencia do modelo na base de modelagem ---------------------------
validation <- base_1 %>%
  select(PassengerId, Survived, Pclass,Sex,Age) %>%
  mutate(Prob = predict(fit_1, newdata = ., type = 'response'))

# Espera-se que haja maior concentração de sobrevivente nos intervalos
# mais altos de probabilidade
summary(validation$Prob)

quant = quantile(round(validation$Prob,3), seq(0,1,0.05),na.rm = T)
quant

quant[1]<- min(validation$Prob)
quant[4]<- quant[4]+ 0.00001
quant[5]<- quant[4]+ 0.00001
quant[21] <- max(validation$Prob)

aderencia <- validation %>%
  select(Survived, Prob) %>%
  mutate(Prob_Perc = cut(Prob, quant, include.lowest = T)) %>%
  group_by(Prob_Perc) %>%
  summarise(n_tot = n(),
            n_survived = sum(Survived)) %>%
  mutate(tx_survived = n_survived/n_tot)

# Validando -----------------------------------------------------------

validation_1 <- base_2 %>%
  select(PassengerId, Survived, Pclass,Sex,Age) %>%
  mutate(Prob = predict(fit_1, newdata = ., type = 'response'))

# Espera-se que haja maior concentração de sobrevivente nos intervalos
# mais altos de probabilidade
quant_1 = quantile(round(validation_1$Prob,3), seq(0,1,0.05),na.rm = T)
quant_1

quant_1[1]<- min(validation_1$Prob)
quant_1[5]<- quant[5]+ 0.00001
quant_1[21] <- max(validation_1$Prob)

aderencia_1 <- validation_1 %>%
  select(Survived, Prob) %>%
  mutate(Prob_Perc = cut(Prob, quant_1, include.lowest = T)) %>%
  group_by(Prob_Perc) %>%
  summarise(n_tot = n(),
            n_survived = sum(Survived)) %>%
  mutate(tx_survived = n_survived/n_tot)


# Se existisse uma mulher, 
# com 0 anos e classe 0 (mais foda que a classe 1),
# a probabilidade de sobreviver:

exp(5.492780)/(1+exp(5.492780))


# Arvore x glm  -----------------------------------------------

arvore <- rpart(as.factor(Survived) ~ Sex + Age + Pclass, 
                 # control = rpart.control(cp = 0.001),
                data = base_1)


validation_arvore_x_glm <- base_2 %>%
  select(PassengerId, Survived, Pclass,Sex,Age) %>%
  mutate(Prob_arvore = predict(arvore, newdata = ., type = 'prob')[,2],
         Prob_glm = predict(fit_1, newdata = ., type = 'response'))
  

library(tidyverse)
cortes <- seq(0,1,by = 0.01)

valores_arvore <- map_df(cortes, function(x){
  tabela <- table(
    validation_arvore_x_glm$Survived,
    factor(validation_arvore_x_glm[,6] > x, levels = c("FALSE", "TRUE"))
  )
  data_frame(
    corte = x,
    FPR_arv = tabela[1,2]/sum(tabela[1,]),
    TPR_arv = tabela[2,2]/sum(tabela[2,]),
    TNR_arv = tabela[1,1]/sum(tabela[1,]),
    FNR_arv = tabela[2,1]/sum(tabela[2,])
  )
})

valores_glm <- map_df(cortes, function(x){
  tabela <- table(
    validation_arvore_x_glm$Survived,
    factor(validation_arvore_x_glm[,7] > 0.75, levels = c("FALSE", "TRUE"))
  )
  data_frame(
    corte = x,
    FPR_glm = tabela[1,2]/sum(tabela[1,]),
    TPR_glm = tabela[2,2]/sum(tabela[2,]),
    TNR_glm = tabela[1,1]/sum(tabela[1,]),
    FNR_glm = tabela[2,1]/sum(tabela[2,])
  )
})

valores <- valores_arvore %>%
  inner_join(valores_glm, by =c('corte')) %>%
  select()

ggplot(valores) +
  geom_step(aes(x = FPR_arv, y = TPR_arv), color = 'red', size = 1) +
  geom_step(aes(x=FPR_glm, y = TPR_glm), size = 1)+
  labs(x='1-Especificidade', y = 'Sensibilidade')+
  geom_abline(color = 'blue', linetype = 'dashed')
