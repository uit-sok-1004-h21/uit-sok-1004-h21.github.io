# slette environment
rm(list=ls())

# dette er en kommentar
# husk cheatsheets på rstudio.com

# kan starte nettleser fra RStudio
#browseURL("https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions")

# lese CO2 data fra csv
library(readr)
co2data <- read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# se på data i konsoll
co2data

# husk å sjekk kodeboka, hva er det variablene måler?

# lese data fra xlsx
# library(readxl)
# url <- "https://github.com/owid/co2-data/raw/master/owid-co2-data.xlsx"
# destfile <- "owid_co2_data.xlsx"
# curl::curl_download(url, destfile)
# co2data2 <- read_excel(destfile)

# $ velger en kolonne (variabel) i dataene
unique(co2data$country)

# hvor mange country kategorier er det?
length(unique(co2data$country))

# nå kan vi benytte "piping" %>% 
library(tidyverse)

# samme som unique() over, men i tidyverse
co2data %>% select(country) %>% distinct()

# samme som length over, men i tidyverse
co2data %>% select(country) %>% n_distinct()

# pivotabell på land, n() gir antall observasjoner
co2data %>%
  group_by(country) %>% 
  summarise(n())

# lagrer som land data, og kaller antall obsevasjoner n
land <-
  co2data %>%
  group_by(country) %>% 
  summarise(n=n())

# sorterer på antall observasjoner
land %>% arrange(n)

# lager et plot av Norge
co2data %>%
  filter(country =="Norway") %>% 
  ggplot(aes(x=year, y=co2)) + geom_line()

# mutate: fra co2 målt i millioner av tonn til tonn ( x 1000000 eller 1e6)
co2data %>%
  mutate(co2_tonn=1e6*co2) %>% 
  filter(country =="Norway") %>% 
  ggplot(aes(x=year, y=co2_tonn)) + geom_line()
# merk hvordan aksen endrer seg, millioner tonn er bedre

# lager et plot av Norge og Sverige
co2data %>%
  filter(country %in% c("Norway", "Sweden")) %>% 
  ggplot(aes(x=year, y=co2, color=country)) + geom_line()

# Oppgave: co2, lag et plot av Norge og Kina
co2data %>%
  filter(country %in% c("Norway", "China")) %>% 
  ggplot(aes(x=year, y=co2, color=country)) + geom_line()
# dette funker ikke

# Oppgave: co2_per_capita, lag et plot av Norge og Kina per capita
co2data %>%
  filter(country %in% c("Norway", "China")) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line() 
  
# Legg til ny farge, tittel og lag nye labler på aksen + theme
co2data %>%
  filter(country %in% c("Norway", "China")) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line() +
  scale_color_manual(values=c("#56B4E9", "#E69F00")) +
  theme_bw() + 
  ggtitle("CO2 utslipp per år") + 
  xlab("År") +
  ylab("Tonn per capita")
  
# + Matematisk notasjon og tykkere linjer
co2data %>%
  filter(country %in% c("Norway", "China")) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line(lwd=2) +
  scale_color_manual(values=c("#56B4E9", "#E69F00")) +
  theme_bw() + 
  ggtitle(expression(CO[2]~utslipp~per~år)) + 
  xlab("År") +
  ylab("Tonn per capita")

# + endre fra engelsk til norsk variabler
# og gir variabel nytt navn og rekoder
co2data %>%
  rename(land=country) %>% 
  mutate(land=recode(land,
                     'Norway'="Norge",
                     'China'="Kina")) %>% 
  filter(land %in% c("Norge", "Kina")) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=land)) + geom_line(lwd=2) +
  scale_color_manual(values=c("#56B4E9", "#E69F00")) +
  theme_bw() + 
  ggtitle(expression(CO[2]~utslipp~per~år)) + 
  xlab("År") +
  ylab("Tonn per capita")

# vil finne totale globale utslipp (i milliarder tonn) - summarise
co2data %>%
  group_by(year) %>% 
  summarise(co2=sum(co2, na.rm = TRUE)) %>% 
  ggplot(aes(x=year, y=co2/1000)) + geom_line()


### ------ Part 2

# R er case sensitiv!

# installere R pakker (apps)

# sorterer på antall observasjoner
land %>% arrange(n) # stigende

land %>% arrange(-n) # synkende

# globale CO2 utslipp (milliarder tonn)
co2data %>%
  filter(country=="World") %>% 
  ggplot(aes(x=year, y=co2/1000)) + geom_line()

# lager et nytt datasett
world <-
  co2data %>%
  filter(country=="World") %>% 
  select(year, country, co2)

# halen av dataene
tail(world)

# størrelsen på datene
dim(world)

# lagrer størrelsen i N
N <- dim(world)

N[1]
N[2]

# velge kolonne
world %>% select(co2)
world[ , 3]
world[ , "co2"]

# velge rekke
world[1, ]
world[1:3, ]

# den siste verdien
world[N[1], "co2"]

# Hvor mange år for CO2 utslippene ble fordoblet?
y1900 <- world %>% filter(year==1900)

y1900$co2

world <- 
  world %>% 
  mutate(co2_1900=co2/y1900$co2)

y1927 <- world %>% filter(year==1927)

1927-1900

world <- 
  world %>% 
  mutate(co2_1927=co2/y1927$co2)

y1956 <- world %>% filter(year==1956)

1956-1927

world <- 
  world %>% 
  mutate(co2_1956=co2/y1956$co2)

y1972 <- world %>% filter(year==1972)

1972-1956

world <- 
  world %>% 
  mutate(co2_1972=co2/y1972$co2)

y2010 <- world %>% filter(year==2010)

2010-1972

world <- 
  world %>% 
  mutate(co2_2010=co2/y2010$co2)

# la oss lage en figur

co2data %>%
  filter(country=="World") %>% 
  ggplot(aes(x=year, y=co2/1000)) + geom_line() +
  theme_bw() +
  geom_vline(xintercept=1900, colour="blue") +
  geom_text(aes(x=1900, label="1900", y=10), colour="blue", angle=90, vjust = 1.2) +
  geom_vline(xintercept=1927, colour="darkblue") +
  geom_text(aes(x=1927, label="1927", y=15), colour="darkblue", angle=90, vjust = 1.2) +
  geom_vline(xintercept=1956, colour="purple") +
  geom_text(aes(x=1956, label="1956", y=20), colour="purple", angle=90, vjust = 1.2) +
  geom_vline(xintercept=1972, colour="black") +
  geom_text(aes(x=1972, label="1972", y=25), colour="black", angle=90, vjust = 1.2) +
  geom_vline(xintercept=2010, colour="red") +
  geom_text(aes(x=2010, label="2010", y=30), colour="red", angle=90, vjust = 1.2) +
  ggtitle(expression(Globale~CO[2]~utslipp~per~år)) + 
  xlab("År") +
  ylab("Milliarder tonn")


# Oppgave:
# hvor mange ganger større er utslippene av CO2 i 2019 sammenlignet med 1919?


# kompilere R skript

# Rmarkdown

# Rmarkdown cheatsheet

# lage markdownrapport med våre to figurer


