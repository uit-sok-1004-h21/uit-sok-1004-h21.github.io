rm(list = ls())

# setter arbeidkatalog
getwd()
setwd("~/undervisning/SOK1004/h2021")

# source:
#browseURL("https://www.drroyspencer.com/latest-global-temperatures/")

# lese data, husk å endre komma til mellomrom i GUI
library(tidyverse)

df_lower <- read_table2("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt")

head(df_lower)
tail(df_lower, 14)

# velge i data
# datanavn[ rekker, kolonner]

df_lower[ , 1]
df_lower[ , "Year"]

# subsetter, ver 1
# rekke 1 til 512 er det magiske intervallet vi er ute etter
df_lower <- df_lower[1:512 , ]

# prøver å gjøre koden dynamisk
# hva er spesielt med kolonne 1, "Year" der vi går til kommentarer?

which(df_lower$Year %in% "Year")

# nå er koden dynamisk, den gjelder for nye oppdaterte versjoner av dataene
df_lower <- df_lower[1:which(df_lower$Year %in% "Year")-1, ]

names(df_lower)

# vi vil ha variabelnavn uten store bokstaver
#install.packages("janitor")
library(janitor)

df_lower <- df_lower %>% clean_names()

# velger de tre første kolonnene
df_lower <- df_lower %>% select(year, mo, globe)

# lii mer data wrangling
library(lubridate)
library(zoo)

# for å lage datovariabel, trenger vi: år - mnd - dagtall
#paste(df_lower$year, df_lower$mo, 1, sep = "-")

df_lower <-
  df_lower %>% 
  mutate(dato = ymd(paste(year, mo, 1, sep = "-"))) %>% 
  mutate_if(is.character, ~as.numeric(.))

# lager glidende gjennomsnitt og rydder opp
df_lower <-
  df_lower %>% 
  select(dato, globe) %>% 
  mutate(glidende_snitt = rollmean(globe, 13, fill = NA, align = "center"))

# forsøker å etterligne figur på nettsiden
df_lower %>% 
  ggplot(aes(x=dato, y=globe)) + geom_line(col="lightblue") + theme_bw() +
  geom_point(shape=1, col="blue") +
  geom_line(aes(y=glidende_snitt), col="red", lwd=1.2)

# vi kunne lagt på "labler" og "tittel", men det er ikke fokus her

# her er essensen av koden vår
rm(list = ls())

df_lower <- read_table2("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt")
df_lower <- df_lower[1:which(df_lower$Year %in% "Year")-1, ]

df_lower <- df_lower %>% clean_names()
df_lower <- df_lower %>% select(year, mo, globe)

df_lower <-
  df_lower %>% 
  mutate(dato = ymd(paste(year, mo, 1, sep = "-"))) %>% 
  mutate_if(is.character, ~as.numeric(.))

# lager glidende gjennomsnitt og rydder opp
df_lower <-
  df_lower %>% 
  select(dato, globe) %>% 
  mutate(glidende_snitt = rollmean(globe, 13, fill = NA, align = "center"))

# se på prosedyren under ett
read_table2("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt") %>% 
  .[1:which(.$Year %in% "Year")-1, ] %>% 
  clean_names() %>% 
  .[ , 1:3] %>%  # velger kolonne 1 til 3
  mutate(dato = ymd(paste(.$year, .$mo, 1, sep = "-"))) %>% 
  mutate_if(is.character, ~as.numeric(.))

# fokus på å slå sammen data, lager en funksjon som leser og rydder data

scrape <- function(url) {
  return(read_table2(url) %>% 
           .[1:which(.$Year %in% "Year")-1, ] %>% 
           clean_names() %>% 
           .[ , 1:3] %>%  # velger kolonne 1 til 3
           mutate(dato = ymd(paste(.$year, .$mo, 1, sep = "-"))) %>% 
           mutate_if(is.character, ~as.numeric(.)))
}

#all_equal(df_lower, test)

rm(list = ls())
# Lower-Troposphere
df_lower <- scrape("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt")

df_lower <-
  df_lower %>% 
  select(dato, globe) %>% 
  rename(lowtropo=globe)

# Mid-Troposphere 
df_mid <- scrape("http://vortex.nsstc.uah.edu/data/msu/v6.0/tmt/uahncdc_mt_6.0.txt")

df_mid <-
  df_mid %>% 
  select(dato, globe) %>% 
  rename(midtropo=globe)

