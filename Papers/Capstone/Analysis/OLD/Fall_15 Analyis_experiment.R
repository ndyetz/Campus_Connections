rm(list = ls(all.names = TRUE))

#install.packages("CTT")
#install.packages("GGally")
#install.packages("ggplot2")
#install.packages("lattice")
#install.packages("gridExtra")
#install.packages("igraph")
#install.packages("dplyr")
#install.packages("tidyr")
#install.packages("igraph")
#install.packages("statnet")


library(CTT)
library(GGally)
library(ggplot2)
library(lattice)
library(gridExtra)
library(reshape)
library(igraph)
library(dplyr)
library(tidyr)
library(igraph)
library(statnet)

#Pulling in edgelists & SN Include files that were created using SAS


setwd("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA")


elm <- read.csv("Mentor.csv", header = TRUE) 
elk <- read.csv("mentee.csv", header = TRUE) 
sn_include<- read.csv("F15_SN_Include.csv", header = TRUE)

setwd("T:/Research folders/CCWTG/Analyses/Data for Stats Dept/FINAL DATA")

elmk <- read.csv("CC_edgelist.csv", header = TRUE) 
youth_att <- read.csv("Mentee_Attributes.csv")
staff_att <- read.csv("Staff_Attributes.csv")
staff_youth_att <- read.csv("staff_youth_att.csv")




#SN INCLUDE FILES

##Monday surveys

setwd("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA")

sn_include_monday_1    <- read.csv("F15_SN_inc_mon_surv1.csv", header = TRUE)
sn_include_monday_2    <- read.csv("F15_SN_inc_mon_surv2.csv", header = TRUE)
sn_include_monday_3    <- read.csv("F15_SN_inc_mon_surv3.csv", header = TRUE)
sn_include_monday_4    <- read.csv("F15_SN_inc_mon_surv4.csv", header = TRUE)
sn_include_monday_5    <- read.csv("F15_SN_inc_mon_surv5.csv", header = TRUE)

##Tuesday surveys

sn_include_tuesday_1    <- read.csv("F15_SN_inc_tue_surv1.csv", header = TRUE)
sn_include_tuesday_2    <- read.csv("F15_SN_inc_tue_surv2.csv", header = TRUE)
sn_include_tuesday_3    <- read.csv("F15_SN_inc_tue_surv3.csv", header = TRUE)
sn_include_tuesday_4    <- read.csv("F15_SN_inc_tue_surv4.csv", header = TRUE)
sn_include_tuesday_5    <- read.csv("F15_SN_inc_tue_surv5.csv", header = TRUE)



##Wednesday surveys

sn_include_wednesday_1    <- read.csv("F15_SN_inc_wed_surv1.csv", header = TRUE)
sn_include_wednesday_2    <- read.csv("F15_SN_inc_wed_surv2.csv", header = TRUE)
sn_include_wednesday_3    <- read.csv("F15_SN_inc_wed_surv3.csv", header = TRUE)
sn_include_wednesday_4    <- read.csv("F15_SN_inc_wed_surv4.csv", header = TRUE)
sn_include_wednesday_5    <- read.csv("F15_SN_inc_wed_surv5.csv", header = TRUE)


##STILL NEED TO CREATE THURSDAY FILES IN FORMAT FILE
#sn_include_thursday  <- read.csv("F15_SN_Thursday.csv", header = TRUE)


################################################################################################################################
################################################################################################################################
###########################NEIL CREATING YOUTH SOCIAL NETWORKS FOR PROJECT FALL '16#############################################
##############################################COntrol Nights = M/W  ############################################################
################################################################################################################################
################################################################################################################################
################################################################################################################################

#sn1_1 <- elmk_1_monday[c("sn1")]
#sn1_5 <- elmk_5_monday[c("sn1")]


#mytable <- table(sn1_1$sn1)
#mytable5 <- table(sn1_5$sn1)


elmk_f15 <- subset(elmk, semester == "F15")
elmk_f15 <- subset(elmk_f15, Receiver_Missing == 0)
elmk_f15 <- subset(elmk_f15, Sender_Missing == 0)


elmk_s16 <- subset(elmk, semester == "S16")
elmk_s16 <- subset(elmk_s16, Receiver_Missing == 0)
elmk_s16 <- subset(elmk_s16, Sender_Missing == 0)

#Separating The edgelists by night


