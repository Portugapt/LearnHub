
# ===================================================================
# Exercício 9
# ===================================================================
theta<-seq(0,1,0.001)
a<-0.04; b<-0.2
n<-20; media=3.8
priori<-dgamma(theta,shape=a,rate=b)
print(shape_post<-a+n)
print(scale_post<-b+n*media)

(media_post<-shape_post/scale_post)
(var_post<-shape_post/scale_post^2)

posteriori<-dgamma(theta,shape=shape_post,rate=scale_post)

plot(theta,priori,type="l",ylim=c(0,10),main="Exercício 10",
xlab=expression(theta),ylab="Densidade")
lines(theta,posteriori,col="red",lty=2)
abline(h=0,lty=3)
text<-c("a prior","a posteriori")       
legend("topright",text,col=c("black","red"),lty=1:2,ncol=2,cex=0.9)
# ===================================================================