# Tropopause
df_tropo <- scrape("http://vortex.nsstc.uah.edu/data/msu/v6.0/ttp/uahncdc_tp_6.0.txt")

df_tropo <-
  df_tropo %>% 
  select(dato, globe) %>% 
  rename(tropo=globe)

# Stratosphere
df_strato <- scrape("http://vortex.nsstc.uah.edu/data/msu/v6.0/tls/uahncdc_ls_6.0.txt")

df_strato <-
  df_strato %>% 
  select(dato, globe) %>% 
  rename(strato=globe)

# alle dataene i ett datasett
dframe <- df_lower %>% left_join(df_mid) %>% left_join(df_tropo) %>% left_join(df_strato)

# merk at nå er datene i det vi kaller "wide" format
# ønsker å ha dataene i "long" format

# fra wide til long
dframe %>% 
  pivot_longer(-dato,
               names_to = "nivå",
               values_to = "temperatur")

# plot med alle fire nivå
dframe %>% 
  pivot_longer(-dato,
               names_to = "nivå",
               values_to = "temperatur") %>% 
  ggplot(aes(x=dato, y=temperatur, color=nivå)) + geom_line() + theme_bw()

# med gjennomsnitt
dframe %>% 
  mutate(snitt=rowMeans(.[ , -1])) %>% 
  pivot_longer(-dato,
               names_to = "nivå",
               values_to = "temperatur") %>% 
  ggplot(aes(x=dato, y=temperatur, color=nivå)) + geom_line() + theme_bw()


# med gjennomsnitt litt mer synlig
dframe %>% 
  mutate(snitt=rowMeans(.[ , -1])) %>% 
  pivot_longer(-dato,
               names_to = "nivå",
               values_to = "temperatur") %>% 
  ggplot(aes(x=dato, y=temperatur, color=nivå)) + geom_line(aes(size=nivå)) + theme_bw() +
  scale_size_manual(values = c(lowtropo = 0.5, midtropo = 0.5, snitt = 2, strato = 0.5, tropo = 0.5))


# begynne på nytt!
# i prosedyren over måtte vi rename og slå sammen og pivotere før vi var i mål
rm(list = ls())

scrape_bake <- function(url, location) {
  return(read_table2(url) %>% 
           .[1:which(.$Year %in% "Year")-1, ] %>% 
           clean_names() %>% 
           .[ , 1:3] %>%  # velger kolonne 1 til 3
           mutate(dato = ymd(paste(.$year, .$mo, 1, sep = "-"))) %>% 
           mutate_if(is.character, ~as.numeric(.)) %>% 
           mutate(nivå = paste0(location)))
}

# Lower-Troposphere
df1 <- scrape_bake("https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt","Lower-Troposphere")

# Mid-Troposphere 
df2 <- scrape_bake("http://vortex.nsstc.uah.edu/data/msu/v6.0/tmt/uahncdc_mt_6.0.txt", "Mid-Troposphere")

# Tropopause
df3 <- scrape_bake("http://vortex.nsstc.uah.edu/data/msu/v6.0/ttp/uahncdc_tp_6.0.txt","Tropopause")

# Stratosphere
df4 <- scrape_bake("http://vortex.nsstc.uah.edu/data/msu/v6.0/tls/uahncdc_ls_6.0.txt", "Stratosphere")

dframe <- bind_rows(df1, df2, df3, df4)

dframe <-
  dframe %>% 
  select(dato, globe, nivå)

# kan dette gjøres enda mer effektivt?
# tenk teg at du har flere hundre url'er!
# functional programming vha purrr

url_list <- list("http://vortex.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt",
                 "http://vortex.nsstc.uah.edu/data/msu/v6.0/tmt/uahncdc_mt_6.0.txt",
                 "http://vortex.nsstc.uah.edu/data/msu/v6.0/ttp/uahncdc_tp_6.0.txt",
                 "http://vortex.nsstc.uah.edu/data/msu/v6.0/tls/uahncdc_ls_6.0.txt")

location_list <- list("Lower Troposphere","Mid-Troposphere", "Tropopause", "Lower Stratosphere")

dframe2 <- map2(url_list, location_list, scrape_bake)

library(plyr)
# mer at denne appen maskerer dplyr sin rename funksjon

dframe2 <- ldply(dframe2, data.frame)

dframe2 %>% 
  select(dato, globe, nivå) %>% 
  dplyr::rename(temperatur = globe) %>% 
  as_tibble()