elmk_1_f15 <- subset(elmk_f15, survnum == 1)
elmk_2_f15 <- subset(elmk_f15, survnum == 2)
elmk_3_f15 <- subset(elmk_f15, survnum == 3)
elmk_4_f15 <- subset(elmk_f15, survnum == 4)
elmk_5_f15 <- subset(elmk_f15, survnum == 5)


elmk_1_s16 <- subset(elmk_s16, survnum == 1)
elmk_2_s16 <- subset(elmk_s16, survnum == 2)
elmk_3_s16 <- subset(elmk_s16, survnum == 3)
elmk_4_s16 <- subset(elmk_s16, survnum == 4)
elmk_5_s16 <- subset(elmk_s16, survnum == 5)

#survey 1 edgelist by night

elmk_1_f15_monday    <-    subset(elmk_1_f15, night=="monday")
elmk_1_f15_tuesday   <-    subset(elmk_1_f15, night=="tuesday")
elmk_1_f15_wednesday <-    subset(elmk_1_f15, night=="wednesday")
elmk_1_f15_thursday  <-    subset(elmk_1_f15, night=="thursday")


elmk_1_s16_monday    <-    subset(elmk_1_s16, night=="monday")
elmk_1_s16_tuesday   <-    subset(elmk_1_s16, night=="tuesday")
elmk_1_s16_wednesday <-    subset(elmk_1_s16, night=="wednesday")
elmk_1_s16_thursday  <-    subset(elmk_1_s16, night=="thursday")


#survey 2 edgelist by night

elmk_2_f15_monday <-    subset(elmk_2_f15, night=="monday")
elmk_2_f15_tuesday <-   subset(elmk_2_f15, night=="tuesday")
elmk_2_f15_wednesday <- subset(elmk_2_f15, night=="wednesday")
elmk_2_f15_thursday <-  subset(elmk_2_f15, night=="thursday")


elmk_2_s16_monday <-    subset(elmk_2_s16, night=="monday")
elmk_2_s16_tuesday <-   subset(elmk_2_s16, night=="tuesday")
elmk_2_s16_wednesday <- subset(elmk_2_s16, night=="wednesday")
elmk_2_s16_thursday <-  subset(elmk_2_s16, night=="thursday")


#survey 3 edgelist by night

elmk_3_f15_monday <-    subset(elmk_3_f15, night=="monday")
elmk_3_f15_tuesday <-   subset(elmk_3_f15, night=="tuesday")
elmk_3_f15_wednesday <- subset(elmk_3_f15, night=="wednesday")
elmk_3_f15_thursday <-  subset(elmk_3_f15, night=="thursday")


elmk_3_s16_monday <-    subset(elmk_3_s16, night=="monday")
elmk_3_s16_tuesday <-   subset(elmk_3_s16, night=="tuesday")
elmk_3_s16_wednesday <- subset(elmk_3_s16, night=="wednesday")
elmk_3_s16_thursday <-  subset(elmk_3_s16, night=="thursday")

#survey 4 edgelist by night

elmk_4_f15_monday <-    subset(elmk_4_f15, night=="monday")
elmk_4_f15_tuesday <-   subset(elmk_4_f15, night=="tuesday")
elmk_4_f15_wednesday <- subset(elmk_4_f15, night=="wednesday")
elmk_4_f15_thursday <-  subset(elmk_4_f15, night=="thursday")


elmk_4_s16_monday <-    subset(elmk_4_s16, night=="monday")
elmk_4_s16_tuesday <-   subset(elmk_4_s16, night=="tuesday")
elmk_4_s16_wednesday <- subset(elmk_4_s16, night=="wednesday")
elmk_4_s16_thursday <-  subset(elmk_4_s16, night=="thursday")

#survey 5 edgelist by night

elmk_5_f15_monday <-    subset(elmk_5_f15, night=="monday")
elmk_5_f15_tuesday <-   subset(elmk_5_f15, night=="tuesday")
elmk_5_f15_wednesday <- subset(elmk_5_f15, night=="wednesday")
elmk_5_f15_thursday <-  subset(elmk_5_f15, night=="thursday")


elmk_5_s16_monday <-    subset(elmk_5_s16, night=="monday")
elmk_5_s16_tuesday <-   subset(elmk_5_s16, night=="tuesday")
elmk_5_s16_wednesday <- subset(elmk_5_s16, night=="wednesday")
elmk_5_s16_thursday <-  subset(elmk_5_s16, night=="thursday")

#Ordering appropriately and removing uneccesary variables

#Monday edgelist surveys 1-5

#sn2

