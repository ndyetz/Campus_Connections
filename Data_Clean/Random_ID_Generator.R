#This program was created by Neil Yetz on 08/15/2018.
#This randomly generates up to 999 randomly generated numbers to create random ID's for CC Mentors.
#Finally, it formats the ID's for our purposes, (e.g., "F18_000")


#Clear Environment
rm(list = ls(all.names = TRUE))

#Load Library
library(tidyverse)
library(readxl)
library(stringr)

#Read staff list
#staff_list <- read_excel()

#rename Name variable to "name"
staff_list <- staff_list %>% 
  select(name = "Preferred Name in Aries (Last, First)", everything()) %>% 
  arrange(name)

#Set Seed (Fill in random number)
set.seed()

#Create digits
random <- round(runif(999, min = 1, max = 999))

#Pad 0's
random <- str_pad(random, 3, side = c("left"), pad = 0)

#Grab only unique #'s
uniq <- as_data_frame(unique(random))

#Grab a random sample
uniq <- sample_n(uniq, nrow(staff_list))



#Bind random ID's, rename & create Mentor_ID's
staff_list <- uniq %>% 
  bind_cols(staff_list) %>% 
  select("Mentor_ID" = value, everything()) %>% 
  mutate(Mentor_ID = paste0("F18_", Mentor_ID)) %>% # <- Change paste to match semester.
  arrange(Mentor_ID)

#Clean up
rm(uniq); rm(random)


#Write new staff_list
#write_csv(staff_list, , na = "")

