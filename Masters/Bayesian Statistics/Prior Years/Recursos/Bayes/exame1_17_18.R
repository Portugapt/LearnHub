#1
#b)
pnorm(3, 2.444, .633, lower.tail = FALSE)

#c)
library(bayestestR)
posterior <- rnorm(32, mean = 2.444, sd = .633)
hdi(posterior, ci=.95)

#2
#b
x <- seq(0.05,.4,0.0001)
plot(x, dgamma(x, 20.04, 76.2), ylab='density', type ="l", col=3)
#plot(x, dgamma(x, 0.04, 0.2), ylab="density", type ="l", col=3)
#lines(x, dgamma(x, 20.04, 76.2), type ="l", col=2)
lines(x, dgamma(x, 0.04, 0.2), ylab="density", type ="l", col=2)
legend(0.3, 2, c("Gamma(20.04, 76.2)","Gamma(.04, .2)"), lty=c(1,1,1), col=c(3,2,1))

#c
pgamma(.3, 20.04, 76.2)

#d
library(bayestestR)
posterior <- rgamma(20, 20.04, 76.2)
ci(posterior, method = "ETI", ci=.99)