elmk_1_f15_monday <- elmk_1_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_2_f15_monday <- elmk_2_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_3_f15_monday <- elmk_3_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_4_f15_monday <- elmk_4_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_5_f15_monday <- elmk_5_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]


elmk_1_s16_monday <- elmk_1_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_2_s16_monday <- elmk_2_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_3_s16_monday <- elmk_3_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_4_s16_monday <- elmk_4_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_5_s16_monday <- elmk_5_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]

#sn1

#elmk_1_f16_monday <- elmk_1_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_2_f16_monday <- elmk_2_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_3_f16_monday <- elmk_3_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_4_f16_monday <- elmk_4_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_5_f16_monday <- elmk_5_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]

#elmk_1_s16_monday <- elmk_1_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_2_s16_monday <- elmk_2_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_3_s16_monday <- elmk_3_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_4_s16_monday <- elmk_4_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_5_s16_monday <- elmk_5_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]




#Tueday edgelist surveys 1-5

#sn2

elmk_1_f15_tuesday <- elmk_1_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_2_f15_tuesday <- elmk_2_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_3_f15_tuesday <- elmk_3_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_4_f15_tuesday <- elmk_4_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_5_f15_tuesday <- elmk_5_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]


elmk_1_s16_tuesday <- elmk_1_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_2_s16_tuesday <- elmk_2_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_3_s16_tuesday <- elmk_3_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_4_s16_tuesday <- elmk_4_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_5_s16_tuesday <- elmk_5_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]


#sn1

#elmk_1_f16_tuesday <- elmk_1_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_2_f16_tuesday <- elmk_2_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_3_f16_tuesday <- elmk_3_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_4_f16_tuesday <- elmk_4_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_5_f16_tuesday <- elmk_5_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#
#elmk_1_s16_tuesday <- elmk_1_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_2_s16_tuesday <- elmk_2_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_3_s16_tuesday <- elmk_3_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_4_s16_tuesday <- elmk_4_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_5_s16_tuesday <- elmk_5_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]



#Wednesday edgelist surveys 1-5

elmk_1_f15_wednesday <- elmk_1_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_2_f15_wednesday <- elmk_2_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_3_f15_wednesday <- elmk_3_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_4_f15_wednesday <- elmk_4_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_5_f15_wednesday <- elmk_5_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]


elmk_1_s16_wednesday <- elmk_1_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_2_s16_wednesday <- elmk_2_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_3_s16_wednesday <- elmk_3_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_4_s16_wednesday <- elmk_4_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_5_s16_wednesday <- elmk_5_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]


#sn1

#elmk_1_f16_wednesday <- elmk_1_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_2_f16_wednesday <- elmk_2_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_3_f16_wednesday <- elmk_3_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_4_f16_wednesday <- elmk_4_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_5_f16_wednesday <- elmk_5_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#
#elmk_1_s16_wednesday <- elmk_1_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_2_s16_wednesday <- elmk_2_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_3_s16_wednesday <- elmk_3_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_4_s16_wednesday <- elmk_4_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_5_s16_wednesday <- elmk_5_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]



#Thursday edgelist surveys 1-5

elmk_1_f15_thursday <- elmk_1_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_2_f15_thursday <- elmk_2_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_3_f15_thursday <- elmk_3_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_4_f15_thursday <- elmk_4_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_5_f15_thursday <- elmk_5_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]


elmk_1_s16_thursday <- elmk_1_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_2_s16_thursday <- elmk_2_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_3_s16_thursday <- elmk_3_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_4_s16_thursday <- elmk_4_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
elmk_5_s16_thursday <- elmk_5_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]


#sn1

#elmk_1_f16_thursday <- elmk_1_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_2_f16_thursday <- elmk_2_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_3_f16_thursday <- elmk_3_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_4_f16_thursday <- elmk_4_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_5_f16_thursday <- elmk_5_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#
#elmk_1_s16_thursday <- elmk_1_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_2_s16_thursday <- elmk_2_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_3_s16_thursday <- elmk_3_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_4_s16_thursday <- elmk_4_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
#elmk_5_s16_thursday <- elmk_5_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]



#REPLACING NA's WITH 0's

#Monday


elmk_1_f15_monday[["sn2"]][is.na(elmk_1_f15_monday[["sn2"]])] <- 0
elmk_2_f15_monday[["sn2"]][is.na(elmk_2_f15_monday[["sn2"]])] <- 0
elmk_3_f15_monday[["sn2"]][is.na(elmk_3_f15_monday[["sn2"]])] <- 0
elmk_4_f15_monday[["sn2"]][is.na(elmk_4_f15_monday[["sn2"]])] <- 0
elmk_5_f15_monday[["sn2"]][is.na(elmk_5_f15_monday[["sn2"]])] <- 0


