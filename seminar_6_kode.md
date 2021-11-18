# Seminar 6 oppgave 1
# Se på konsumentens tilpasning 

# Plotte indifferenskurver til en konsument med Cobb-Douglas nyttefunksjon
# som uttrykker preferanser mellom fritid (t) og konsum (k) 
# 
# U=A*t^b*k^(1-b)

#bruk mosaic
library(mosaic)



# Plot indifferenskurver for A=1, b=0.5

plotFun(A*t^0.5*k^(0.5) ~ t & k,
        A = 1, filled=FALSE, labels=FALSE,
        levels=c(12,17,20.8),
        xlim = range(0, 24),
        ylim = range(0, 100), 
        xlab=list("fritid (t)", cex=1.5), ylab=list("konsum (k)", cex=1.5), 
        main=list("Valget mellom konsum og fritid", cex=2))

# plott budsjettlinjen k=w(24-t) for w=2 (rød) og w=3 (blå)


ladd(panel.abline(a=48, b=-2, col="red")) 
ladd(panel.abline(a=72, b=-3, col="blue"))


ladd(panel.abline(v=12, col="green")) 

# Ferdig med oppgave 1

# Oppgave 2

# Plot indifferenskurver for A=1, b=1

plotFun((t*k) ~ t & k,
        filled=FALSE, labels=TRUE,
        levels=c(4624,5776),
        xlim = range(0, 24),
        ylim = range(0, 1000), 
        xlab=list("fritid (t)", cex=1.5), ylab=list("konsum (k)", cex=1.5), 
        main=list("Valget mellom konsum og fritid", cex=2))

# plott budsjettlinjen k=w(24-t)+I for w=16, I=160 (rød) og w=25, I=160 (blå)


ladd(panel.abline(a=544, b=-16, col="red")) 
ladd(panel.abline(v=17, col="red"))

ladd(panel.abline(a=760, b=-25, col="blue"))
ladd(panel.abline(v=15.2, col="blue"))

# plott budsjettlinjen k=w(24-t)+I for w=16, I=224 (grønn)

ladd(panel.abline(a=608, b=-16, col="green"))

ladd(panel.abline(v=19, col="green"))

# Følgende kan være nyttig i løsning av oppgave 2

# løs likningen (12+(x/32))*(192+(x/2))=5776

findZeros((12+(x/32))*(192+(x/2))-5776 ~ x, 
          x.lim = range(0,300))
