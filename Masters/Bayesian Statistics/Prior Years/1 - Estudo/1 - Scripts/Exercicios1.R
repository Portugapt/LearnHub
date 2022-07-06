## 2019/2020 Exercicios Pagina 1

## Calculos

# Ex1 
R2I = 0.5*.3
R2NI = 0.25*0.7

R2I / (R2I + R2NI)

rm(list=c('R2I', 'R2NI'))

##
## Ex2

a = 0.12 * 0.983

b = a + 0.88 * 0.012

1 - (a / b)


a = 0.12 * .017

b = a + (0.88 + 0.988)

a / b


## 
## Ex3
x = seq(1,5,1)
x_prob = dbinom(x, 5, 0.5)
y = seq(1,5,1)
save_probs = list()
for (exists in x){
    save_probs[[as.character(exists)]] = dbinom(y[1:exists], exists, 0.3)
}

func_conditionalX <- function(x, x_prob, xyprob){
  probabilidadeTotal = 0
  prob_step = c()
  for (v in names(xy_prob)){
    if(as.numeric(v) >= x){
      temp_prob = xy_prob[[v]][x]*x_prob[as.numeric(v)]
      prob_step = c(prob_step, temp_prob)
      probabilidadeTotal = probabilidadeTotal + temp_prob
    }
  }
  
  dist = prob_step / probabilidadeTotal
  return(dist)
}

func_conditionalX(2, x_prob, save_probs)


rm(list=c('func_conditionalX', 'save_probs', 'x_prob', 'y', 'x', 'exists'))