elmk_1_s16_monday[["sn2"]][is.na(elmk_1_f15_monday[["sn2"]])] <- 0
elmk_2_s16_monday[["sn2"]][is.na(elmk_2_f15_monday[["sn2"]])] <- 0
elmk_3_s16_monday[["sn2"]][is.na(elmk_3_f15_monday[["sn2"]])] <- 0
elmk_4_s16_monday[["sn2"]][is.na(elmk_4_f15_monday[["sn2"]])] <- 0
elmk_5_s16_monday[["sn2"]][is.na(elmk_5_f15_monday[["sn2"]])] <- 0
#Tuesday

elmk_1_f15_tuesday[["sn2"]][is.na(elmk_1_f15_tuesday[["sn2"]])] <- 0
elmk_2_f15_tuesday[["sn2"]][is.na(elmk_2_f15_tuesday[["sn2"]])] <- 0
elmk_3_f15_tuesday[["sn2"]][is.na(elmk_3_f15_tuesday[["sn2"]])] <- 0
elmk_4_f15_tuesday[["sn2"]][is.na(elmk_4_f15_tuesday[["sn2"]])] <- 0
elmk_5_f15_tuesday[["sn2"]][is.na(elmk_5_f15_tuesday[["sn2"]])] <- 0


elmk_1_s16_tuesday[["sn2"]][is.na(elmk_1_f15_tuesday[["sn2"]])] <- 0
elmk_2_s16_tuesday[["sn2"]][is.na(elmk_2_f15_tuesday[["sn2"]])] <- 0
elmk_3_s16_tuesday[["sn2"]][is.na(elmk_3_f15_tuesday[["sn2"]])] <- 0
elmk_4_s16_tuesday[["sn2"]][is.na(elmk_4_f15_tuesday[["sn2"]])] <- 0
elmk_5_s16_tuesday[["sn2"]][is.na(elmk_5_f15_tuesday[["sn2"]])] <- 0


#Wednesday

elmk_1_f15_wednesday[["sn2"]][is.na(elmk_1_f15_wednesday[["sn2"]])] <- 0
elmk_2_f15_wednesday[["sn2"]][is.na(elmk_2_f15_wednesday[["sn2"]])] <- 0
elmk_3_f15_wednesday[["sn2"]][is.na(elmk_3_f15_wednesday[["sn2"]])] <- 0
elmk_4_f15_wednesday[["sn2"]][is.na(elmk_4_f15_wednesday[["sn2"]])] <- 0
elmk_5_f15_wednesday[["sn2"]][is.na(elmk_5_f15_wednesday[["sn2"]])] <- 0

elmk_1_s16_wednesday[["sn2"]][is.na(elmk_1_f15_wednesday[["sn2"]])] <- 0
elmk_2_s16_wednesday[["sn2"]][is.na(elmk_2_f15_wednesday[["sn2"]])] <- 0
elmk_3_s16_wednesday[["sn2"]][is.na(elmk_3_f15_wednesday[["sn2"]])] <- 0
elmk_4_s16_wednesday[["sn2"]][is.na(elmk_4_f15_wednesday[["sn2"]])] <- 0
elmk_5_s16_wednesday[["sn2"]][is.na(elmk_5_f15_wednesday[["sn2"]])] <- 0


#Thursday


elmk_1_f15_thursday[["sn2"]][is.na(elmk_1_f15_thursday[["sn2"]])] <- 0
elmk_2_f15_thursday[["sn2"]][is.na(elmk_2_f15_thursday[["sn2"]])] <- 0
elmk_3_f15_thursday[["sn2"]][is.na(elmk_3_f15_thursday[["sn2"]])] <- 0
elmk_4_f15_thursday[["sn2"]][is.na(elmk_4_f15_thursday[["sn2"]])] <- 0
elmk_5_f15_thursday[["sn2"]][is.na(elmk_5_f15_thursday[["sn2"]])] <- 0

elmk_1_s16_thursday[["sn2"]][is.na(elmk_1_f15_thursday[["sn2"]])] <- 0
elmk_2_s16_thursday[["sn2"]][is.na(elmk_2_f15_thursday[["sn2"]])] <- 0
elmk_3_s16_thursday[["sn2"]][is.na(elmk_3_f15_thursday[["sn2"]])] <- 0
elmk_4_s16_thursday[["sn2"]][is.na(elmk_4_f15_thursday[["sn2"]])] <- 0
elmk_5_s16_thursday[["sn2"]][is.na(elmk_5_f15_thursday[["sn2"]])] <- 0





