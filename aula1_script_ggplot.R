# Gramática dos Gráficos ----- (script inspirado pelo material da Curso-R (https://github.com/curso-r/main-visualizacao))

library(tidyverse)

fmi <- read_tsv("dados/fmi_weo.csv")

# Filosofia

# Um gráfico estatístico é uma representação visual dos dados 
# por meio de atributos estéticos (posição, cor, forma, 
# tamanho, ...) de formas geométricas (pontos, linhas,
# barras, ...). Leland Wilkinson, The Grammar of Graphics

# Layered grammar of graphics: cada elemento do 
# gráfico pode ser representado por uma camada e 
# um gráfico seria a sobreposição dessas camadas.
# Hadley Wickham, A layered grammar of graphics 

# Primeiro Gráfico

ggplot(data = fmi) +
  geom_point(mapping = aes(x = ano, y = desemprego))

# Incluindo primeiras características estéticas

ggplot(data = fmi) +
  geom_point(mapping = aes(x = ano, y = desemprego, color = pais))

# 1. Exercício - Crie um gráfico que identifique, em pontos, a variação da inflação -----
## de Brasil, EUA e China.




# Além de "cores" é possível incluir característica estética "size"
# para indicar o tamanho de cada observação do gráfico.

ggplot(data = fmi) +
  geom_point(mapping = aes(x = ano, y = desemprego, 
                           color = pais, size = inflacao))

# MUITA ATENÇÃO! se o argumento "color" for incluído fora da função "aes"
# o gráfico não funcionará.

ggplot(data = fmi) +
  geom_point(mapping = aes(x = ano, y = desemprego), color = "vermelho")

# No entanto, se você colocar o nome da cor em inglês, o gráfico ficará todo da cor especificada.

ggplot(data = fmi) +
  geom_point(mapping = aes(x = ano, y = desemprego), color = "red")

## 2. Exercício - crie gráfico de desemprego por ano, mas com uma variável à sua escolha -----
## no atributo "cor" 




# Figuras Geométricas

## Gráficos de linha

ggplot(data = fmi) +
  geom_line(mapping = aes(x = ano, y = desemprego, color = pais))

## Geom Smooth

ggplot(data = fmi) +
  geom_line(mapping = aes(x = ano, y = desemprego, color = pais)) +
  geom_smooth(mapping = aes(x = ano, y = desemprego))

ggplot(data = fmi) +
  geom_line(mapping = aes(x = ano, y = desemprego, color = pais)) +
  geom_smooth(mapping = aes(x = ano, y = desemprego, color = pais))

## Geom Area

ggplot(data = fmi) +
  geom_area(mapping = aes(x = ano, y = desemprego, fill = pais))

## Geom Col

ggplot(data = fmi) +
  geom_col(mapping = aes(x = ano, y = desemprego, fill = pais))

# Facets

ggplot(data = fmi) +
  geom_line(mapping = aes(x = ano, y = desemprego)) +
  facet_wrap(~ pais)

ggplot(data = fmi) +
  geom_line(mapping = aes(x = ano, y = desemprego)) +
  facet_wrap(~ pais, nrow = 3)

ggplot(data = fmi) +
  geom_line(mapping = aes(x = ano, y = desemprego)) +
  facet_wrap(~ pais, scales = "free")

# 3. Exercício - O que acontece quando se coloca no facet outras variáveis? -----



# Ajuste de Posição

ggplot(data = fmi) +
  geom_col(mapping = aes(x = ano, y = desemprego))

## Ajuste de posição - dodge, identity ou fill

ggplot(data = fmi) +
  geom_col(mapping = aes(x = ano, y = desemprego, fill = pais),
           position = "identity", alpha = 0.7)

fmi %>% 
  filter(ano > 2020) %>% 
  ggplot() +
  geom_col(mapping = aes(x = ano, y = desemprego, fill = pais),
           position = "dodge")

ggplot(data = fmi) +
  geom_col(mapping = aes(x = ano, y = desemprego, fill = pais),
           position = "fill")

# Sistema de Coordenadas

ggplot(data = fmi, mapping = aes(x = pais, y = desemprego)) +
  geom_boxplot()

ggplot(data = fmi, mapping = aes(x = pais, y = desemprego)) +
  geom_boxplot() +
  coord_flip()

# Título, fontes e comentários

ggplot(data = fmi) +
  geom_line(aes(ano, desemprego, color = pais)) +
  labs(title = "Desemprego, em %",
       subtitle = "A partir de 1980",
       caption = "Fonte: World Economic Outlook, FMI")

# 4. Exercícios -------

# Crie um gráfico que compare, com facets, cores, 
# o crescimento do PIB dos três países.



# Corrija os códigos abaixo

ggplot(data = fmi) + 
  geom_pont(mapping = aes(x = ano, y = dividaliquida, color = vermelho))

ggplot(data = fmi) + 
  geom_point(aes(x = ano, y = gdpppercapita, fill = pais))

ggplot(data = fmi) +
  geom_col(mapping = aes(x = ano, y = gdpgrowth, fill = desemprgo)) +
  facet_wrap(pais, nrows = 3)

# A partir do objeto "exportacoes", com informações sobre as exportações do Brasil
# no ano de 2020, construa gráfico que demonstre os destinos dos principais produtos
# exportados presentes na base de dados.

paises_selecionados_br <- c("Argentina", "Estados Unidos", "China")
exportacoes <- readr::read_csv2("dados/exportacoes2020.csv") %>% 
  filter(no_pais %in% paises_selecionados_br)

           