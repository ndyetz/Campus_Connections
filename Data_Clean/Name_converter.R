#
#
#       This code is meant to format Names from the format of "Last, First Middle" to "First L." in order to match the records appropriately and deidentify individuals.
#             It is created to do the same thing for mentees, but converts from "Last First" to "First L."
#             This was created on 05/18/2018 By Neil Yetz. Please email Neil at neil.yetz@colostate.edu with any questions.
#       AT the end it is meant to create a series of SAS, "IF THEN" statements so we may convert the names for our formatting and deidentifying purposes. 
#
#

rm(list=ls(all=TRUE))


library(tidyverse)
library(stringr)


ID        <- read_csv("T:/Research folders/CCWTG/Data/Fall2017/FINALDATA/tempdelete.csv")
obsdyads  <- read_csv("T:/Research folders/CCWTG/Data/Fall2017/FINALDATA/OTHER_FILES/F17_obsdyads.csv")

ID <- ID %>% 
  arrange(mentor_name)

mentors <- ID %>% 
  filter(mentor_name != "") %>% 
  arrange(mentor_name) %>% 
  select(Final_ID, mentor_name)



#separate first last middle -mentors
ID2 <- str_split_fixed(ID$mentor_name, " ", 3)
ID2 <- as_data_frame(ID2)


#name columns
colnames <- c("last", "first", "middle")
names(ID2) [1:3]<- colnames


#filter to mentors
ID2 <- ID2 %>% 
  filter(last != "")

#combine Final_ID
ID2 <- cbind(mentors, ID2)

#remove comma from last name
ID2$last <- str_replace(ID2$last, ",", "")

#Grab only first letter from first name
ID2$last <- substring(ID2$last, 1, 1)

#Add period to first
ID2$last <- paste0(ID2$last, ".")

#combine last, and first initial add quotes
ID2$name <- paste(ID2$first, ID2$last)

ID2$name <- paste0("\"",ID2$name,"\"")
ID2$mentor <- paste0("\"",ID2$mentor,"\"")



#select only necessary Variables
ID_final <- ID2 %>% 
  select(Final_ID, mentor_name, name)

#Now create SAS code "IF obsdyad_name = "wrong" THEN obsdyad_name = "right"
SAS_code_m <- paste("IF mentor_name =", ID_final$name, "THEN mentor_name2 =", ID_final$mentor_name, ";")

SAS_code_m <- as_data_frame(SAS_code_m)

write_csv(SAS_code_m, "T:/Research folders/CCWTG/Data/Fall2017/FINALDATA/OTHER_FILES/SAS_namechange_mentor.csv")



###########Same process but for mentees



ID        <- read_csv("T:/Research folders/CCWTG/Data/Fall2017/FINALDATA/tempdelete.csv")
obsdyads  <- read_csv("T:/Research folders/CCWTG/Data/Fall2017/FINALDATA/OTHER_FILES/F17_obsdyads.csv")

ID <- ID %>% 
  arrange(mentee_name)

mentees <- ID %>% 
  filter(mentee_name != "") %>% 
  arrange(mentee_name) %>% 
  select(Final_ID, mentee_name)



#separate first last middle -mentors
ID2 <- str_split_fixed(ID$mentee_name, ",", 2)
ID2 <- as_data_frame(ID2)


#name columns
colnames <- c("last", "first")
names(ID2) [1:2]<- colnames

#filter to mentors
ID2 <- ID2 %>% 
  filter(last != "")

#combine Final_ID
ID2 <- cbind(mentees, ID2)

#remove comma from last name
#ID2$last <- str_replace(ID2$last, ",", "")

#Grab only first letter from first name
ID2$last <- substring(ID2$last, 1, 1)

#Add period to first
ID2$last <- paste0(ID2$last, ".")

#combine last, and first initial add quotes
ID2$name <- paste(ID2$first, ID2$last)
ID2$name <- trimws(ID2$name) #removes leading white space

ID2$name <- paste0("\"",ID2$name,"\"")
ID2$mentee_name <- paste0("\"",ID2$mentee_name,"\"")


#select only necessary Variables
ID_final <- ID2 %>% 
  select(Final_ID, mentee_name, name)

#Now create SAS code "IF obsdyad_name = "wrong" THEN obsdyad_name = "right"
SAS_code_y <- paste("IF mentee_name =", ID_final$name, "THEN mentee_name2 =", ID_final$mentee_name, ";")

SAS_code_y <- as_data_frame(SAS_code_y)

write_csv(SAS_code_y, "T:/Research folders/CCWTG/Data/Fall2017/FINALDATA/OTHER_FILES/SAS_namechange_youth.csv")