#######################################################################################################################
#################################CREATING SN GRAPHS####################################################################
#######################################################################################################################
#######################################################################################################################
#######################################################################################################################



#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 1


sender <-   elmk_1_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_1_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_1_f15_monday  [c("sn2")]


#labels_monday <- sn_include_monday$Sender_Final_ID 

labels_monday <- sn_include_monday_1$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday




######################################################


monday_1 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                            add.colnames = NULL, add.rownames = NA)


summary(monday_1)

monday_1 <- simplify(monday_1)
E(monday_1)$weight



monday_1 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                         add.colnames = NULL, add.rownames = NA)

summary(monday_1)

monday_1 <- simplify(monday_1)
E(monday_1)$weight



net=monday_1
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_1), loops=FALSE)
centralization_monday <- centralization.degree(monday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_1, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_1, mode="in")
gs.outbound_monday <- graph.strength(monday_1, mode="out")




#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 2


sender <-   elmk_2_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_2_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_2_f15_monday  [c("sn2")]


#labels_monday <- sn_include_monday$Sender_Final_ID 

labels_monday <- sn_include_monday_2$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday




######################################################


monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_2)

monday_2 <- simplify(monday_2)
E(monday_2)$weight



monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(monday_2)

monday_2 <- simplify(monday_2)
E(monday_2)$weight



net=monday_2
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_2), loops=FALSE)
centralization_monday <- centralization.degree(monday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_2, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_2, mode="in")
gs.outbound_monday <- graph.strength(monday_2, mode="out")





#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 3


sender <-   elmk_3_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_3_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_3_f15_monday  [c("sn2")]


#labels_monday <- sn_include_monday$Sender_Final_ID 

labels_monday <- sn_include_monday_3$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday




######################################################


monday_3 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_3)

monday_3 <- simplify(monday_3)
E(monday_3)$weight



monday_3 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(monday_3)

monday_3 <- simplify(monday_3)
E(monday_3)$weight



net=monday_3
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_3), loops=FALSE)
centralization_monday <- centralization.degree(monday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_3, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_3, mode="in")
gs.outbound_monday <- graph.strength(monday_3, mode="out")






#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 4


sender <-   elmk_4_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_4_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_4_f15_monday  [c("sn2")]


#labels_monday <- sn_include_monday$Sender_Final_ID 

labels_monday <- sn_include_monday_4$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday




######################################################


monday_4 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_4)

monday_4 <- simplify(monday_4)
E(monday_4)$weight



monday_4 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(monday_4)

monday_4 <- simplify(monday_4)
E(monday_4)$weight



net=monday_4
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_4), loops=FALSE)
centralization_monday <- centralization.degree(monday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_4, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_4, mode="in")
gs.outbound_monday <- graph.strength(monday_4, mode="out")







#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 5


sender <-   elmk_5_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_5_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_5_f15_monday  [c("sn2")]


#labels_monday <- sn_include_monday$Sender_Final_ID 

labels_monday <- sn_include_monday_5$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday




######################################################


monday_5 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_5)

monday_5 <- simplify(monday_5)
E(monday_5)$weight



monday_5 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(monday_5)

monday_5 <- simplify(monday_5)
E(monday_5)$weight



net=monday_5
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_5), loops=FALSE)
centralization_monday <- centralization.degree(monday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_5, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_5, mode="in")
gs.outbound_monday <- graph.strength(monday_5, mode="out")




##########################Fall '15 Tuesday

############Survey 1 Fall '15 Tuesday


sender <-   elmk_1_f15_tuesday [c("Sender_Final_ID")]
receiver <- elmk_1_f15_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_1_f15_tuesday  [c("sn2")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_tuesday_1$tuesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_tuesday <- el
el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
el_tuesday <- as.matrix(el_tuesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
SN_tuesday




######################################################


tuesday_1 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(tuesday_1)

tuesday_1 <- simplify(tuesday_1)
E(tuesday_1)$weight



tuesday_1 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(tuesday_1)

tuesday_1 <- simplify(tuesday_1)
E(tuesday_1)$weight



net=tuesday_1
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_1), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_1, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_1, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_1, mode="out")




#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 tuesday Survey 2


