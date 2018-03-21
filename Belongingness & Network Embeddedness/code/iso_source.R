#
#
#     Neil's isolate check code. Created on 03/20/18
#     This code checks if isolates truly belong in the network.
#     WHen run, all the way through, any data frame left in the environment indicates an SN 
#     isolate that did NOT take a survey
#
#     These individuals need to be removed from the network. 
#     Please email me at Neil at ndyetz@gmail.com with any questions.
#
#



#Clear Environment
rm(list = ls(all.names = TRUE))

#Load Libraries
library(tidyverse)
 

#load data
ALL <- readRDS("T:/Research folders/CCWTG/Data/MERGEALL/ALL_NETWORKS.RDS")
survs <- read_csv("T:/Research folders/CCWTG/Data/MERGEALL/Allwide.csv")
 

#select necessary columns

#select survtime columns. That had a social network.
surv_take <- survs %>% 
  select(Final_ID, starts_with("m"), starts_with("k"), -starts_with("k0"), -starts_with("m0"), -starts_with("k6"), -starts_with("m6")) %>% 
  select(Final_ID, ends_with("start")) %>% 
  mutate(Final_ID_M = paste0("M", Final_ID), #Match Mentor Final_ID i.e. "MCCF15_0000"
         Final_ID_K = paste0("K", Final_ID)) #Match Mentor Final_ID i.e. "KCCF15_0000"


#convert times to binary. 
surv_take[,2:11][!is.na(surv_take[,2:11])] <- 1; surv_take[is.na(surv_take)] <- 0

                            #1 = survey response          #0 = no survey response. 

check1 <- surv_take %>% filter(m1start == 0) %>% select(Final_ID_K, Final_ID_M) %>% as.matrix()
check2 <- surv_take %>% filter(m2start == 0) %>% select(Final_ID_K, Final_ID_M) %>% as.matrix()
check3 <- surv_take %>% filter(m3start == 0) %>% select(Final_ID_K, Final_ID_M) %>% as.matrix()
check4 <- surv_take %>% filter(m4start == 0) %>% select(Final_ID_K, Final_ID_M) %>% as.matrix()
check5 <- surv_take %>% filter(m5start == 0) %>% select(Final_ID_K, Final_ID_M) %>% as.matrix()

#Grab Isolates, compare with survey records.

##F15 

 #Monday #
   

mat <- as.character(intersect(check1, as.matrix(ALL$F15$monday$edgelists$iso1))); F15_M_1 <- as.data.frame(mat)
mat <- as.character(intersect(check2, as.matrix(ALL$F15$monday$edgelists$iso2))); F15_M_2 <- as.data.frame(mat)
mat <- as.character(intersect(check3, as.matrix(ALL$F15$monday$edgelists$iso3))); F15_M_3 <- as.data.frame(mat)
mat <- as.character(intersect(check4, as.matrix(ALL$F15$monday$edgelists$iso4))); F15_M_4 <- as.data.frame(mat)
mat <- as.character(intersect(check5, as.matrix(ALL$F15$monday$edgelists$iso5))); F15_M_5 <- as.data.frame(mat)



 #Tuesday #
   
 


mat <- intersect(check1, as.matrix(ALL$F15$tuesday$edgelists$iso1)); F15_T_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$F15$tuesday$edgelists$iso2)); F15_T_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$F15$tuesday$edgelists$iso3)); F15_T_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$F15$tuesday$edgelists$iso4)); F15_T_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$F15$tuesday$edgelists$iso5)); F15_T_5 <- as.data.frame(mat)




 #Wednesday #
   
 


mat <- intersect(check1, as.matrix(ALL$F15$wednesday$edgelists$iso1)); F15_W_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$F15$wednesday$edgelists$iso2)); F15_W_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$F15$wednesday$edgelists$iso3)); F15_W_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$F15$wednesday$edgelists$iso4)); F15_W_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$F15$wednesday$edgelists$iso5)); F15_W_5 <- as.data.frame(mat)

 

 #Thursday #
   
 


mat <- intersect(check1, as.matrix(ALL$F15$thursday$edgelists$iso1)); F15_Th_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$F15$thursday$edgelists$iso2)); F15_Th_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$F15$thursday$edgelists$iso3)); F15_Th_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$F15$thursday$edgelists$iso4)); F15_Th_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$F15$thursday$edgelists$iso5)); F15_Th_5 <- as.data.frame(mat)

 
##S16 

 #Monday #
   
 


mat <- intersect(check1, as.matrix(ALL$S16$monday$edgelists$iso1)); S16_M_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$S16$monday$edgelists$iso2)); S16_M_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$S16$monday$edgelists$iso3)); S16_M_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$S16$monday$edgelists$iso4)); S16_M_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$S16$monday$edgelists$iso5)); S16_M_5 <- as.data.frame(mat)


 #Tuesday #
   
 



mat <- intersect(check1, as.matrix(ALL$S16$tuesday$edgelists$iso1)); S16_T_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$S16$tuesday$edgelists$iso2)); S16_T_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$S16$tuesday$edgelists$iso3)); S16_T_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$S16$tuesday$edgelists$iso4)); S16_T_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$S16$tuesday$edgelists$iso5)); S16_T_5 <- as.data.frame(mat)

 

 #Wednesday #
   
 


