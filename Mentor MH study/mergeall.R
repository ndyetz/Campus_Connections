rm(list=ls())

library(tidyverse)

F19 <- read_csv("R:/Post William T research/Mentor Mental Health Study/Data/Fall 2019/F19_Final.csv")
S20 <- read_csv("R:/Post William T research/Mentor Mental Health Study/Data/Spring 2020/S20_Final.csv")

final <- bind_rows(F19 , S20)

final <- final %>% 
  select(-m1hdfs, -m1teacher, -m1q44, -m1q44_6_text, -contains("scs"))


#write_csv(final, "R:/Post William T research/Mentor Mental Health Study/Data/MERGEALL/final.csv", na = "")
                   
                   