sender <-   elmk_2_f15_tuesday [c("Sender_Final_ID")]
receiver <- elmk_2_f15_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_2_f15_tuesday  [c("sn2")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_tuesday_2$tuesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_tuesday <- el
el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
el_tuesday <- as.matrix(el_tuesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
SN_tuesday




######################################################


tuesday_2 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(tuesday_2)

tuesday_2 <- simplify(tuesday_2)
E(tuesday_2)$weight



tuesday_2 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(tuesday_2)

tuesday_2 <- simplify(tuesday_2)
E(tuesday_2)$weight



net=tuesday_2
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_2), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_2, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_2, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_2, mode="out")





#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 tuesday Survey 3


sender <-   elmk_3_f15_tuesday [c("Sender_Final_ID")]
receiver <- elmk_3_f15_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_3_f15_tuesday  [c("sn2")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_tuesday_3$tuesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_tuesday <- el
el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
el_tuesday <- as.matrix(el_tuesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
SN_tuesday




######################################################


tuesday_3 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(tuesday_3)

tuesday_3 <- simplify(tuesday_3)
E(tuesday_3)$weight



tuesday_3 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(tuesday_3)

tuesday_3 <- simplify(tuesday_3)
E(tuesday_3)$weight



net=tuesday_3
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_3), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_3, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_3, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_3, mode="out")






#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 tuesday Survey 4


sender <-   elmk_4_f15_tuesday [c("Sender_Final_ID")]
receiver <- elmk_4_f15_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_4_f15_tuesday  [c("sn2")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_tuesday_4$tuesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_tuesday <- el
el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
el_tuesday <- as.matrix(el_tuesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
SN_tuesday




######################################################


tuesday_4 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(tuesday_4)

tuesday_4 <- simplify(tuesday_4)
E(tuesday_4)$weight



tuesday_4 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(tuesday_4)

tuesday_4 <- simplify(tuesday_4)
E(tuesday_4)$weight



net=tuesday_4
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_4), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_4, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_4, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_4, mode="out")







#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 tuesday Survey 5


sender <-   elmk_5_f15_tuesday [c("Sender_Final_ID")]
receiver <- elmk_5_f15_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_5_f15_tuesday  [c("sn2")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_tuesday_5$tuesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_tuesday <- el
el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
el_tuesday <- as.matrix(el_tuesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
SN_tuesday




######################################################


tuesday_5 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(tuesday_5)

tuesday_5 <- simplify(tuesday_5)
E(tuesday_5)$weight



tuesday_5 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(tuesday_5)

tuesday_5 <- simplify(tuesday_5)
E(tuesday_5)$weight



net=tuesday_5
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_5), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_5, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_5, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_5, mode="out")







###################FAll '15 Wednesday


#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 WEDNESDAY Survey 1


sender <-   elmk_1_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_1_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_1_f15_wednesday  [c("sn2")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_wednesday_1$wednesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_wednesday <- el
el_wednesday <- el_wednesday[is.element(el_wednesday$Sender_Final_ID, labels_wednesday),]
el_wednesday <- el_wednesday[is.element(el_wednesday$Receiver_Final_ID, labels_wednesday),]
el_wednesday <- as.matrix(el_wednesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday) <- colnames(SN_wednesday) <- labels_wednesday
SN_wednesday[el_wednesday[,1:2]] <- as.numeric(el_wednesday[,3])
SN_wednesday




######################################################


wednesday_1 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(wednesday_1)

wednesday_1 <- simplify(wednesday_1)
E(wednesday_1)$weight



wednesday_1 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(wednesday_1)

wednesday_1 <- simplify(wednesday_1)
E(wednesday_1)$weight



net=wednesday_1
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_1), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_1, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_1, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_1, mode="out")




#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 2


sender <-   elmk_2_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_2_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_2_f15_wednesday  [c("sn2")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_wednesday_2$wednesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_wednesday <- el
el_wednesday <- el_wednesday[is.element(el_wednesday$Sender_Final_ID, labels_wednesday),]
el_wednesday <- el_wednesday[is.element(el_wednesday$Receiver_Final_ID, labels_wednesday),]
el_wednesday <- as.matrix(el_wednesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday) <- colnames(SN_wednesday) <- labels_wednesday
SN_wednesday[el_wednesday[,1:2]] <- as.numeric(el_wednesday[,3])
SN_wednesday




######################################################


wednesday_2 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(wednesday_2)

wednesday_2 <- simplify(wednesday_2)
E(wednesday_2)$weight



wednesday_2 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(wednesday_2)

wednesday_2 <- simplify(wednesday_2)
E(wednesday_2)$weight



net=wednesday_2
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_2), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_2, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_2, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_2, mode="out")





