# ================================================================================
# Exercício 7 
# ================================================================================
# ==========   alínea (a)
# ================================================================================
rm(list = ls())
theta<-seq(0,4,0.01)  # grelha de valores de theta
n1<-111; n2<- 44      # dim das amostras
a1<-219; b1<-112      # post grupo 1 - Gama(a1,b1)
a2<-68; b2<-45        # post grupo 2 - Gama(a2,b2)

post_1<-dgamma(theta,shape=a1,rate=b1)
post_2<-dgamma(theta,shape=a2,rate=b2)

plot(theta,post_1,type="l",col="red",
xlab=expression(theta),
ylab=expression(paste("p(",theta,"|x",")")))

lines(theta,post_2,lty=2,col="blue")
lines(theta,dgamma(theta,2,1),col="brown",lty=3)
abline(h=0,lty=3)
cor<-c("red","blue","brown")
legend("topright",
legend=c("Gama(219,112)- post 1","Gama(68,45) - post 2 ","Gama(2,1) - a priori"), 
ncol = 1, cex = 0.7,lwd=1,lty=1:3,col=cor)

# ================================================================================
# ==========   alínea (b)
# ================================================================================
media_1<-a1/b1
moda_1<-(a1-1)/b1

media_2<-a2/b2
moda_2<-(a2-1)/b2

?optimize

paste("media post 1= ",round(media_1,4))
paste("moda post 1= ",round(moda_1,4))
paste("media post 2 = ",round(media_2,4))
paste("moda post 2= ",round(moda_2,4))
# ================================================================================
# ==========   alínea (c)
# ================================================================================
p<-0.025
q1<-qgamma(p,shape=a1,rate=b1,lower.tail = T)
q2<-qgamma(p,shape=a1,rate=b1,lower.tail = F)
print(c(q1,q2),digits=7)
abline(v=q1,col="magenta",lty=1,lwd=2)
abline(v=q2,col="magenta",lty=1,lwd=2)
q2-q1

q3<-qgamma(p,shape=a2,rate=b2,lower.tail = T)
q4<-qgamma(p,shape=a2,rate=b2,lower.tail = F)
print(c(q3,q4),digits=7)
abline(v=q3,col="black",lty=1,lwd=2)
abline(v=q4,col="black",lty=1,lwd=2)
q4-q3
# ================================================================================













