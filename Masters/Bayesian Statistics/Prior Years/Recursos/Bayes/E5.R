# ===================================================================
# EXERC 5
# ===================================================================
# Hiperparametros 

a.priori<-4.4; b.priori<-6.6

# Calculating the probability of ?? being above 50%
pbeta(0.5,shape1 = a.post, shape2 = b.post, lower.tail = FALSE) # The probability above 50% for a priori

# ============================================================
# (b) média e a a variância da distribuição a posteriori de theta
# que é uma Beta(38.4,42.6)
# ============================================================

a.post<-34+a.priori
b.post<-36+b.priori
(med.post<-a.post/(a.post+b.post))
(var.post<-(a.post*b.post)/((a.post+b.post)^2*(a.post+b.post+1)))
(sqrt(var.post))

# ============================================================
# (c) representação gráfica das distrib
# a priori e a posteriori
# ===========================================================

pbeta(0.5,shape1 = a.post, shape2 = b.post, lower.tail = FALSE) # The probability above 50% for a posteriori

# Grelha de valores de theta
theta<-seq(0.0001,0.9999,0.01)

# Considering a vague Beta prior - Beta(1,1) = Uuni[0,1]
apost2<-35; bpost2<-37

y.priori<-dbeta(theta,shape1=a.priori,shape2=b.priori)
y.post<-dbeta(theta,shape1=a.post,shape2=b.post)
y.post2<-dbeta(theta,shape1=apost2,shape2=bpost2)

plot(theta,y.post,type="l",col="red",xlab=expression(theta),
     ylab="y",lwd=2,main="Sobreviv???ncia")

lines(theta,y.post2,col="blue",lwd=2)
lines(theta,y.priori,col="green4",lwd=2)
abline(h=1,col="orange",lwd=2)

legend("topright",
       c("Beta(38.4,42.6)","Beta(35,37)","a priori Beta(4.4,6.6)","a priori Beta(1,1)"),
       ncol=1,col=c("red","blue","green","orange"),
       lty=1,cex=0.7)

(phat<-34/70)  # classical estimate of the prob
# of survival