#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 3


sender <-   elmk_3_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_3_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_3_f15_wednesday  [c("sn2")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_wednesday_3$wednesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_wednesday <- el
el_wednesday <- el_wednesday[is.element(el_wednesday$Sender_Final_ID, labels_wednesday),]
el_wednesday <- el_wednesday[is.element(el_wednesday$Receiver_Final_ID, labels_wednesday),]
el_wednesday <- as.matrix(el_wednesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday) <- colnames(SN_wednesday) <- labels_wednesday
SN_wednesday[el_wednesday[,1:2]] <- as.numeric(el_wednesday[,3])
SN_wednesday




######################################################


wednesday_3 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(wednesday_3)

wednesday_3 <- simplify(wednesday_3)
E(wednesday_3)$weight



wednesday_3 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(wednesday_3)

wednesday_3 <- simplify(wednesday_3)
E(wednesday_3)$weight



net=wednesday_3
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_3), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_3, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_3, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_3, mode="out")



#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 4


sender <-   elmk_4_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_4_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_4_f15_wednesday  [c("sn2")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_wednesday_4$wednesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_wednesday <- el
el_wednesday <- el_wednesday[is.element(el_wednesday$Sender_Final_ID, labels_wednesday),]
el_wednesday <- el_wednesday[is.element(el_wednesday$Receiver_Final_ID, labels_wednesday),]
el_wednesday <- as.matrix(el_wednesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday) <- colnames(SN_wednesday) <- labels_wednesday
SN_wednesday[el_wednesday[,1:2]] <- as.numeric(el_wednesday[,3])
SN_wednesday




######################################################


wednesday_4 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(wednesday_4)

wednesday_4 <- simplify(wednesday_4)
E(wednesday_4)$weight



wednesday_4 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(wednesday_4)

wednesday_4 <- simplify(wednesday_4)
E(wednesday_4)$weight



net=wednesday_4
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_4), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_4, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_4, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_4, mode="out")




#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 5


sender <-   elmk_5_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_5_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_5_f15_wednesday  [c("sn2")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_wednesday_5$wednesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_wednesday <- el
el_wednesday <- el_wednesday[is.element(el_wednesday$Sender_Final_ID, labels_wednesday),]
el_wednesday <- el_wednesday[is.element(el_wednesday$Receiver_Final_ID, labels_wednesday),]
el_wednesday <- as.matrix(el_wednesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday) <- colnames(SN_wednesday) <- labels_wednesday
SN_wednesday[el_wednesday[,1:2]] <- as.numeric(el_wednesday[,3])
SN_wednesday




######################################################


wednesday_5 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(wednesday_5)

wednesday_5 <- simplify(wednesday_5)
E(wednesday_5)$weight



wednesday_5 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(wednesday_5)

wednesday_5 <- simplify(wednesday_5)
E(wednesday_5)$weight



net=wednesday_5
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_5), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_5, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_5, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_5, mode="out")






###################FAll '15 Thursday


#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 THURSDAY Survey 1


sender <-   elmk_1_f15_thursday [c("Sender_Final_ID")]
receiver <- elmk_1_f15_thursday [c("Receiver_Final_ID")]
weight <-   elmk_1_f15_thursday  [c("sn2")]


#labels_thursday <- sn_include_thursday$Sender_Final_ID 

labels_thursday <- sn_include_thursday_1$thursday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_thursday <- el
el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
el_thursday <- as.matrix(el_thursday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_thursday, decreasing=FALSE)
SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
SN_thursday




######################################################


thursday_1 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)


summary(thursday_1)

thursday_1 <- simplify(thursday_1)
E(thursday_1)$weight



thursday_1 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)

summary(thursday_1)

thursday_1 <- simplify(thursday_1)
E(thursday_1)$weight



net=thursday_1
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_thursday <- graph.density(simplify(thursday_1), loops=FALSE)
centralization_thursday <- centralization.degree(thursday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_thursday <- reciprocity(thursday_1, ignore.loops = TRUE)

gs.inbound_thursday <- graph.strength(thursday_1, mode="in")
gs.outbound_thursday <- graph.strength(thursday_1, mode="out")




#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 thursday Survey 2


sender <-   elmk_2_f15_thursday [c("Sender_Final_ID")]
receiver <- elmk_2_f15_thursday [c("Receiver_Final_ID")]
weight <-   elmk_2_f15_thursday  [c("sn2")]


#labels_thursday <- sn_include_thursday$Sender_Final_ID 

labels_thursday <- sn_include_thursday_2$thursday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_thursday <- el
el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
el_thursday <- as.matrix(el_thursday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_thursday, decreasing=FALSE)
SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
SN_thursday




######################################################


thursday_2 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)


