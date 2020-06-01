#This file was created by Neil Yetz on 05.12.2020. 
#You may email Neil at ndyetz@gmail.com

#Clear environment
rm(list = ls())

#Libraries
library(tidyverse)
library(psych)
library(stringr)

################################################################################################################################################
############################################################################CONTROL#############################################################
############################################################################CONTROL#############################################################
################################################################################################################################################


#############################################################################################################################################
##################################################################################Pre########################################################
#############################################################################################################################################
#Read in data
cpre <- read_csv("control_pre.csv")

#Lowercase variables
names(cpre) <- tolower(names(cpre))

cpre <- select(cpre, -gratitude_6, gratitude_6 = "gratitude_7") #There was an error in the survey. Fixing here. (Pre survey only: One of the questions got split into 2, I am combining it here)

#Get names
names_cpre <- names(cpre)
names_cpre

#Get only non-cc participators & Those with ID numbers
cpre <- cpre %>% 
  filter(cc_part == 0, # Never particpated in CC
         !is.na(id1)   # Has ID#
         ) %>% 
  select(-id2)        #ID2 gave problems, people had trouble inputting their 6th digit of their id. Remember this for next semester

#Fix ID1 var
cpre <- cpre %>% 
  mutate(id1 = as.character(id1),                                      # Convert to character
         id1 = ifelse(str_length(id1) > 1, str_sub(id1, -1, -1), id1), #IF id1 length >1 then just take the last character
         id1 = as.numeric(id1))                                        # Convert back to numeric
         

#lowercase all ID3
cpre <- cpre %>% 
  mutate(id3 = tolower(id3))



#####################################################################################################################################################
########################################################################################Post#########################################################
#####################################################################################################################################################

cpos <- read_csv("control_post.csv")

#Lowercase names
names(cpos) <- tolower(names(cpos))


#Select only names that are also in pre survey
cpos <- cpos %>% 
  select(names_cpre)


#Get only non-cc participators & Those with ID numbers
cpos <- cpos %>% 
  filter(cc_part == 0, # Never particpated in CC
         !is.na(id1)   # Has ID#
  ) %>% 
  select(-id2)        #ID2 gave problems, people had trouble inputting their 6th digit of their id. Remember this for next semester

#Fix ID1 var
cpos <- cpos %>% 
  mutate(id1 = as.character(id1),                                      # Convert to character
         id1 = ifelse(str_length(id1) > 1, str_sub(id1, -1, -1), id1), #IF id1 length >1 then just take the last character
         id1 = as.numeric(id1)                                         # Convert back to numeric
         )                                        

#lowercase all ID3
cpos <- cpos %>% 
  mutate(id3 = tolower(id3)
         )

#########################################################COMBINE PRE AND POST##############################################

#Pre set up
cpre <- cpre %>% 
  select(starts_with("id"), everything()) #Bring id to the front

cpre <- cpre %>% 
  rename_at(vars(starts_with("m0")), ~str_remove(., "m0")) %>% 
  rename_at(4:ncol(.), ~str_c("m0", .)) #Add "m0" to the front of every variable (Except id)

#Post set up
cpos <- cpos %>% 
  select(starts_with("id"), everything()) #Bring id to the front

cpos <- cpos %>% 
  rename_at(vars(starts_with("m0")), ~str_remove(., "m0")) %>% 
  rename_at(4:ncol(.), ~str_c("m1", .)) #Add "m1" to the front of every variable (Except id)


#Merge dataframes
cmerged <- cpre %>% 
  right_join(cpos, by = c("id1",  "id3", "id4")) %>% #Merge pre and post
  filter(!is.na(m0startdate),                              #only allow those that did both surveys
         !is.na(m1startdate)) %>%                          #only allow those that did both surveys
  mutate(ID = str_c(id1, id3,id4)) %>%                 #Merge id variables
  select(ID, everything(), -id1, -id3, -id4) %>%     #Bring id variable to front, delete old ids
  mutate(in_cc = 0) %>% 
  select(-contains("status"), -contains("ipaddress"), -contains("duration"), -contains("finished"), -contains("responseid"), #Remove uneccessary metadata
         -contains("recipient"), - contains("externalref"), -contains("locationl"), -contains("distribution"), -contains("userlanguage"),
         -contains("progress"), -contains("recordeddate"), -contains("cc_part")
         )
cmerged <- cmerged %>% 
  group_by(ID) %>% 
  slice(1) %>% 
  ungroup() 






################################################################################################################################################
############################################################################Campus COnnections##################################################
############################################################################Campus COnnections##################################################
################################################################################################################################################

#############################################################################################################################################
##################################################################################Pre########################################################
#############################################################################################################################################



#Read in data
campre <- read_csv("cc_pre.csv")


#Lowercase variables
names(campre) <- tolower(names(campre))

campre <- select(campre, -gratitude_7)

#Get names
names_campre <- names(campre)
names_campre

