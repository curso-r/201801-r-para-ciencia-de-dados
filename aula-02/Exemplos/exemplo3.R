#Pacotes -----------------------------------------------------
library(dplyr)
library(magrittr)
library(ggplot2)

# Gerar dados -------------------------------------------------------------

# Os dados se referem a um estudo sobre autoavaliação geral de saúde (1=não boa, 0=boa) 
# de n=30 indivíduos com idade variando de 20 a 95 anos. 
# O objetivo do estudo é estudar a relação entre a autoavaliação de saúde (Y) 
# e as seguintes variáveis explicativas: idade(em anos) e 
# renda familiar per capita (1=Mais de 3 s.m, 0= Até 3 s.m=base).

dados<- data.frame(idade=c(21,20,25,26,22,35,36,40,42,46,59,50,60,72,85,59,29,45,39,45,20,25,36,58,95,52,80,85,62,72),
renda=c(1,1,1,1,0,0,1,1,1,1,1,0,1,1,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,1),
saude=c(0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1))

#dados para predição -----------------------------------------
dados2<- data.frame(idade = c(18,22,45,78,44,65,99,89,22,23),
                    renda = c(1,0,0,1,0,1,0,0,0,1))

# Ajustando o modelo ----------------------------------------

fit <- glm(saude~renda+idade,dados, family = binomial(link = 'logit'))
summary(fit)

#prevendo --------------------------------------------
dados2 %<>% mutate(resp = predict(fit, newdata = dados2, type = 'response'))


#como f(x) é estritamente crescente, quanto maior a idade, maior a probabilidade da saude não ser boa
#analogamente, se a renda > 3 sm, menor a probabilidade da saude nao ser boa

# Indivíduos com mais de 3 salários mínimos tem uma chance de reportar 
# um estado de saúde não bom 95,8% menor do que os indivíduos 
# que ganham no máximo 3 salários mínimos.

# A chance do indivíduo reportar um estado de saúde 
# não bom aumenta em 14,2% ao aumentar em 1 ano a idade.