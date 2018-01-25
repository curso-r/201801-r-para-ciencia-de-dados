#Pacotes -----------------------------------------------------
library(dplyr)
library(ggplot2)

# Gerar dados -------------------------------------------------------------
titanic <- read_csv('https://github.com/curso-r/pu.modelos/raw/master/data/titanic-train.csv')


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
aderencia <- validation %>%
  select(Survived, Prob) %>%
  mutate(Prob_Perc = cut(Prob, quantile(Prob, seq(0,1,0.05),na.rm = T), include.lowest = T)) %>%
  group_by(Prob_Perc) %>%
  summarise(n_survived = sum(Survived))

# Validando -----------------------------------------------------------

#Sem tratar NA

validation_1 <- base_2 %>%
  select(PassengerId, Survived, Pclass,Sex,Age) %>%
  mutate(Prob = predict(fit_1, newdata = ., type = 'response'))

# Espera-se que haja maior concentração de sobrevivente nos intervalos
# mais altos de probabilidade

aderencia_1 <- validation_1 %>%
  select(Survived, Prob) %>%
  mutate(Prob_Perc = cut(Prob, quantile(Prob, seq(0,1,0.05),na.rm = T), include.lowest = T)) %>%
  group_by(Prob_Perc) %>%
  summarise(n_survived = sum(Survived))


# Imputando média nos NA

base_2 <- base_2 %>% 
  mutate(Age = if_else(is.na(Age),mean(.$Age,na.rm = T), Age))

validation_2 <- base_2 %>%
  select(PassengerId, Survived, Pclass,Sex,Age) %>%
  mutate(Prob = predict(fit_1, newdata = ., type = 'response'))

# Espera-se que haja maior concentração de sobrevivente nos intervalos
# mais altos de probabilidade
quant <- quantile(validation_2$Prob, seq(0,1,0.05))

quant[5]<- quant[5] + 0.000001

aderencia_2 <- validation_2 %>%
  select(Survived, Prob) %>%
  mutate(Prob_Perc = cut(Prob, quant, include.lowest = T)) %>%
  group_by(Prob_Perc) %>%
  summarise(n_survived = sum(Survived))


# Se existisse uma mulher, 
# com 0 anos e classe 0 (mais foda que a classe 1),
# a probabilidade de sobreviver:

exp(5.492780)/(1+exp(5.492780))

