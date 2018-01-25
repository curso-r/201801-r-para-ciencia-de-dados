### Exercicio 1:

dados <- cars

ggplot(dados, aes(x=speed, y = dist))+
  geom_point()+
  labs(title = 'Dist vs Speed')


mod1<-lm(dist~speed, dados)

summary(mod1)

ggplot(dados, aes(x=speed, y = dist))+
  geom_point()+
  geom_abline(intercept = mod1$coefficients[1], slope = mod1$coefficients[2])+
  # geom_smooth(method = 'lm', se = FALSE)+
  labs(title = 'Dist vs Speed')

par(mfrow=c(2,2))

plot(mod1)

####################
set.seed(1991)
dados <- dados %>%
  mutate(x2 = dist*2)

mod2<- lm(dist~speed+x2, dados)

summary(mod2)
