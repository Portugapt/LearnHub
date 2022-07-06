# ===========================================================================
# Exercise 15
# ===========================================================================
# Simulate a sample of size n from the preditive distribution
# ===========================================================================

# Parameters of the Predictive distribution
mu_pred<-68.074
var_pred<-101.988

n<-500
m<-1/sqrt(2*pi*var_pred)

amostra<-rnorm(n,mean=mu_pred,sd=sqrt(var_pred))
summary(amostra)
hist(amostra,main="Distribuição Preditiva",
prob=T,col="lightblue",ylim=c(0,m+0.005))
box()
curve(dnorm(x,mean=mu_pred,sd=sqrt(var_pred)),col="darkblue",lwd=2,add=TRUE)
# ===========================================================================
