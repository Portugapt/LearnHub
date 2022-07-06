# ====================================================================
# Exercício 14
# =========================================================================
rm(list = ls())

# =========================================================================
# Distrib a priori - theta ~ N(12,6^2)
#z1<-qnorm(0.25, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
#z2<-qnorm(0.91, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)

b<-12; d<-6; c<-1/d^2

# =========================================================================
# (b) Indique a densidade a posteriori de theta
# =========================================================================
dados<-c(15,26,10,9,15,20,18,11,8,20,7,9,10,11,11,10,12,42,17,11,10)
n<-length(dados); xbarra<-mean(dados); 
sigma2<-63; tau<-1/sigma2

# Distrib a posteriori N(14.2,1.664^2)
print(mu_post<-(n*tau*xbarra+c*b)/(c+n*tau))
(var_post<-1/(c+n*tau))
(sd<-sqrt(var_post))

# =========================================================================
# c) Representação gráfica
# =========================================================================
theta<-seq(0.0001,35,0.1)
y_post<-dnorm(theta,mean=mu_post,sd=sqrt(var_post))
y_priori<-dnorm(theta,mean=b,sd=d)
plot(theta,y_post,type="l",col="blue",xlab=expression(theta),ylab="")
lines(theta,y_priori,col="red")
text<-c("a Posteriori","a Priori")       
legend("topright",text,col=c("blue","red"),lty=1, ncol=1,cex=1.1)

# =========================================================================
# d) P(theta a post > 18 meses)
# =========================================================================
x<-c(12,18,24)
round(pnorm(x,mean=mu_post,sd=sqrt(var_post),lower.tail=F),9)

# =========================================================================
# e) P(theta a post > 18 meses)
# repetir usando uma distribuição a priori vaga, por exemplo, 
# uma N(b,d^2), sendo b = 0.0 e d^2 grande(precisão mto pequena)

# =========================================================================
# Nas condições da alínea (a), e considerando que vai observar mais 
# m = 10 crianças, qual é a distribuição preditiva para a idade 
# média na qual as crianças vão falar pela primeira vez?
# =========================================================================
m<-10
(med_pred<-mu_post)
var_pred<-var_post+sigma2/m
(sqrt(var_pred))
# A posteriori é uma normal(med_pred, var_pred)

y<-seq(0,30,1)
y1<-dnorm(y,med_pred,sqrt(var_pred))   
plot(y,y1,type="l",xlab="y",ylab="f(y|x)",main="Distribuição Preditiva")
# =========================================================================


# =========================================================================