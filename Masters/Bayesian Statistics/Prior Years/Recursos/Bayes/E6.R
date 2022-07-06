# =====================================================================
# EXERC 6
# =====================================================================
# a = 4; b = 2; sum observ = 18; n = 6 
alfa<-22; beta<-8  # parameters of the posterior distribution (Gamma)

4/2     # prior mean
4/2^2   # prior variance

22/8    # posterior mean
22/8^2  # posterior variance

qinf<-qgamma(p=0.025,shape=alfa,rate=beta,lower.tail=TRUE)
qsup<-qgamma(p=0.025,shape=alfa,rate=beta,lower.tail=FALSE)
qinf
qsup

qsup2<-qgamma(p=0.975,shape=alfa,rate=beta,lower.tail=T) # alternativa
qsup2
  # =====================================================================

