#' Øvingsoppgaver
#' Bruk CO2 dataene fra forelesning 2

# lese CO2 data fra csv
library(tidyverse)
co2data <- read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

#' Oppgave 1
#' Lag et plot der "year" er på x-aksen, "co2_per_capita" er på y-aksen
#' for landene Norge, Sverige, Danmark, Finland og Island
#' Drøft dine funn.

names(co2data)

co2data %>% select(country) %>% distinct() %>% filter(str_detect(country, "S"))

co2data %>% 
  select(year, country, co2_per_capita) %>% 
  filter(country %in% c("Norway", "Sweden", "Denmark", "Finland", "Iceland")) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line()

co2data %>% 
  filter(country %in% c("Norway", "Sweden", "Denmark", "Finland", "Iceland")) %>% 
  select(year, country, co2_per_capita) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line()

#' Oppgave 2
#' Modifiser plottet i Oppgave 1 til bare å gjelde årene fra og med 1970.
#' Drøft dine funn.

co2data %>% 
  filter(country %in% c("Norway", "Sweden", "Denmark", "Finland", "Iceland")) %>% 
  select(year, country, co2_per_capita) %>% 
  filter(year >= 1970) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line()

#' Oppgave 3
#' Modifiser plottet i Oppgave 1 til bare å gjelde årene fra og med 1900 til og med 1950.
#' Drøft dine funn.

co2data %>% 
  filter(country %in% c("Norway", "Sweden", "Denmark", "Finland", "Iceland")) %>% 
  select(year, country, co2_per_capita) %>% 
  filter(year >= 1900, year <= 1950) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line()

co2data %>% 
  filter(country %in% c("Norway", "Sweden", "Denmark", "Finland", "Iceland")) %>% 
  select(year, country, co2_per_capita) %>% 
  filter(year %in% 1900:1950) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line()

co2data %>% 
  filter(country %in% c("Norway", "Sweden", "Denmark", "Finland", "Iceland")) %>% 
  select(year, country, co2_per_capita) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line() +
  xlim(1900,1950) +
  ylim(0,5)

co2data %>% 
  filter(country %in% c("Norway", "Sweden")) %>% 
  select(year, country, co2_per_capita) %>% 
  filter(year %in% 1900:1950) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line()

co2data$year

#' Oppgave 4
#' Lag et plot der "year" er på x-aksen, "co2_norden" er på y-aksen, men der "co2_norden" er sum av co2
#' for landene Norge, Sverige, Danmark, Finland og Island
#' Drøft dine funn.

co2data %>% 
  filter(country %in% c("Norway", "Sweden", "Denmark", "Finland", "Iceland")) %>% 
  select(year, country, co2) %>% 
  group_by(year) %>% 
  summarise(co2_norden=sum(co2, na.rm = TRUE)) %>% 
  ggplot(aes(x=year, y=co2_norden)) + geom_line()

norden <-
  co2data %>% 
  filter(country %in% c("Norway", "Sweden", "Denmark", "Finland", "Iceland")) %>% 
  select(year, country, co2) %>% 
  group_by(year) %>% 
  summarise(co2_norden=sum(co2, na.rm = TRUE))

plot1 <- norden %>% ggplot(aes(x=year, y=co2_norden)) + geom_line()
plot1 + geom_point()

#' Oppgave 5
#' I forhold til funnene i Oppgave 4, hvilket av de nordiske landene bidrar
#' mest til de nordiske utslippene av co2 etter 1980?
#' Drøft dine funn.

co2data %>% 
  filter(country %in% c("Norway", "Sweden", "Denmark", "Finland", "Iceland")) %>% 
  select(year, country, co2) %>% 
  filter(year >= 1980) %>% 
  group_by(year) %>% 
  mutate(co2_norden = sum(co2, na.rm = TRUE),
         co2_andel = 100*co2/co2_norden) %>% 
  ggplot(aes(x=year, y=co2_andel, color=country)) + geom_line()

#' Ekstraoppgave: Beregn gjennomsnittlig co2 per capita for norden,
#' og sammenlign det med Tyskland i et plot


