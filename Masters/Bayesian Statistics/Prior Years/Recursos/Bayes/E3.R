# =======================================================================
# Exercicio 3 - Linces
# =======================================================================
x<-0:5
p<-choose(5,x)*(0.6^x)*(0.4^(5-x))  # P(X)

condicional<-function(x,y){  # P(Y|X)
  z<-ifelse(x<y,0,choose(x,y)*(0.3^y)*0.7^(x-y))
  return(z)}

denominador<-condicional(0,2)*p[1]+condicional(1,2)*p[2]+  # P(Y=2)
  condicional(2,2)*p[3]+condicional(3,2)*p[4]+
  condicional(4,2)*p[5]+condicional(5,2)*p[6]

# alternativa
denominador<-sum(condicional(2:5,2)*p[3:6])  # Does not make sense to add the sums of conditional(1,2) or conditional(0,2) because its impossible



dist.cond<-numeric()
i<-1
dist.cond[i]<-condicional(0,2)*p[i]
for (i in 2:6) dist.cond[i]<-(condicional(i-1,2)*p[i])/denominador

dist.cond[1:6]

# Verificaçao
sum(dist.cond)
# =======================================================================
