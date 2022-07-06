#1
#b)

x <- seq(0,1,0.0001)
y1 <- dbeta(x, shape1 = 0.5, shape2 = 0.5)
y2 <- dbeta(x, shape1 = 1, shape2 = 1)
y3 <- dbeta(x, shape1 = 2, shape2 = 2)
plot(x, y1, ylab = 'density', type = 'l', col = 3, ylim=c(0, 3))
lines(x, y2, type = 'l', col = 2)
lines(x, y3, type = 'l', col = 1)
legend(0, 2.5, c("Be(0.5,0.5)","Be(1,1)","Be(2,2)"), lty = c(1,1,1), col = c(3,2,1))

#c
var_b <- function(a,b){
  num <- a*b
  den1 <- (a+b)^2
  den2 <- (a+b+1)
  return(num/(den1*den2))
}

var_b(2,2)

quantile(y1, probs = c(.025,.5,.975))
quantile(y3, probs = c(.025,.5,.975))

#d
plot(x, dbeta(x, 0.5+13, 0.5+16-13), ylab="density", type ="l", col=3)
lines(x, dbeta(x, 1.0+13, 1.0+16-13), type ="l", col=2)
lines(x, dbeta(x, 2.0+13, 2.0+16-13), type ="l", col=1)
legend(0.3, 2, c("Be(13.5, 3.5)","Be(14.0, 4)","Be(15.0, 5.0)"), lty=c(1,1,1), col=c(3,2,1))

#e
pbeta(.6, shape1 = 14, shape2 = 4)

#f
pbeta(.6, shape1 = 1, shape2 = 1)
