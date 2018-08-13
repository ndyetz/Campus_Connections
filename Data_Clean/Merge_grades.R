#This file is set up to bind all the transcipt data together fro Campus Connections.
#This file was created on 08/13/2018 by Neil Yetz. Please email me at ndyetz@gmail.com for any questions or concerns.

#Use bind_rows() from dplyr... it's better than rbind()!

#Load Libraries
library(tidyverse)

#Load in grades files
F15 <- read_csv("F15_grades.csv")
S16 <- read_csv("S16_grades.csv")
F16 <- read_csv("F16_grades.csv")
#S17 <- read_csv("S17_grades.csv")
#F17 <- read_csv("F17_grades.csv")
#S18 <- read_csv("S18_grades.csv")

#Bind rows
grades_final <- bind_rows(F15, 
                          S16, 
                          F16) #, S17, F17, S18)

#write csv
write_csv(grades_final, "T:/Research folders/CCWTG/RECORDS/Grades_Final/grades_final.csv", na = "")