x <- seq(0, 3, 0.01)

theta1 <- dgamma(x, 219, 112)
theta2 <- dgamma(x, 68, 45)

plot(x,theta1,type="l",col="red",xlab=expression(theta),
     ylab="y",lwd=2,main="Theta1 (red) vs Theta2 (red)")
lines(x,theta2,col="blue",lwd=2)

library(bayestestR)

randT1 <- rgamma(10000, 219, 112)
randT2 <- rgamma(10000, 68, 45)

ci(randT1, ci = 0.95, method = 'HDI')
ci(randT2, ci = 0.95, method = 'HDI')
