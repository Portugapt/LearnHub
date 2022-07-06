# ===================================================================
# EXERC 4
# ===================================================================
# Hiperparametros 

a.priori<-1; b.priori<-2/3
(var.priori<-(a.priori*b.priori)/((a.priori+b.priori)^2*(a.priori+b.priori+1)))

# Grelha de valores de theta
theta<-seq(0,1,0.001)

y.priori<-dbeta(theta,shape1=a.priori,shape2=b.priori)

# Parametros da dist a posteriori
a.post<-650+a.priori
b.post<-350+b.priori
y.post<-dbeta(theta,shape1=a.post,shape2=b.post)
(med.post<-a.post/(a.post+b.post))
(var.post<-(a.post*b.post)/((a.post+b.post)^2*(a.post+b.post+1)))
(sqrt(var.post))

plot(theta,y.post,type="l",col="red",xlab=expression(theta),
     ylab="y",lwd=2,main="Pena de morte")
lines(theta,y.priori,col="blue",lwd=2)
abline(v=0.6,lty=1)
abline(v=med.post,lty=3)

win.graph()
plot(theta,y.priori,type="l",col="green2",xlab=expression(theta),
     ylab="y",lwd=2,main="Distrib a priori",ylim=c(0,7))
abline(h=0,lty=2)

# ===================================================================