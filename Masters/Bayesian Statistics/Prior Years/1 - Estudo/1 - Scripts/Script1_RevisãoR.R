  ## Revisão de R_2020_2021.pdf

PACKAGE_LIST <- c('ggplot2', 'data.table', 'dplyr')
## ggplot: ggplot2; geom_line; theme_minimal; facet_wrap; aes
## dplyr: %>%; rbind
## data.table: data.table;

NEW_PACKAGES <- PACKAGE_LIST[!PACKAGE_LIST %in% installed.packages()[,'Package']]
if(length(NEW_PACKAGES)) install.packages(NEW_PACKAGES)
for(PACKAGE_LOOP_VARIABLE in PACKAGE_LIST){library(PACKAGE_LOOP_VARIABLE, character.only = T)}
rm(list=c('NEW_PACKAGES', 'PACKAGE_LIST', 'PACKAGE_LOOP_VARIABLE'))

## 
## Exercicio 1
##

distribution_Rayleigh <- function(x, sigma){
  ## Implements Rayleigh distribution:
  ## (x / sigma²) * e^(- x² / (2*sigma²))
  
  a = x / sigma^2
  b = exp(- x^2 / (2*sigma^2))
  
  return (a*b)
}

df_RayleighXY = data.table(sigma = numeric(), x = numeric(), y = numeric())
Rayleigh_sigmas = c(1, 2, 3, 4)
RayleighX = seq(0, 10, 0.001)

for(sigma in Rayleigh_sigmas){
  RayleighY =  distribution_Rayleigh(RayleighX, sigma)
  df_RayleighXY %>% rbind(data.table(sigma = sigma, x = RayleighX, y = RayleighY)) -> df_RayleighXY
}
rm(sigma)

df_RayleighXY %>% mutate(sigma = as.factor(sigma)) -> df_RayleighXY

ggplot(data = df_RayleighXY) +
  geom_line(aes(x = x, y = y, color = sigma)) +
  facet_wrap(~sigma) + 
  theme_minimal()

ggplot(data = df_RayleighXY) +
  geom_line(aes(x = x, y = y, group = sigma, color = sigma)) +
  theme_minimal()

rm(list=c('Rayleigh_sigmas', 'RayleighX', 'RayleighY', 'df_RayleighXY', 'distribution_Rayleigh'))


## 
## Exercicio 2
##

distribution_Miscellaneous <- function(x){
  a = 1/4
  b = x/2
  if(x >= 0){
    y = a * exp(-b)
  } else {
    y = a * exp(b)
  }
  
  return(y)
}

MiscellaneousX = seq(-4, 4, 0.001)
MiscellaneousY = distribution_Miscellaneous(MiscellaneousX)
df_Miscellaneous = data.table(x = MiscellaneousX, y = MiscellaneousY)
ggplot(data = df_Miscellaneous) +
  geom_line(aes(x = x, y = y)) +
  theme_minimal()


rm(list=c('MiscellaneousX', 'MiscellaneousY', 'df_Miscellaneous', 'distribution_Miscellaneous'))

## 
## Exercicio 3
##

df_GlicemiaData <- fread('data/Glicemia.txt')

df_GlicemiaData %>% summary()

df_GlicemiaData %>% summarize(v_max = max(V1),
                              v_min = min(V1),
                              v_mean = mean(V1),
                              v_25 = quantile(V1, 0.25),
                              v_75 = quantile(V1, 0.75),
                              v_perc1 = quantile(V1, 0.8),
                              v_sd = sd(V1),
                              sd_var = v_sd^2)

ggplot(data = df_GlicemiaData) +
  geom_boxplot(aes(y = V1)) +
  theme_minimal()

ggplot(data = df_GlicemiaData) +
  geom_bar(aes(x = V1)) +
  theme_minimal()

rm(df_GlicemiaData)