#Get only non-cc participators & Those with ID numbers
campre <- campre %>% 
  filter(!is.na(id1)   # Has ID#
  ) %>% 
  select(-id2)         #ID2 gave problems, people had trouble inputting their 6th digit of their id. Remember this for next semester


#Fix ID1 var
campre <- campre %>% 
  mutate(id1 = as.character(id1),                                      # Convert to character
         id1 = ifelse(str_length(id1) > 1, str_sub(id1, -1, -1), id1), #IF id1 length >1 then just take the last character
         id1 = as.numeric(id1))                                        # Convert back to numeric

#lowercase all ID3
campre <- campre %>% 
  mutate(id3 = tolower(id3))




#####################################################################################################################################################
########################################################################################Post#########################################################
#####################################################################################################################################################

campos <- read_csv("cc_post.csv")

#Lowercase names
names(campos) <- tolower(names(campos))


#Select only names that are also in pre survey
campos <- campos %>% 
  select(names_campre)


#Get only non-cc participators & Those with ID numbers
campos <- campos %>% 
  filter(!is.na(id1)   # Has ID#
  ) %>% 
  select(-id2)         #ID2 gave problems, people had trouble inputting their 6th digit of their id. Remember this for next semester

#Fix ID1 var
campos <- campos %>% 
  mutate(id1 = as.character(id1),                                      # Convert to character
         id1 = ifelse(str_length(id1) > 1, str_sub(id1, -1, -1), id1), #IF id1 length >1 then just take the last character
         id1 = as.numeric(id1)                                         # Convert back to numeric
  )                                        

#lowercase all ID3
campos <- campos %>% 
  mutate(id3 = tolower(id3)
  )



#########################################################COMBINE PRE AND POST##############################################

#Pre set up
campre <- campre %>% 
  select(starts_with("id"), everything()) #Bring id to the front

campre <- campre %>% 
  rename_at(vars(starts_with("m0")), ~str_remove(., "m0")) %>% 
  rename_at(4:ncol(.), ~str_c("m0", .)) #Add "m0" to the front of every variable (Except id)

#Post set up
campos <- campos %>% 
  select(starts_with("id"), everything()) #Bring id to the front

campos <- campos %>% 
  rename_at(vars(starts_with("m0")), ~str_remove(., "m0")) %>% 
  rename_at(4:ncol(.), ~str_c("m1", .)) #Add "m1" to the front of every variable (Except id)


#Merge dataframes
cammerged <- campre %>% 
  right_join(campos, by = c("id1",  "id3", "id4")) %>% #Merge pre and post
  filter(!is.na(m0startdate),                              #only allow those that did both surveys
         !is.na(m1startdate)) %>%                          #only allow those that did both surveys
  mutate(ID = str_c(id1, id3,id4)) %>%                 #Merge id variables
  select(ID, everything(), -id1,  -id3, -id4) %>%      #Bring id variable to front, delete old ids
  mutate(in_cc = 1) %>% 
  select(-contains("status"), -contains("ipaddress"), -contains("duration"), -contains("finished"), -contains("responseid"), #Remove uneccessary metadata
         -contains("recipient"), - contains("externalref"), -contains("locationl"), -contains("distribution"), -contains("userlanguage"),
         -contains("progress"), -contains("recordeddate")
  )


cammerged <- cammerged %>% 
  group_by(ID) %>% 
  slice(1) %>% 
  ungroup()

########################################Stack control and CC Group############################################



all <- bind_rows(cmerged, cammerged)


all <- all %>% 
  mutate(ID = str_c("F19_",ID)) %>% 
  select(ID, in_cc, everything()) %>% 
  mutate(m0yrborn = m1yrborn) %>% 
  select(-starts_with("m1race"), -starts_with("m1hisp"), -starts_with("m1asian"), 
         -starts_with("m1gender"), -m1yrborn, -m1year,  -starts_with("m1major"), 
         -m1ft, -m1famses, -contains("scs")
         )



#####Create ethnicity variable

#/*new variable - eth
#1=american indian
#2=asian
#3=black
#4=hispanic
#5=hawaiian
#6=white
#7=mixed*/
#8 = Other


