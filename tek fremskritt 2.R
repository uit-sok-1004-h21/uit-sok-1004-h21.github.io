# tegn en enkel produktfunksjon med pakken mosaic
# x er enheter arbeidskraft, y er produserte enheter.

library(mosaic)
# plot y=2*x^.5, blå kurve
plotFun((2*(x ** a)) ~ x, x.lim = range(0,10), a=0.5,
        xlab=list(label="Arbeidskraft", cex=1.2),
        ylab=list(label="Produksjon", cex=1.2), ylim=c(0,15), col="blue")
  

# anta teknologisk fremgang som øker a til 0.8
  #plot y=2*x^.8, rød kurve

# plot y=2*x^.5, blå kurve
plotFun((2*(x ** a)) ~ x, x.lim = range(0,10), a=0.5,
        xlab=list(label="Arbeidskraft", cex=1.2),
        ylab=list(label="Produksjon", cex=1.2), ylim=c(0,15), col="blue") +


  plotFun((2*(x **b) ) ~ x, x.lim = range(0,10), b=.8, col="red")#+ 

# hvor mange enheter arbeidskraft trenges for å produsere 5 enheter produkt?
#grafisk fremstilling først
ladd(panel.abline(h=5, col = "black"))
  ladd(panel.abline(v=findZeros((2*(x ** a)) -5 ~ x, 
                                x.lim = range(0,10), a=.5)$x, col = "blue"))
  ladd(panel.abline(v=findZeros((2*(x **b) ) -5 ~ x, 
                                x.lim = range(0,10), b=.8)$x, col="red"))

# løs likningen 2*x^.5=5

findZeros((2*(x ** a)) -5 ~ x, 
          x.lim = range(0,10), a=.5)

# løs likningen 2*x^.8=5

findZeros((2*(x ** b)) -5 ~ x, 
          x.lim = range(0,10), b=.8)
