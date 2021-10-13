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
# Sett k= 19,8 (rød), 22,6 (blå) og 25,2 (grønn) og bruk ladd kommando med a=k og b=-2 (dvs -w/r)

ladd(panel.abline(a=19.8, b=-2, col="red"))  

ladd(panel.abline(a=22.6, b=-2, col="blue"))

ladd(panel.abline(a=25.2, b=-2, col="green"))


  # prøv å finne kostmin for 20 enheter.
  # Man kan finne at min kost er 11,31

ladd(panel.abline(a=11.31, b=-2, col="darkred"))
  
  
  
  # Ved regning viser det seg at K=2*L er optimalt for disse faktorprisene
  # Legg på en stråle som begynner i a=0 og viser K=2*L (dvs b=2)
  
ladd(panel.abline(a=0, b=2, col="black"))

# hvis r økes til 3. Helning på isokostnadslinjen er nå -2/3
  
plotFun(A * (L ^ 0.5) * (K ^ 0.5) ~ L & K,
        A = 5, filled=FALSE,
        xlim = range(0, 20),
        ylim = range(0, 20), 
        xlab="arbeidskraft", ylab="kapital", main="Nivåkurver Cobb-Douglas")



ladd(panel.abline(a=13.05, b=-2/3, col="red"))  

ladd(panel.abline(a=6.5, b=-2/3, col="blue"))  

  
  # Nå er K=2/3*L optimal. Tegn denne strålen (a=0. b=2/3)

ladd(panel.abline(a=0, b=2/3, col="black"))  
  
  

  #sammenlikn med når r=1
  
  plotFun(A * (L ^ 0.5) * (K ^ 0.5) ~ L & K,
          A = 5, filled=FALSE,
          xlim = range(0, 20),
          ylim = range(0, 20), 
          xlab="arbeidskraft", ylab="kapital", main="Nivåkurver Cobb-Douglas")
  
  ladd(panel.abline(a=0, b=2/3, col="black"))
  ladd(panel.abline(a=0, b=2, col="red"))
    
    
  
  