mat <- intersect(check1, as.matrix(ALL$S16$wednesday$edgelists$iso1)); S16_W_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$S16$wednesday$edgelists$iso2)); S16_W_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$S16$wednesday$edgelists$iso3)); S16_W_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$S16$wednesday$edgelists$iso4)); S16_W_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$S16$wednesday$edgelists$iso5)); S16_W_5 <- as.data.frame(mat)


#Thursday #
   
 


mat <- intersect(check1, as.matrix(ALL$S16$thursday$edgelists$iso1)); S16_Th_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$S16$thursday$edgelists$iso2)); S16_Th_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$S16$thursday$edgelists$iso3)); S16_Th_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$S16$thursday$edgelists$iso4)); S16_Th_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$S16$thursday$edgelists$iso5)); S16_Th_5 <- as.data.frame(mat)

 

##F16 

 #Monday #
   
 


mat <- intersect(check1, as.matrix(ALL$F16$monday$edgelists$iso1)); F16_M_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$F16$monday$edgelists$iso2)); F16_M_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$F16$monday$edgelists$iso3)); F16_M_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$F16$monday$edgelists$iso4)); F16_M_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$F16$monday$edgelists$iso5)); F16_M_5 <- as.data.frame(mat)


 

 #Tuesday #
   
 


mat <- intersect(check1, as.matrix(ALL$F16$tuesday$edgelists$iso1)); F16_T_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$F16$tuesday$edgelists$iso2)); F16_T_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$F16$tuesday$edgelists$iso3)); F16_T_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$F16$tuesday$edgelists$iso4)); F16_T_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$F16$tuesday$edgelists$iso5)); F16_T_5 <- as.data.frame(mat)

 

 #Wednesday #
   
 


mat <- as.character(intersect(check1, as.matrix(ALL$F16$wednesday$edgelists$iso1))); F16_W_1 <- as.data.frame(mat)
mat <- as.character(intersect(check2, as.matrix(ALL$F16$wednesday$edgelists$iso2))); F16_W_2 <- as.data.frame(mat)
mat <- as.character(intersect(check3, as.matrix(ALL$F16$wednesday$edgelists$iso3))); F16_W_3 <- as.data.frame(mat)
mat <- as.character(intersect(check4, as.matrix(ALL$F16$wednesday$edgelists$iso4))); F16_W_4 <- as.data.frame(mat)
mat <- as.character(intersect(check5, as.matrix(ALL$F16$wednesday$edgelists$iso5))); F16_W_5 <- as.data.frame(mat)

 

 #Thursday #
   
 


mat <- intersect(check1, as.matrix(ALL$F16$thursday$edgelists$iso1)); F16_Th_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$F16$thursday$edgelists$iso2)); F16_Th_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$F16$thursday$edgelists$iso3)); F16_Th_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$F16$thursday$edgelists$iso4)); F16_Th_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$F16$thursday$edgelists$iso5)); F16_Th_5 <- as.data.frame(mat)

 

##S17

 #Monday #
   
 


mat <- intersect(check1, as.matrix(ALL$S17$monday$edgelists$iso1)); S17_M_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$S17$monday$edgelists$iso2)); S17_M_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$S17$monday$edgelists$iso3)); S17_M_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$S17$monday$edgelists$iso4)); S17_M_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$S17$monday$edgelists$iso5)); S17_M_5 <- as.data.frame(mat)


 

 #Tuesday #
   
 



mat <- intersect(check1, as.matrix(ALL$S17$tuesday$edgelists$iso1)); S17_T_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$S17$tuesday$edgelists$iso2)); S17_T_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$S17$tuesday$edgelists$iso3)); S17_T_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$S17$tuesday$edgelists$iso4)); S17_T_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$S17$tuesday$edgelists$iso5)); S17_T_5 <- as.data.frame(mat)

 

 #Wednesday #
   
 



mat <- intersect(check1, as.matrix(ALL$S17$wednesday$edgelists$iso1)); S17_T_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$S17$wednesday$edgelists$iso2)); S17_T_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$S17$wednesday$edgelists$iso3)); S17_T_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$S17$wednesday$edgelists$iso4)); S17_T_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$S17$wednesday$edgelists$iso5)); S17_T_5 <- as.data.frame(mat)

 

 #Thursday #
   

mat <- intersect(check1, as.matrix(ALL$S17$thursday$edgelists$iso1)); S17_Th_1 <- as.data.frame(mat)
mat <- intersect(check2, as.matrix(ALL$S17$thursday$edgelists$iso2)); S17_Th_2 <- as.data.frame(mat)
mat <- intersect(check3, as.matrix(ALL$S17$thursday$edgelists$iso3)); S17_Th_3 <- as.data.frame(mat)
mat <- intersect(check4, as.matrix(ALL$S17$thursday$edgelists$iso4)); S17_Th_4 <- as.data.frame(mat)
mat <- intersect(check5, as.matrix(ALL$S17$thursday$edgelists$iso5)); S17_Th_5 <- as.data.frame(mat)




#Removes all empty data frames. #leftover dfs are those that need to be checked. 
x <- eapply(.GlobalEnv,is.data.frame)
alldfnames <- names(x[x==T])
isFullDF <- function(nm) nrow(get(nm))>0
rm(list = alldfnames[!sapply(alldfnames, isFullDF)])


ReadMe <- "If no datasets are in the global environment then you're good to go!"


#Remove all but errors
rm(surv_take); rm(survs); rm(ALL); 
rm(check1);rm(check2);rm(check3);rm(check4);rm(check5)
rm(x)
rm(alldfnames)
rm(mat)
rm(isFullDF)





