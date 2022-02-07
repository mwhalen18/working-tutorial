# Date of analysis (2018-05-01)

library(magrittr)
library(dplyr)
library(tidyr)
library(MSBVAR)

set.seed(123) # Make my code reproducible!!

# Generate data from a multivariate normal dist
Dat = rmultnorm(1000, matrix(c(0,1),2,1), vmat=matrix(c(.2,.1,
                                                  0.1,.3),2,2))

#Assign labels - 2 groups of 4
Var1 = rep(c("a", "b", "c", "d"), each = 250)
Var2 = rep(c("x", "y", "z", "w"), time = 250)
Dat = cbind.data.frame(Var1, Var2, x = Dat[,1], y = Dat[,2])

#nest data by unique combinations of Var1 and Var2
nested_data = nest(
  data = group_by(Dat, Var1, Var2)
)

#Get correation between x and y
lapply(nested_data$data, FUN = function(x) {
  cor(x$y,x$x)
})



