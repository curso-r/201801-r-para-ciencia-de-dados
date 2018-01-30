####################################################################################
### EXERCÍCIOS DA AULA 3                                                         ###
### DATA: 2018-02-02                                                             ###
### ARQUIVO: exercicios.R                                                        ###
### AUTOR: Caio Lente + Curso-R                                                  ###
####################################################################################



### PREPARAÇÃO #####################################################################

# Carregar bibliotecas necessárias
library(tidyverse)
library(stringr)
library(lubridate)
library(purrr)



### STRINGR ########################################################################

### MEXER COM STRINGS É FÁCIL ------------------------------------------------------

# 05.01: Rode a função `class()` em uma string. O que ela realmente é?


# 07.01: Carregue o `stringr` e procure por suas funções usando a tecla TAB.


# 07.02: Verifique como são contados caracteres escapados.


# 09.01: Tabulações são consideradas espaços?


# 09.02: Teste `str_sub()` dando valor só para `start` ou só para `end`. O que
# acontece se passarmos números negativos para ambos os parâmetros?

str_sub(c("__SP__", "__MG__", "__RJ__"), start = 3, end = 4)


# 10.01: E se passássemos uma variável numérica para essa função?

str_c("O valor p é: ", "0.03")


# 10.02: Use o argumento `sep` para remover a repetição de espaços. Use o
# argumento `collapse` para juntar as duas frases em uma.

s1 <- c("O R", "O Java")
s2 <- c("bom", "ruim")
str_c(s1, " é muito ", s2)


# 11.01: Partindo do vetor de strigs `vs`, obtenha o texto `s`:

vs <- c("***O número   " , "de caRACTeres", "   nEste TexTO", "é")
s <- "o número de caracteres neste texto é 36"


### REGEX --------------------------------------------------------------------------

# 13.01: Mude o valor do argumento `pattern` no código abaixo para que a expressão
# dê match com qualquer string que tenha como segunda letra um `a` minúsculo.

str_detect(c("banana", "BANANA", "maca", "nona"), pattern = "na")


### MEXER COM STRINGS É DIFÍCIL ----------------------------------------------------

# 16.1: Dado um número de 11 dígitos, transforme-o em um CPF da forma
# `544.916.518-84`.

num <- c(54491651884, 12345678901, 10932478919)


# 19.1: Partindo de `stringr::sentences`, crie o vetor `no_the`, onde todas as
# ocorrências da palavra "the" (ou "The") são removidas (mas tendo em mente que
# as frases devem continuar começando com letra maiúscula)

stringr::sentences



### LUBRIDATE ######################################################################

### CRIANDO DATAS ------------------------------------------------------------------

# 22.1: Qual é o formato esperado por `as_date()`? Rode `today()`.


# 23.1: Passe uma data para `as_datetime()` e uma data-hora para `as_date()`.


# 24.1: O que acontece se passarmos o número `20012018` para a função `dmy()`?


# 24.2: E se não quisermos especificar os minutos ou segundos de um datetime?


# 25.1: Crie um vetor `c(t1, t2)`. O que acontece quando você o imprime?

t1 <- dmy_hms("01/06/2015 12:00:00", tz = "America/New_York")
t2 <- dmy_hms("01/06/2015 13:00:00", tz = "America/Sao_Paulo")


# 25.2: Dê uma olhada na lista de fusos presentes em `OlsonNames()`.


# 26.1: Partindo do vetor de strigs `vt`, obtenha a data-hora `t`. Você deve fazer
# isso de duas formas diferentes: uma deve usar somente o pacote `lubridate` e a
# outra deve usar o pacote `stringr` também.

vt <- c("2015", "31", "03", "02", "59")
t <- ymd_hm("2015-03-31 02:59")


### MEXER COM DATAS É FÁCIL --------------------------------------------------------

# 28.1: Para que servem os argumentos de `wday()`?


# 29.1: Tente atribuir um valor inválido (maior que `31`) para `day(dt)`

dt <- ymd_hms("2016-07-08 12:34:56")


### MEXER COM DATAS É DIFÍCIL ------------------------------------------------------

# 31.1: Encontre a data de amanhã usando `today()` e um construtor de duração.


# 32.1: Onde mais esse tipo de diferença poderia aparecer?


# 33.1: `(today() %--% (today() + years(1))) / months(1)` funciona?


# 34.1: Partindo de `lubridate::lakers`, determine, em média, quanto tempo o
# Lakers (`team == "LAL"`) demora para arremessar a primeira bola (`etype == "shot"`)
# no primeiro período (`period == 1`).

lubridate::lakers



### PURRR ##########################################################################

### O QUE SÃO LISTAS? --------------------------------------------------------------

# 37.01: Rode o comando abaixo sem a função `str()`.

l <- list(
  um_numero = 123, um_vetor = c(TRUE, FALSE, TRUE),
  uma_string = "abc", uma_lista = list(1, 2, 3))
str(l)


# 38.01: Acesse o segundo elemento do quarto elemento de `l` com `[[]]`.


# 40.01: Crie uma lista com 3 níveis de profundidade e, depois de criada, atribua
# nomes para os elementos do terceiro nível (usando apenas `set_names()` e
# `pluck()`).


### ITERAÇÕES SIMPLES --------------------------------------------------------------


# 42.01: Reescreva o loop abaixo, mas agora considerado que `obj` é uma lista de 3
# elementos.

for (i in 1:3) {
  obj[i] <- soma_um(obj[i])
}


# 43.01: O que acontece se passarmos uma lista nomeada para `map()`?

ln <- list(a = 1:3, b = 4:6, c = 6:8)


# 47.01: Usando apenas duas chamadas de função (uma para `dplyr::tibble()` e outra
# para uma função do `purrr`), transforme a lista `l` na tabela `tl`:

t <- list(1:3, 11:13)
tl <- dplyr::tibble(col = 1:11, col1 = 2:12, col2 = 3:13)


### ITERAÇÕES AVANÇADAS ------------------------------------------------------------

# 50.01: Por que fui obrigado a utilizar `flatten_dbl()` até agora?


# 52.01: Por que, dentre todas as funções vistas até agora, estas retornam vetores
# naturalmente?


# 53.01: Partindo de `ggplot2::diamonds`, obtenha o máximo cumulativo das colunas
# numéricas sem usar `cummax()`. No final você deve obter uma tabela com as mesmas
# colunas que `ggplot2::diamonds` (inclusive com os mesmos nomes), mas onde as
# colunas numéricas agora representam os máximos cumulativos das suas versões
# originais.

ggplot2::diamonds


