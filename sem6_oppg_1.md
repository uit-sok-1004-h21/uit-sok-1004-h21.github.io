

# Plotte nivåkurver til Cobb-Douglas produktfunksjon med produksjonsfaktorer 
# arbeidskraft (L) og kapital (K)
# y=A*L^b*K^(1-b)

#bruk mosaic
library(mosaic)



# Plot nivåkurver for A=5, b=0.5

plotFun(A * (L ^ 0.5) * (K ^ 0.5) ~ L & K,
        A = 5, filled=FALSE,
        xlim = range(0, 20),
        ylim = range(0, 20), 
        xlab=list("arbeidskraft", cex=1.5), ylab=list("kapital", cex=1.5), main=list("Nivåkurver Cobb-Douglas", cex=2))
  
  # plot isokostnadskurver med w=2, r=1.
# Disse kurvene har likning K=k/r-(w/r)L. 
# I dette tilfellet K=k-2L
# Sett k= 19,8 (rød) og bruk ladd kommando med a=k og b=-2 (dvs -w/r)

ladd(panel.abline(a=19.8, b=-2, col="red"))  
