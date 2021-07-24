import random
import math
import scipy.integrate as integrate
import numpy as np

import scipy.stats as st

# https://www.statsmodels.org/stable/gettingstarted.html
# https://docs.scipy.org/doc/scipy/reference/stats.html


#set seed
random.seed(777)

## 1 - Sample
list_1_49 = list(range(1,50))
print(f'List: {list_1_49}')
print(f'Winning Numbers: {random.sample(list_1_49,6)}')

## 2 - define PDF

def new_pdf_f(x):
    return ((x/4) * math.exp((-x**2)/8))

print(f'X = 3, Y = {new_pdf_f(3)}')
print(f'new_pdf integrated = {integrate.quad(new_pdf_f, 0, np.inf)[0]}')

## 3 - Expected value & variance

class new_pdf(st.rv_continuous):
    def _pdf(self, x):
        return (x/4) * math.exp((-x**2)/8)

new_pdf_object = new_pdf(a = 0, b = np.inf)
print(f'Expected Value: {new_pdf_object.expect()}')
print(f'Variance: {new_pdf_object.var()}')

## 4 Standard Normal Distribution I
# Compute ϕ(3), that is, the value of the standard normal density at c=3.
normDist = st.norm()
print(normDist.pdf(3))

## 5 Compute P(|Z|≤1.64)

print(normDist.cdf(1.64) - normDist.cdf(-1.64))
