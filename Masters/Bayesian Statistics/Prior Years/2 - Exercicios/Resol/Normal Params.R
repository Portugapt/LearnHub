thetas <- c(0.5, 0.625, 0.750, 0.875)
mods <- c(0.7,0.1,0.1,0.1)

xMi <- dbinom(8,10,thetas)

xMi_mod <- dbinom(8,10,thetas) * mods

MiX <- (xMi / sum(xMi_mod)) * mods

## Exercicio pag22a26 normal mu desconhecido

normalParams <- function(varP, varA, b, vetor){
  n <- length(vetor)
  m <- mean(vetor)
  tau <- 1/(varP**2)
  c <- 1/(varA**2)
  Alpha <- (n*tau*m + c*b) / (c + n*tau)
  Beta <- sqrt(1 / (c + n*tau))
  return (params = list(a = Alpha, b = Beta))
}



