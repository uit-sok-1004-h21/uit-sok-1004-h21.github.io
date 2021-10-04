# Plotte nivåkurver til Cobb-Douglas produktfunksjon med produksjonsfaktorer 
# arbeidskraft (L) og kapital (K)
# y=A*L^b*K^(1-b)

#bruk mosaic og manipulate 
library(mosaic)



# Plot nivåkurver for A=5, b=0.5

plotFun(A * (L ^ 0.5) * (K ^ 0.5) ~ L & K,
        A = 5, filled=FALSE,
        xlim = range(0, 20),
        ylim = range(0, 20), 
        xlab="arbeidskraft", ylab="kapital", main="Nivåkurver Cobb-Douglas")







