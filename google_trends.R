rm(list=ls())

# laster nødvendige pakker
library(tidyverse)
library(gtrendsR)

# søker i google trends
search  <- gtrends(c("mathematica","jupyter"), gprop = "web", time = "all")
# trekker ut data
dframe <- search[[1]]
# ser på data
head(dframe)

# hvor mange observasjoner per keyword?
dframe %>% 
  group_by(keyword) %>% 
  summarise(n())

# strukturen til dataene
str(dframe)

# basic plot
dframe %>% 
  mutate(hits=as.numeric(hits)) %>% 
  ggplot(aes(x=date,y=hits, color=keyword)) + geom_line() +
  theme_bw()

# laster flere nødvendige pakker
library(ggthemes)
library(lubridate)

# mer avansert "The Economist" look
dframe %>% 
  mutate(hits=as.numeric(hits),
         year=year(date)) %>% 
  rename(søkeord=keyword) %>% 
  filter(year >= 2015) %>% 
  ggplot(aes(x=date,y=hits, color=søkeord)) + geom_line() +
  ggtitle("Google trends - søkeord over tid") +
  ylab("") +
  xlab("Dato") +
  theme_economist() + scale_colour_economist()


