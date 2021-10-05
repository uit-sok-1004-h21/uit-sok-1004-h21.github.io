# tegn en enkel produktfunksjon med pakken mosaic
# x er enheter arbeidskraft, y er produserte enheter.

library(mosaic)
# plot y=2*x^.5, blå kurve
plotFun((A*(x ** .5)) ~ x, x.lim = range(0,10), A=2,
        xlab=list(label="Arbeidskraft", cex=1.2),
        ylab=list(label="Produksjon", cex=1.2), ylim=c(0,15), col="blue")
# anta teknologisk fremgang som øker A til 4
  #plot y=4*x^.5, rød kurve

plotFun((A*(x ** .5)) ~ x, x.lim = range(0,10), A=2,
        xlab=list(label="Arbeidskraft", cex=1.2),
        ylab=list(label="Produksjon", cex=1.2), ylim=c(0,15), col="blue") +

plotFun((B*(x **.5) ) ~ x, x.lim = range(0,10), B=4, xlab=list(label="Arbeidskraft", cex=1.2),
        ylab=list(label="Produksjon", cex=1.2), ylim=c(0,15), col="red")
  
  # hvor mange enheter arbeidskraft trenges for å produsere 5 enheter produkt?
  #grafisk fremstilling først

plotFun((A*(x ** .5)) ~ x, x.lim = range(0,10), A=2,
        xlab=list(label="Arbeidskraft", cex=1.2),
        ylab=list(label="Produksjon", cex=1.2), ylim=c(0,15), col="blue") +
  
  plotFun((B*(x **.5) ) ~ x, x.lim = range(0,10), B=4, xlab=list(label="Arbeidskraft", cex=1.2),
          ylab=list(label="Produksjon", cex=1.2), ylim=c(0,15), col="red")

  ladd(panel.abline(h=5, col = "black"))
  
  
  ladd(panel.abline(v=findZeros((A*(x ** .5)) -5 ~ x, 
                                x.lim = range(0,10), A=2)$x, col = "blue"))
  ladd(panel.abline(v=findZeros((B*(x **.5) ) -5 ~ x, 
                                  x.lim = range(0,10), B=4)$x, col="red"))

# løs likningen 2*x^.5=5

findZeros((A*(x ** .5)) -5 ~ x, 
          x.lim = range(0,10), A=2)

# løs likningen 4*x^.5=5

findZeros((B*(x ** .5)) -5 ~ x, 
          x.lim = range(0,10), B=4)





