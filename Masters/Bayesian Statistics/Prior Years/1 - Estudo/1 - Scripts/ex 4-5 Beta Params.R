estBetaParams <- function(mu, var) {
  alpha <- ((1 - mu) / var - 1 / mu) * mu ^ 2
  beta <- alpha * (1 / mu - 1)
  return(params = list(alpha = alpha, beta = beta))
}
## https://stats.stackexchange.com/questions/12232/calculating-the-parameters-of-a-beta-distribution-using-the-mean-and-variance

inverseBetaParams <- function(alpha, beta){
  med <- alpha/(alpha+beta)
  var <- (alpha*beta)/((alpha+beta)^2*(alpha+beta+1))
  return(params = list(med = med, var = var))
}
## Adaptação codigo exercicio 4

priori.posterioriBeta <- function(prioriParams, posterioriParams){
  
  theta<-seq(0,1,0.0005)
  
  y.priori<-dbeta(theta,shape1=prioriParams[[1]],shape2=prioriParams[[2]])
  y.post<-dbeta(theta,shape1=posterioriParams[[1]],shape2=posterioriParams[[2]])
  
  med.post <- inverseBetaParams(posterioriParams[[1]], posterioriParams[[2]])[[1]]
  med.prio <- inverseBetaParams(prioriParams[[1]], prioriParams[[2]])[[1]]
  plot(theta,y.post,type="l",col="red",xlab=expression(theta),
       ylab="y",lwd=2,main="Priori (blue) vs Posteriori (red)")
  lines(theta,y.priori,col="blue",lwd=2)
  abline(v=med.prio,lty=1)
  abline(v=med.post,lty=3)
}
## Adaptação codigo exercicio 4

########################## Exercicio 4 ##########################

## Alinea (a)
ex4.prio <- estBetaParams(0.6, 0.3^2)

## Alinea (b)
ex4.post <- list(ex4.prio[[1]]+650, ex4.prio[[2]]+350)

priori.posterioriBeta(ex4.prio, ex4.post) 

######################### Exercicio 5 ######################
ex5.theta <- seq(0,1,0.0001)
## Alinea (a)

ex5.prio <- estBetaParams(0.4, 0.02)

ex5.priori.05 <- 1-pbeta(0.5, ex5.prio[[1]],ex5.prio[[2]], lower.tail = T) ## P(theta) > 0.5

# Confirmação gráfica

ex5.priori.py <- pbeta(ex5.theta, ex5.prio[[1]],ex5.prio[[2]])
plot(ex5.theta, ex5.priori.py)
abline(v=0.5, h=1-ex5.priori.05, col="red")


ex5.priori.y <- dbeta(ex5.theta, ex5.prio[[1]],ex5.prio[[2]])
plot(ex5.theta, ex5.priori.y)
text(0.8,2, paste0("P(theta) > 0.5 = ", round(ex5.priori.05,3)))


## Alinea (b)
ex5.post <- list(ex5.prio[[1]]+38, ex5.prio[[2]]+70)

ex5.post.medidas <- inverseBetaParams(ex5.post[[1]],ex5.post[[2]])

# Gráfico
ex5.posteriori.y <- dbeta(ex5.theta, ex5.post[[1]],ex5.post[[2]])
plot(ex5.theta, ex5.posteriori.y)
text(0.65,7, paste0("Média = ", round(ex5.post.medidas[[1]],3), "\nVariância = ", round(ex5.post.medidas[[2]],5)))


## Alinea (c)
ex5.posteriori.05 <- 1-pbeta(0.5, ex5.post[[1]],ex5.post[[2]], lower.tail = T) ## P(theta) > 0.5

# Confirmação gráfica
ex5.posteriori.py <- pbeta(ex5.theta, ex5.post[[1]],ex5.post[[2]])
plot(ex5.theta, ex5.posteriori.py)
abline(v=0.5, h=1-ex5.posteriori.05, col="red")

# Gráfico
priori.posterioriBeta(ex5.prio, ex5.post)