all <- all %>% 
  mutate(
    m0race_1 = ifelse(is.na(m0race_1), 0, m0race_1), 
    m0race_2 = ifelse(is.na(m0race_2), 0, m0race_2), 
    m0race_3 = ifelse(is.na(m0race_3), 0, m0race_3), 
    m0race_4 = ifelse(is.na(m0race_4), 0, m0race_4), 
    m0race_5 = ifelse(is.na(m0race_5), 0, m0race_5), 
    m0race_6 = ifelse(is.na(m0race_6), 0, m0race_6), 
    m0race_7 = ifelse(is.na(m0race_7), 0, m0race_7)
  )%>% 
  rowwise() %>% 
  mutate(
    kethtotal = sum(m0race_1, m0race_2, m0race_3, m0race_4, m0race_5, m0race_6, m0race_7, na.rm = TRUE),
    mentor_eth = ifelse((m0race_1 == 1 & kethtotal == 1), 1, NA),
    mentor_eth = ifelse((m0race_2 == 1 & kethtotal == 1), 2, mentor_eth),
    mentor_eth = ifelse((m0race_3 == 1 & kethtotal == 1), 3, mentor_eth),
    mentor_eth = ifelse((m0race_4 == 1 & kethtotal == 1), 4, mentor_eth),
    mentor_eth = ifelse((m0race_5 == 1 & kethtotal == 1), 5, mentor_eth),
    mentor_eth = ifelse((m0race_6 == 1 & kethtotal == 1), 6, mentor_eth),
    mentor_eth = ifelse(sum(m0race_1, m0race_2, m0race_3, m0race_4, m0race_5, m0race_6, m0race_7, na.rm = TRUE) > 1, 7, mentor_eth),
    mentor_eth = ifelse((m0race_4 == 1 & m0race_6 == 1 & kethtotal == 2), 4, mentor_eth)
  ) %>% 
  ungroup() %>% 
  select(ID, in_cc, m0startdate, m0enddate, m0mentor_eth = "mentor_eth", everything(), -starts_with("m0race"))



##########################################################################################################################################################
##########################################################Measures set up#################################################################################
##########################################################Measures set up#################################################################################
##########################################################Measures set up#################################################################################
##########################################################################################################################################################

#####CESD
##Reverse score items 5 & 8


#Timepoint 0

all <- all %>% 
  mutate(m0cesdr_5R = 5 - m0cesdr_5,
         m0cesdr_8R = 5 - m0cesdr_8)


##Check
table(all$m0cesdr_5,all$m0cesdr_5R)
table(all$m0cesdr_8,all$m0cesdr_8R)

#Timepoint 1
all <- all %>% 
  mutate(m1cesdr_5R = 5 - m1cesdr_5,
         m1cesdr_8R = 5 - m1cesdr_8)

##Check
table(all$m1cesdr_5,all$m1cesdr_5R)
table(all$m1cesdr_8,all$m1cesdr_8R)




#####Gratitude
##Reverse score items 3 & 6

#Timepoint 0
all <- all %>% 
  mutate(m0gratitude_3R = 8 - m0gratitude_3,
         m0gratitude_6R = 8 - m0gratitude_6)

##Check
table(all$m0gratitude_3,all$m0gratitude_3R)
table(all$m0gratitude_6,all$m0gratitude_6R)


#Timepoint 1
all <- all %>% 
  mutate(m1gratitude_3R = 8 - m1gratitude_3,
         m1gratitude_6R = 8 - m1gratitude_6)

##Check
table(all$m1gratitude_3,all$m1gratitude_3R)
table(all$m1gratitude_6,all$m1gratitude_6R)



#Self compassion scale

#Coding Key:
#Self-Kindness Items: 2, 6
###############################Self-Judgment Items: 11, 12
#Common Humanity Items: 5, 10
################################Isolation Items: 4, 8
#Mindfulness Items: 3, 7
################################Over-identified Items: 1, 9

#Subscale scores are computed by calculating the mean of subscale item responses. To compute a
#total self-compassion score, reverse score the negative subscale items - self-judgment, isolation,
#and over-identification (i.e., 1 = 5, 2 = 4, 3 = 3, 4 = 2, 5 = 1) - then compute a total mean.


#Timepoint 0
all <- all %>% 
  mutate(m0self_c_11R = 6 - m0self_c_11,
         m0self_c_12R = 6 - m0self_c_12,
         m0self_c_4R  = 6 - m0self_c_4 ,
         m0self_c_8R  = 6 - m0self_c_8 ,
         m0self_c_1R  = 6 - m0self_c_1 ,
         m0self_c_9R  = 6 - m0self_c_9
         )


##Check
table(all$m0self_c_11,all$m0self_c_11R)
table(all$m0self_c_12,all$m0self_c_12R)
table(all$m0self_c_4, all$m0self_c_4R )
table(all$m0self_c_8, all$m0self_c_8R )
table(all$m0self_c_1, all$m0self_c_1R )
table(all$m0self_c_9, all$m0self_c_9R )



#Timepoint 0
all <- all %>% 
  mutate(m1self_c_11R = 6 - m1self_c_11,
         m1self_c_12R = 6 - m1self_c_12,
         m1self_c_4R  = 6 - m1self_c_4 ,
         m1self_c_8R  = 6 - m1self_c_8 ,
         m1self_c_1R  = 6 - m1self_c_1 ,
         m1self_c_9R  = 6 - m1self_c_9
  )




##Check
table(all$m1self_c_11,all$m1self_c_11R)
table(all$m1self_c_12,all$m1self_c_12R)
table(all$m1self_c_4, all$m1self_c_4R )
table(all$m1self_c_8, all$m1self_c_8R )
table(all$m1self_c_1, all$m1self_c_1R )
table(all$m1self_c_9, all$m1self_c_9R )


names(all)




#write_csv(all, "../F19_Final.csv", na = "")




