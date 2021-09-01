---
layout: default
---
{% include navbar_open.html %}

# Ressurser forelesning 4

Pensumbok: [Campbell](https://uit.instructure.com/files/1421071/download?download_frd=1){:target='_blank_'} Chap 7, 8 & 11, 12

Ønsker du å se alle mulighetene med å kombinere R og Markdown, sjekk ut boka: [R Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/){:target='_blank_'}

## Tidy data og det å kombinere flere datakilder

På nettsiden [Global Warming](https://www.drroyspencer.com/latest-global-temperatures/) gir Roy Spencer oss tilgang på temperaturdata målt fra satelitt. Nederst på forsiden finner du data fra fire nivåer i atmosfæren; "Lower-Troposphere", "Mid-Troposphere", "Tropopause" og "Lower-Stratosphere".

Målet vårt er å vise temperaturen globalt (kolonne 3: "Global") fra disse fire kildene i samme figur, samt at vi beregner gjennomsnittet av disse fire målingene per måned. Vi kan kanskje også driste oss til å beregne et glidende gjennomsnitt, slik som i figuren på nettsiden.

Tips: Når du "sjekker" hvordan dataene ser ut, se spesielt på slutten av hver fil, ikke alt er "data". Vi må dermed rydde i fila før vi går videre. 
