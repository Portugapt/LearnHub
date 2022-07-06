#2
#a
#i
pnorm(24, mean = 22.38, sd = sqrt(.83), lower.tail = FALSE)

#ii
library(bayestestR)
posterior <- rnorm(30, mean = 22.38, sd = sqrt(.83))
ci(posterior, method = "ETI", ci = .95)

#iv
pnorm(25, mean = 22.38, sd = sqrt(25.83), lower.tail = FALSE)