summary(thursday_2)

thursday_2 <- simplify(thursday_2)
E(thursday_2)$weight



thursday_2 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)

summary(thursday_2)

thursday_2 <- simplify(thursday_2)
E(thursday_2)$weight



net=thursday_2
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_thursday <- graph.density(simplify(thursday_2), loops=FALSE)
centralization_thursday <- centralization.degree(thursday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_thursday <- reciprocity(thursday_2, ignore.loops = TRUE)

gs.inbound_thursday <- graph.strength(thursday_2, mode="in")
gs.outbound_thursday <- graph.strength(thursday_2, mode="out")





#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 thursday Survey 3


sender <-   elmk_3_f15_thursday [c("Sender_Final_ID")]
receiver <- elmk_3_f15_thursday [c("Receiver_Final_ID")]
weight <-   elmk_3_f15_thursday  [c("sn2")]


#labels_thursday <- sn_include_thursday$Sender_Final_ID 

labels_thursday <- sn_include_thursday_3$thursday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_thursday <- el
el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
el_thursday <- as.matrix(el_thursday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_thursday, decreasing=FALSE)
SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
SN_thursday




######################################################


thursday_3 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)


summary(thursday_3)

thursday_3 <- simplify(thursday_3)
E(thursday_3)$weight



thursday_3 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)

summary(thursday_3)

thursday_3 <- simplify(thursday_3)
E(thursday_3)$weight



net=thursday_3
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_thursday <- graph.density(simplify(thursday_3), loops=FALSE)
centralization_thursday <- centralization.degree(thursday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_thursday <- reciprocity(thursday_3, ignore.loops = TRUE)

gs.inbound_thursday <- graph.strength(thursday_3, mode="in")
gs.outbound_thursday <- graph.strength(thursday_3, mode="out")



#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 thursday Survey 4


sender <-   elmk_4_f15_thursday [c("Sender_Final_ID")]
receiver <- elmk_4_f15_thursday [c("Receiver_Final_ID")]
weight <-   elmk_4_f15_thursday  [c("sn2")]


#labels_thursday <- sn_include_thursday$Sender_Final_ID 

labels_thursday <- sn_include_thursday_4$thursday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_thursday <- el
el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
el_thursday <- as.matrix(el_thursday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_thursday, decreasing=FALSE)
SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
SN_thursday




######################################################


thursday_4 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)


summary(thursday_4)

thursday_4 <- simplify(thursday_4)
E(thursday_4)$weight



thursday_4 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)

summary(thursday_4)

thursday_4 <- simplify(thursday_4)
E(thursday_4)$weight



net=thursday_4
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_thursday <- graph.density(simplify(thursday_4), loops=FALSE)
centralization_thursday <- centralization.degree(thursday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_thursday <- reciprocity(thursday_4, ignore.loops = TRUE)

gs.inbound_thursday <- graph.strength(thursday_4, mode="in")
gs.outbound_thursday <- graph.strength(thursday_4, mode="out")




#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 thursday Survey 5


sender <-   elmk_5_f15_thursday [c("Sender_Final_ID")]
receiver <- elmk_5_f15_thursday [c("Receiver_Final_ID")]
weight <-   elmk_5_f15_thursday  [c("sn2")]


#labels_thursday <- sn_include_thursday$Sender_Final_ID 

labels_thursday <- sn_include_thursday_5$thursday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_thursday <- el
el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
el_thursday <- as.matrix(el_thursday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_thursday, decreasing=FALSE)
SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
SN_thursday




######################################################


thursday_5 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)


summary(thursday_5)

thursday_5 <- simplify(thursday_5)
E(thursday_5)$weight



thursday_5 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = TRUE, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)

summary(thursday_5)

thursday_5 <- simplify(thursday_5)
E(thursday_5)$weight



net=thursday_5
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/10)

#GETTING SOCIAL NETWORK STATISTICS

density_thursday <- graph.density(simplify(thursday_5), loops=FALSE)
centralization_thursday <- centralization.degree(thursday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_thursday <- reciprocity(thursday_5, ignore.loops = TRUE)

gs.inbound_thursday <- graph.strength(thursday_5, mode="in")
gs.outbound_thursday <- graph.strength(thursday_5, mode="out")
