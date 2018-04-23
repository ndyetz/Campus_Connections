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
#install.packages("networkD3")
#install.packages("tidyverse")

library(CTT)
library(GGally)
library(ggplot2)
library(lattice)
library(gridExtra)
library(reshape)
library(igraph)
#library(dplyr)
#library(tidyr)
library(networkD3)
library(reshape)
library("tidyverse")
#library(igraph)
library(statnet)

#Pulling in edgelists & SN Include files that were created using SAS


#kite <- make_graph("Krackhardt_Kite")
#V(kite)$eigen <- eigen_centrality(kite)

setwd("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA")


elm <- read_csv("Mentor.csv") 
elk <- read_csv("mentee.csv") 
sn_include<- read_csv("F15_SN_Include.csv", header = TRUE)

setwd("T:/Research folders/CCWTG/Analyses/Data for Stats Dept/FINAL DATA")

elmk <- read_csv("CC_edgelist.csv") 
youth_att <- read_csv("Mentee_Attributes.csv")
staff_att <- read_csv("Staff_Attributes_Final.csv")
staff_youth_att <- read_csv("staff_youth_att.csv")


#SN INCLUDE FILES

##Monday surveys

setwd("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA")

sn_include_f15_monday_1    <- read_csv("F15_SN_inc_mon_surv1.csv") 
sn_include_f15_monday_2    <- read_csv("F15_SN_inc_mon_surv2.csv") 
sn_include_f15_monday_3    <- read_csv("F15_SN_inc_mon_surv3.csv") 
sn_include_f15_monday_4    <- read_csv("F15_SN_inc_mon_surv4.csv") 
sn_include_f15_monday_5    <- read_csv("F15_SN_inc_mon_surv5.csv") 
##Tuesday _f15 surveys

sn_include_f15_tuesday_1    <- read_csv("F15_SN_inc_tue_surv1.csv")
sn_include_f15_tuesday_2    <- read_csv("F15_SN_inc_tue_surv2.csv")
sn_include_f15_tuesday_3    <- read_csv("F15_SN_inc_tue_surv3.csv")
sn_include_f15_tuesday_4    <- read_csv("F15_SN_inc_tue_surv4.csv")
sn_include_f15_tuesday_5    <- read_csv("F15_SN_inc_tue_surv5.csv")


##Wednesday _f15 surveys

sn_include_f15_wednesday_1    <- read_csv("F15_SN_inc_wed_surv1.csv")
sn_include_f15_wednesday_2    <- read_csv("F15_SN_inc_wed_surv2.csv")
sn_include_f15_wednesday_3    <- read_csv("F15_SN_inc_wed_surv3.csv")
sn_include_f15_wednesday_4    <- read_csv("F15_SN_inc_wed_surv4.csv")
sn_include_f15_wednesday_5    <- read_csv("F15_SN_inc_wed_surv5.csv")



##Monday _S16 surveys include
sn_include_s16_monday_1      <- read_csv("S16_SN_inc_mon_surv1.csv")
sn_include_s16_monday_2      <- read_csv("S16_SN_inc_mon_surv2.csv")
sn_include_s16_monday_3      <- read_csv("S16_SN_inc_mon_surv3.csv")
sn_include_s16_monday_4      <- read_csv("S16_SN_inc_mon_surv4.csv")
sn_include_s16_monday_5      <- read_csv("S16_SN_inc_mon_surv5.csv")
 
##Tuesday _s16 surveys 
 
sn_include_s16_tuesday_1     <- read_csv("S16_SN_inc_tue_surv1.csv")
sn_include_s16_tuesday_2     <- read_csv("S16_SN_inc_tue_surv2.csv")
sn_include_s16_tuesday_3     <- read_csv("S16_SN_inc_tue_surv3.csv")
sn_include_s16_tuesday_4     <- read_csv("S16_SN_inc_tue_surv4.csv")
sn_include_s16_tuesday_5     <- read_csv("S16_SN_inc_tue_surv5.csv")


##Wednesday s16 surveys

sn_include_s16_wednesday_1   <- read_csv("S16_SN_inc_wed_surv1.csv")
sn_include_s16_wednesday_2   <- read_csv("S16_SN_inc_wed_surv2.csv")
sn_include_s16_wednesday_3   <- read_csv("S16_SN_inc_wed_surv3.csv")
sn_include_s16_wednesday_4   <- read_csv("S16_SN_inc_wed_surv4.csv")
sn_include_s16_wednesday_5   <- read_csv("S16_SN_inc_wed_surv5.csv")




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
#remove moments the receiver was wassing
elmk_f15 <- subset(elmk_f15, Receiver_Missing == 0)
#remove moments sender was missing
elmk_f15 <- subset(elmk_f15, Sender_missing == 0)
#remove any chance of loops
elmk_f15 <- subset(elmk_f15, Receiver_Final_ID != Sender_Final_ID)


elmk_s16 <- subset(elmk, semester == "S16")
#remove moments the receiver was wassing
elmk_s16 <- subset(elmk_s16, Receiver_Missing == 0)
#remove moments sender was missing
elmk_s16 <- subset(elmk_s16, Sender_missing == 0)
#remove any chance of loops
elmk_s16 <- subset(elmk_s16, Receiver_Final_ID != Sender_Final_ID)


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

#sn1
#
#elmk_1_f15_monday <- elmk_1_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_2_f15_monday <- elmk_2_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_3_f15_monday <- elmk_3_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_4_f15_monday <- elmk_4_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_5_f15_monday <- elmk_5_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#
#
#elmk_1_s16_monday <- elmk_1_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_2_s16_monday <- elmk_2_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_3_s16_monday <- elmk_3_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_4_s16_monday <- elmk_4_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_5_s16_monday <- elmk_5_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#
#sn1

elmk_1_f16_monday <- elmk_1_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_f16_monday <- elmk_2_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_f16_monday <- elmk_3_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_f16_monday <- elmk_4_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_f16_monday <- elmk_5_f15_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]

elmk_1_s16_monday <- elmk_1_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_s16_monday <- elmk_2_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_s16_monday <- elmk_3_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_s16_monday <- elmk_4_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_s16_monday <- elmk_5_s16_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]




#Tueday edgelist surveys 1-5

#sn2
#
#elmk_1_f15_tuesday <- elmk_1_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_2_f15_tuesday <- elmk_2_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_3_f15_tuesday <- elmk_3_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_4_f15_tuesday <- elmk_4_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_5_f15_tuesday <- elmk_5_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#
#
#elmk_1_s16_tuesday <- elmk_1_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_2_s16_tuesday <- elmk_2_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_3_s16_tuesday <- elmk_3_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_4_s16_tuesday <- elmk_4_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_5_s16_tuesday <- elmk_5_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#

#sn1

elmk_1_f16_tuesday <- elmk_1_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_f16_tuesday <- elmk_2_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_f16_tuesday <- elmk_3_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_f16_tuesday <- elmk_4_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_f16_tuesday <- elmk_5_f15_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]

elmk_1_s16_tuesday <- elmk_1_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_s16_tuesday <- elmk_2_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_s16_tuesday <- elmk_3_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_s16_tuesday <- elmk_4_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_s16_tuesday <- elmk_5_s16_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]


#Wednesday edgelist surveys 1-5

#elmk_1_f15_wednesday <- elmk_1_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_2_f15_wednesday <- elmk_2_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_3_f15_wednesday <- elmk_3_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_4_f15_wednesday <- elmk_4_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_5_f15_wednesday <- elmk_5_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#
#
#elmk_1_s16_wednesday <- elmk_1_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_2_s16_wednesday <- elmk_2_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_3_s16_wednesday <- elmk_3_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_4_s16_wednesday <- elmk_4_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_5_s16_wednesday <- elmk_5_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#

#sn1
elmk_1_f16_wednesday <- elmk_1_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_f16_wednesday <- elmk_2_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_f16_wednesday <- elmk_3_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_f16_wednesday <- elmk_4_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_f16_wednesday <- elmk_5_f15_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]

elmk_1_s16_wednesday <- elmk_1_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_s16_wednesday <- elmk_2_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_s16_wednesday <- elmk_3_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_s16_wednesday <- elmk_4_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_s16_wednesday <- elmk_5_s16_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]


#Thursday edgelist surveys 1-5
#
#elmk_1_f15_thursday <- elmk_1_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_2_f15_thursday <- elmk_2_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_3_f15_thursday <- elmk_3_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_4_f15_thursday <- elmk_4_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_5_f15_thursday <- elmk_5_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#
#
#elmk_1_s16_thursday <- elmk_1_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_2_s16_thursday <- elmk_2_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_3_s16_thursday <- elmk_3_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_4_s16_thursday <- elmk_4_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#elmk_5_s16_thursday <- elmk_5_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn2")]
#

#sn1

elmk_1_f16_thursday <- elmk_1_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_f16_thursday <- elmk_2_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_f16_thursday <- elmk_3_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_f16_thursday <- elmk_4_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_f16_thursday <- elmk_5_f15_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]

elmk_1_s16_thursday <- elmk_1_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_s16_thursday <- elmk_2_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_s16_thursday <- elmk_3_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_s16_thursday <- elmk_4_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_s16_thursday <- elmk_5_s16_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]



#REPLACING NA's WITH 0's

#Monday


elmk_1_f15_monday[["sn1"]][is.na(elmk_1_f15_monday[["sn1"]])] <- 0
elmk_2_f15_monday[["sn1"]][is.na(elmk_2_f15_monday[["sn1"]])] <- 0
elmk_3_f15_monday[["sn1"]][is.na(elmk_3_f15_monday[["sn1"]])] <- 0
elmk_4_f15_monday[["sn1"]][is.na(elmk_4_f15_monday[["sn1"]])] <- 0
elmk_5_f15_monday[["sn1"]][is.na(elmk_5_f15_monday[["sn1"]])] <- 0


elmk_1_s16_monday[["sn1"]][is.na(elmk_1_s16_monday[["sn1"]])] <- 0
elmk_2_s16_monday[["sn1"]][is.na(elmk_2_s16_monday[["sn1"]])] <- 0
elmk_3_s16_monday[["sn1"]][is.na(elmk_3_s16_monday[["sn1"]])] <- 0
elmk_4_s16_monday[["sn1"]][is.na(elmk_4_s16_monday[["sn1"]])] <- 0
elmk_5_s16_monday[["sn1"]][is.na(elmk_5_s16_monday[["sn1"]])] <- 0
#Tuesday

elmk_1_f15_tuesday[["sn1"]][is.na(elmk_1_f15_tuesday[["sn1"]])] <- 0
elmk_2_f15_tuesday[["sn1"]][is.na(elmk_2_f15_tuesday[["sn1"]])] <- 0
elmk_3_f15_tuesday[["sn1"]][is.na(elmk_3_f15_tuesday[["sn1"]])] <- 0
elmk_4_f15_tuesday[["sn1"]][is.na(elmk_4_f15_tuesday[["sn1"]])] <- 0
elmk_5_f15_tuesday[["sn1"]][is.na(elmk_5_f15_tuesday[["sn1"]])] <- 0


elmk_1_s16_tuesday[["sn1"]][is.na(elmk_1_s16_tuesday[["sn1"]])] <- 0
elmk_2_s16_tuesday[["sn1"]][is.na(elmk_2_s16_tuesday[["sn1"]])] <- 0
elmk_3_s16_tuesday[["sn1"]][is.na(elmk_3_s16_tuesday[["sn1"]])] <- 0
elmk_4_s16_tuesday[["sn1"]][is.na(elmk_4_s16_tuesday[["sn1"]])] <- 0
elmk_5_s16_tuesday[["sn1"]][is.na(elmk_5_s16_tuesday[["sn1"]])] <- 0


#Wednesday

elmk_1_f15_wednesday[["sn1"]][is.na(elmk_1_f15_wednesday[["sn1"]])] <- 0
elmk_2_f15_wednesday[["sn1"]][is.na(elmk_2_f15_wednesday[["sn1"]])] <- 0
elmk_3_f15_wednesday[["sn1"]][is.na(elmk_3_f15_wednesday[["sn1"]])] <- 0
elmk_4_f15_wednesday[["sn1"]][is.na(elmk_4_f15_wednesday[["sn1"]])] <- 0
elmk_5_f15_wednesday[["sn1"]][is.na(elmk_5_f15_wednesday[["sn1"]])] <- 0

elmk_1_s16_wednesday[["sn1"]][is.na(elmk_1_s16_wednesday[["sn1"]])] <- 0
elmk_2_s16_wednesday[["sn1"]][is.na(elmk_2_s16_wednesday[["sn1"]])] <- 0
elmk_3_s16_wednesday[["sn1"]][is.na(elmk_3_s16_wednesday[["sn1"]])] <- 0
elmk_4_s16_wednesday[["sn1"]][is.na(elmk_4_s16_wednesday[["sn1"]])] <- 0
elmk_5_s16_wednesday[["sn1"]][is.na(elmk_5_s16_wednesday[["sn1"]])] <- 0


#Thursday


elmk_1_f15_thursday[["sn1"]][is.na(elmk_1_f15_thursday[["sn1"]])] <- 0
elmk_2_f15_thursday[["sn1"]][is.na(elmk_2_f15_thursday[["sn1"]])] <- 0
elmk_3_f15_thursday[["sn1"]][is.na(elmk_3_f15_thursday[["sn1"]])] <- 0
elmk_4_f15_thursday[["sn1"]][is.na(elmk_4_f15_thursday[["sn1"]])] <- 0
elmk_5_f15_thursday[["sn1"]][is.na(elmk_5_f15_thursday[["sn1"]])] <- 0

elmk_1_s16_thursday[["sn1"]][is.na(elmk_1_s16_thursday[["sn1"]])] <- 0
elmk_2_s16_thursday[["sn1"]][is.na(elmk_2_s16_thursday[["sn1"]])] <- 0
elmk_3_s16_thursday[["sn1"]][is.na(elmk_3_s16_thursday[["sn1"]])] <- 0
elmk_4_s16_thursday[["sn1"]][is.na(elmk_4_s16_thursday[["sn1"]])] <- 0
elmk_5_s16_thursday[["sn1"]][is.na(elmk_5_s16_thursday[["sn1"]])] <- 0





##elmk_1_f15_monday$new < -elmk_1_f15_monday$new[which(elmk_1_f15_monday$sn1 == 1)] <- elmk_1_f15_monday$new[which(elmk_1_f15_monday$sn1 == 1)]
#
##if (expression1)   # If expression1 is true ...
# # block1      # ...run this block of code.
#
#
#newdata <- subset(elmk_1_f15_monday, sn1==1)
#
#newdata <- newdata[c("Sender_Final_ID","Receiver_Final_ID")]
#
#names(sn_include_f15_monday_1)[names(sn_include_f15_monday_1) == 'monday'] <- 'Sender_Final_ID'
#
#sn_include_f15_monday_1$Receiver_Final_ID <- NA
#
#newdata <- rbind(newdata, sn_include_f15_monday_1)


#names(df)[names(df) == 'old.var.name'] <- 'new.var.name'


##newdata<- merge(newdata, sn_include_f15_monday_1, 
#                              by.newdata=c("Sender_Final_ID"),
#                              by.sn_include_f15_monday_1=c("monday"), 
#                              all=TRUE)



#simpleNetwork(newdata)


#######################################################################################################################
#################################CREATING SN GRAPHS####################################################################
#############################AND GETTING Network Measures #############################################################
#######################################################################################################################
#######################################################################################################################
#######################################################################################################################



#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 1


sender <-   elmk_1_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_1_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_1_f15_monday  [c("sn1")]


#labels_monday <- sn_include_f15_monday$Sender_Final_ID 

labels_monday <- sn_include_f15_monday_1$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(NA, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday

#write.table(SN_monday, file="ERGM_Test.txt", row.names=FALSE, col.names=FALSE)

#Gettign Bonacichs approach of actor power
#
#actpower <- bonpow(SN_monday, g=1, nodes=NULL, gmode="digraph", diag=FALSE,
#                   tmaxdev=FALSE, exponent=1, rescale=FALSE, tol=1e-07)
#actpower1 <- as.data.frame(actpower)
#

######################################################


monday_1 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                            add.colnames = NULL, add.rownames = NA)


summary(monday_1)

#monday_1 <- simplify(monday_1)
#E(monday_1)$weight



monday_1 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                         add.colnames = NULL, add.rownames = NA)

summary(monday_1)

#monday_1 <- simplify(monday_1)
#E(monday_1)$weight



net=monday_1
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1



V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","red",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green



plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=10,
            edge.arrow.size = 0.5, edge.color="black", vertex.shape=V(net)$shape,edge.width=E(net)$weight)




#
#plot.igraph(net, layout= layout.fruchterman.reingold, edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size= 20,
#            edge.arrow.size = 1.5, edge.color="black", edge.width=E(net)$weight)
#
#plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#           edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_1), loops=FALSE)
centralization_monday <- centralization.degree(monday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_1, ignore.loops = TRUE)

gs.inbound_1  <- graph.strength(monday_1, mode="in")
gs.outbound_1 <- graph.strength(monday_1, mode="out")


 inbound_f15_mon1  <- as.data.frame(gs.inbound_1)
outbound_f15_mon1  <- as.data.frame(gs.outbound_1)

######calculating eigenvector centrality scores

eigen <- eigen_centrality(net, directed=T, weights=NA, scale=T)

#put ego eigenvector centrality scores into a dataframe

eigen <- as.data.frame(eigen)

#convert rownames into Final_ID

eigen <- add_rownames(eigen, "Final_ID")

eigen_f15_mon1=eigen



#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_mon1$maxn <- ((nrow(inbound_f15_mon1))-1)*10
inbound_f15_mon1$gs.inbound1_norm <- inbound_f15_mon1$gs.inbound_1/inbound_f15_mon1$maxn

#outbound
outbound_f15_mon1$maxn <- ((nrow(outbound_f15_mon1))-1)*10
outbound_f15_mon1$gs.outbound1_norm <- outbound_f15_mon1$gs.outbound_1/outbound_f15_mon1$maxn

#putting Fiunal_ID as a column
inbound_f15_mon1$Final_ID = rownames(inbound_f15_mon1)
outbound_f15_mon1$Final_ID = rownames(outbound_f15_mon1)


centralization_monday1 <- as.data.frame(centralization_monday)


centralization_monday1 <- as.data.frame(centralization_monday)


write.csv(SN_monday, file = "F15_Mon1.csv",row.names=TRUE, na="")


#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 2


sender <-   elmk_2_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_2_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_2_f15_monday  [c("sn1")]


#labels_monday <- sn_include_f15_monday$Sender_Final_ID 

labels_monday <- sn_include_f15_monday$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(NA, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday


#ergm_test <-SN_monday[SN_monday == 0] <- 1
#ergm_test <-SN_monday[is.na(SN_monday)] <- 0




#write.table(SN_monday, file="ERGM_Test68.txt", row.names=FALSE, col.names=FALSE)

#
#
#actpower <- bonpow(SN_monday, g=1, nodes=NULL, gmode="digraph", diag=FALSE,
#                   tmaxdev=FALSE, exponent=1, rescale=FALSE, tol=1e-07)
#actpower2 <- as.data.frame(actpower)
#


######################################################


monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_2)

monday_2 <- simplify(monday_2)
E(monday_2)$weight



monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
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






V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","red",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=10,
            edge.arrow.size = 0.5, edge.color="black",edge.width=E(net)$weight/5)

#plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=10,
#            edge.arrow.size = 0.5, edge.color="black",edge.width=E(net)$weight/5)




V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_2), loops=FALSE)
centralization_monday <- centralization.degree(monday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_2, ignore.loops = TRUE)

gs.inbound_2  <- graph.strength(monday_2, mode="in")
gs.outbound_2 <- graph.strength(monday_2, mode="out")



inbound_f15_mon2  <- as.data.frame(gs.inbound_2)
outbound_f15_mon2  <- as.data.frame(gs.outbound_2)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_mon2$maxn <- ((nrow(inbound_f15_mon2))-1)*10
inbound_f15_mon2$gs.inbound2_norm <- inbound_f15_mon2$gs.inbound_2/inbound_f15_mon2$maxn

#outbound
outbound_f15_mon2$maxn <- ((nrow(outbound_f15_mon2))-1)*10
outbound_f15_mon2$gs.outbound2_norm <- outbound_f15_mon2$gs.outbound_2/outbound_f15_mon2$maxn

#putting Fiunal_ID as a column
inbound_f15_mon2$Final_ID = rownames(inbound_f15_mon2)
outbound_f15_mon2$Final_ID = rownames(outbound_f15_mon2)

centralization_monday <- as.data.frame(centralization_monday)


######calculating eigenvector centrality scores

eigen <- eigen_centrality(net, directed=T, weights=NA, scale=T)

#put ego eigenvector centrality scores into a dataframe

eigen <- as.data.frame(eigen)

#convert rownames into Final_ID

eigen <- add_rownames(eigen, "Final_ID")

eigen_f15_mon2=eigen






write.csv(SN_monday, file = "F15_Mon2.csv",row.names=TRUE, na="")

#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 3


sender <-   elmk_3_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_3_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_3_f15_monday  [c("sn1")]


#labels_monday <- sn_include_f15_monday$Sender_Final_ID 

labels_monday <- sn_include_f15_monday$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(NA, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday


##### Just doing this for later. 
#write.table(SN_monday,"test.txt",row.names=FALSE, col.names=FALSE)



######################################################


monday_3 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_3)

monday_3 <- simplify(monday_3)
E(monday_3)$weight



monday_3 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
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







#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 2


sender <-   elmk_2_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_2_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_2_f15_monday  [c("sn1")]


#labels_monday <- sn_include_f15_monday$Sender_Final_ID 

labels_monday <- sn_include_f15_monday$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(NA, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday


#ergm_test <-SN_monday[SN_monday == 0] <- 1
#ergm_test <-SN_monday[is.na(SN_monday)] <- 0




#write.table(SN_monday, file="ERGM_Test68.txt", row.names=FALSE, col.names=FALSE)



actpower <- bonpow(SN_monday, g=1, nodes=NULL, gmode="digraph", diag=FALSE,
                   tmaxdev=FALSE, exponent=1, rescale=FALSE, tol=1e-07)
actpower2 <- as.data.frame(actpower)



######################################################


monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_2)

monday_2 <- simplify(monday_2)
E(monday_2)$weight



monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
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






V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","red",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)






V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_3), loops=FALSE)
centralization_monday <- centralization.degree(monday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_3, ignore.loops = TRUE)


gs.inbound_3  <- graph.strength(monday_3, mode="in")
gs.outbound_3 <- graph.strength(monday_3, mode="out")




inbound_f15_mon3  <- as.data.frame(gs.inbound_3)
outbound_f15_mon3  <- as.data.frame(gs.outbound_3)




######calculating eigenvector centrality scores

eigen <- eigen_centrality(net, directed=T, weights=NA, scale=T)

#put ego eigenvector centrality scores into a dataframe

eigen <- as.data.frame(eigen)

#convert rownames into Final_ID

eigen <- add_rownames(eigen, "Final_ID")

eigen_f15_mon3=eigen



#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_mon3$maxn <- ((nrow(inbound_f15_mon3))-1)*10
inbound_f15_mon3$gs.inbound3_norm <- inbound_f15_mon3$gs.inbound_3/inbound_f15_mon3$maxn

#outbound
outbound_f15_mon3$maxn <- ((nrow(outbound_f15_mon3))-1)*10
outbound_f15_mon3$gs.outbound3_norm <- outbound_f15_mon3$gs.outbound_3/outbound_f15_mon3$maxn

#putting Fiunal_ID as a column
inbound_f15_mon3$Final_ID = rownames(inbound_f15_mon3)
outbound_f15_mon3$Final_ID = rownames(outbound_f15_mon3)

centralization_monday <- as.data.frame(centralization_monday)


write.csv(SN_monday, file = "F15_Mon1.csv",row.names=TRUE, na="")

#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 4


sender <-   elmk_4_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_4_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_4_f15_monday  [c("sn1")]


#labels_monday <- sn_include_f15_monday$Sender_Final_ID 

labels_monday <- sn_include_f15_monday$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(NA, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday

write.csv(SN_monday, file = "SN_Mon4.csv",row.names=TRUE, na="")


######################################################


monday_4 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_4)

monday_4 <- simplify(monday_4)
E(monday_4)$weight



monday_4 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
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




#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 2


sender <-   elmk_2_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_2_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_2_f15_monday  [c("sn1")]


#labels_monday <- sn_include_f15_monday$Sender_Final_ID 

labels_monday <- sn_include_f15_monday$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(NA, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday


#ergm_test <-SN_monday[SN_monday == 0] <- 1
#ergm_test <-SN_monday[is.na(SN_monday)] <- 0




#write.table(SN_monday, file="ERGM_Test68.txt", row.names=FALSE, col.names=FALSE)



actpower <- bonpow(SN_monday, g=1, nodes=NULL, gmode="digraph", diag=FALSE,
                   tmaxdev=FALSE, exponent=1, rescale=FALSE, tol=1e-07)
actpower2 <- as.data.frame(actpower)



######################################################


monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_2)

monday_2 <- simplify(monday_2)
E(monday_2)$weight



monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
V(net)$vertex_degree <-  degree(net)





V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","red",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)




plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#Adding vertex size based on degree

plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size= V(net)$vertex_degree,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

tkplot(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size= V(net)$vertex_degree,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_4), loops=FALSE)
centralization_monday <- centralization.degree(monday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_4, ignore.loops = TRUE)


gs.inbound_4  <- graph.strength(monday_4, mode="in")
gs.outbound_4 <- graph.strength(monday_4, mode="out")




inbound_f15_mon4  <- as.data.frame(gs.inbound_4)
outbound_f15_mon4  <- as.data.frame(gs.outbound_4)



######calculating eigenvector centrality scores

eigen <- eigen_centrality(net, directed=T, weights=NA, scale=T)

#put ego eigenvector centrality scores into a dataframe

eigen <- as.data.frame(eigen)

#convert rownames into Final_ID

eigen <- add_rownames(eigen, "Final_ID")

eigen_f15_mon4=eigen



#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_mon4$maxn <- ((nrow(inbound_f15_mon4))-1)*10
inbound_f15_mon4$gs.inbound4_norm <- inbound_f15_mon4$gs.inbound_4/inbound_f15_mon4$maxn

#outbound
outbound_f15_mon4$maxn <- ((nrow(outbound_f15_mon4))-1)*10
outbound_f15_mon4$gs.outbound4_norm <- outbound_f15_mon4$gs.outbound_4/outbound_f15_mon4$maxn

#putting Fiunal_ID as a column
inbound_f15_mon4$Final_ID = rownames(inbound_f15_mon4)
outbound_f15_mon4$Final_ID = rownames(outbound_f15_mon4)

centralization_monday <- as.data.frame(centralization_monday)

write.csv(SN_monday, file = "F15_Mon1.csv",row.names=TRUE, na="")


#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 5


sender <-   elmk_5_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_5_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_5_f15_monday  [c("sn1")]


#labels_monday <- sn_include_f15_monday$Sender_Final_ID 

labels_monday <- sn_include_f15_monday$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(NA, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday


write.table(SN_monday, file="SN_mon_4.txt", row.names=FALSE, col.names=FALSE)



######################################################


monday_5 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_5)

monday_5 <- simplify(monday_5)
E(monday_5)$weight



monday_5 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
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







a=staff_youth_att
V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1
V(net)$vertex_degree <-  degree(net)





V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","red",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net, vertex.label = NA, layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=5,
            edge.arrow.size = 0.5, edge.color="black",edge.width=E(net)$weight/5)




#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 2


sender <-   elmk_2_f15_monday [c("Sender_Final_ID")]
receiver <- elmk_2_f15_monday [c("Receiver_Final_ID")]
weight <-   elmk_2_f15_monday  [c("sn1")]


#labels_monday <- sn_include_f15_monday$Sender_Final_ID 

labels_monday <- sn_include_f15_monday$monday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_monday <- el
el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
el_monday <- as.matrix(el_monday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(NA, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday


#ergm_test <-SN_monday[SN_monday == 0] <- 1
#ergm_test <-SN_monday[is.na(SN_monday)] <- 0




#write.table(SN_monday, file="ERGM_Test68.txt", row.names=FALSE, col.names=FALSE)



actpower <- bonpow(SN_monday, g=1, nodes=NULL, gmode="digraph", diag=FALSE,
                   tmaxdev=FALSE, exponent=1, rescale=FALSE, tol=1e-07)
actpower2 <- as.data.frame(actpower)



######################################################


monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(monday_2)

monday_2 <- simplify(monday_2)
E(monday_2)$weight



monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
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






V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","red",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)





V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_5), loops=FALSE)
centralization_monday <- centralization.degree(monday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_5, ignore.loops = TRUE)


gs.inbound_5  <- graph.strength(monday_5, mode="in")
gs.outbound_5 <- graph.strength(monday_5, mode="out")




inbound_f15_mon5  <- as.data.frame(gs.inbound_5)
outbound_f15_mon5  <- as.data.frame(gs.outbound_5)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_mon5$maxn <- ((nrow(inbound_f15_mon5))-1)*10
inbound_f15_mon5$gs.inbound5_norm <- inbound_f15_mon5$gs.inbound_5/inbound_f15_mon5$maxn

#outbound
outbound_f15_mon5$maxn <- ((nrow(outbound_f15_mon5))-1)*10
outbound_f15_mon5$gs.outbound5_norm <- outbound_f15_mon5$gs.outbound_5/outbound_f15_mon5$maxn

#putting Fiunal_ID as a column
inbound_f15_mon5$Final_ID = rownames(inbound_f15_mon5)
outbound_f15_mon5$Final_ID = rownames(outbound_f15_mon5)

centralization_monday <- as.data.frame(centralization_monday)





######calculating eigenvector centrality scores

eigen <- eigen_centrality(net, directed=T, weights=NA, scale=T)

#put ego eigenvector centrality scores into a dataframe

eigen <- as.data.frame(eigen)

#convert rownames into Final_ID

eigen <- add_rownames(eigen, "Final_ID")

eigen_f15_mon5=eigen






write.csv(SN_monday, file = "F15_Mon1.csv",row.names=TRUE, na="")

#
#
###########################Fall '15 Tuesday
#
#############Survey 1 Fall '15 Tuesday
#
#
#sender <-   elmk_1_f15_tuesday [c("Sender_Final_ID")]
#receiver <- elmk_1_f15_tuesday [c("Receiver_Final_ID")]
#weight <-   elmk_1_f15_tuesday  [c("sn1")]
#
#
##labels_tuesday <- sn_include_f15_tuesday$Sender_Final_ID 
#
#labels_tuesday <- sn_include_f15_tuesday_1$tuesday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_tuesday <- el
#el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
#el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
#el_tuesday <- as.matrix(el_tuesday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_tuesday, decreasing=FALSE)
#SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
#rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
#SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
#SN_tuesday
#
#
#
#
#######################################################
#
#
#tuesday_1 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(tuesday_1)
#
#tuesday_1 <- simplify(tuesday_1)
#E(tuesday_1)$weight
#
#
#
#tuesday_1 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(tuesday_1)
#
#tuesday_1 <- simplify(tuesday_1)
#E(tuesday_1)$weight
#
#
#
#net=tuesday_1
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_tuesday <- graph.density(simplify(tuesday_1), loops=FALSE)
#centralization_tuesday <- centralization.degree(tuesday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_tuesday <- reciprocity(tuesday_1, ignore.loops = TRUE)
#
#gs.inbound_tuesday <- graph.strength(tuesday_1, mode="in")
#gs.outbound_tuesday <- graph.strength(tuesday_1, mode="out")
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 tuesday Survey 2
#
#
#sender <-   elmk_2_f15_tuesday [c("Sender_Final_ID")]
#receiver <- elmk_2_f15_tuesday [c("Receiver_Final_ID")]
#weight <-   elmk_2_f15_tuesday  [c("sn1")]
#
#
##labels_tuesday <- sn_include_f15_tuesday$Sender_Final_ID 
#
#labels_tuesday <- sn_include_f15_tuesday_2$tuesday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_tuesday <- el
#el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
#el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
#el_tuesday <- as.matrix(el_tuesday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_tuesday, decreasing=FALSE)
#SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
#rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
#SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
#SN_tuesday
#
#
#
#
#######################################################
#
#
#tuesday_2 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(tuesday_2)
#
#tuesday_2 <- simplify(tuesday_2)
#E(tuesday_2)$weight
#
#
#
#tuesday_2 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(tuesday_2)
#
#tuesday_2 <- simplify(tuesday_2)
#E(tuesday_2)$weight
#
#
#
#net=tuesday_2
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_tuesday <- graph.density(simplify(tuesday_2), loops=FALSE)
#centralization_tuesday <- centralization.degree(tuesday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_tuesday <- reciprocity(tuesday_2, ignore.loops = TRUE)
#
#gs.inbound_tuesday <- graph.strength(tuesday_2, mode="in")
#gs.outbound_tuesday <- graph.strength(tuesday_2, mode="out")
#
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 tuesday Survey 3
#
#
#sender <-   elmk_3_f15_tuesday [c("Sender_Final_ID")]
#receiver <- elmk_3_f15_tuesday [c("Receiver_Final_ID")]
#weight <-   elmk_3_f15_tuesday  [c("sn1")]
#
#
##labels_tuesday <- sn_include_f15_tuesday$Sender_Final_ID 
#
#labels_tuesday <- sn_include_f15_tuesday_3$tuesday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_tuesday <- el
#el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
#el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
#el_tuesday <- as.matrix(el_tuesday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_tuesday, decreasing=FALSE)
#SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
#rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
#SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
#SN_tuesday
#
#
#
#
#######################################################
#
#
#tuesday_3 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(tuesday_3)
#
#tuesday_3 <- simplify(tuesday_3)
#E(tuesday_3)$weight
#
#
#
#tuesday_3 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(tuesday_3)
#
#tuesday_3 <- simplify(tuesday_3)
#E(tuesday_3)$weight
#
#
#
#net=tuesday_3
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_tuesday <- graph.density(simplify(tuesday_3), loops=FALSE)
#centralization_tuesday <- centralization.degree(tuesday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_tuesday <- reciprocity(tuesday_3, ignore.loops = TRUE)
#
#gs.inbound_tuesday <- graph.strength(tuesday_3, mode="in")
#gs.outbound_tuesday <- graph.strength(tuesday_3, mode="out")
#
#
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 tuesday Survey 4
#
#
#sender <-   elmk_4_f15_tuesday [c("Sender_Final_ID")]
#receiver <- elmk_4_f15_tuesday [c("Receiver_Final_ID")]
#weight <-   elmk_4_f15_tuesday  [c("sn1")]
#
#
##labels_tuesday <- sn_include_f15_tuesday$Sender_Final_ID 
#
#labels_tuesday <- sn_include_f15_tuesday_4$tuesday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_tuesday <- el
#el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
#el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
#el_tuesday <- as.matrix(el_tuesday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_tuesday, decreasing=FALSE)
#SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
#rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
#SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
#SN_tuesday
#
#
#
#
#######################################################
#
#
#tuesday_4 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(tuesday_4)
#
#tuesday_4 <- simplify(tuesday_4)
#E(tuesday_4)$weight
#
#
#
#tuesday_4 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(tuesday_4)
#
#tuesday_4 <- simplify(tuesday_4)
#E(tuesday_4)$weight
#
#
#
#net=tuesday_4
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_tuesday <- graph.density(simplify(tuesday_4), loops=FALSE)
#centralization_tuesday <- centralization.degree(tuesday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_tuesday <- reciprocity(tuesday_4, ignore.loops = TRUE)
#
#gs.inbound_tuesday <- graph.strength(tuesday_4, mode="in")
#gs.outbound_tuesday <- graph.strength(tuesday_4, mode="out")
#
#
#
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 tuesday Survey 5
#
#
#sender <-   elmk_5_f15_tuesday [c("Sender_Final_ID")]
#receiver <- elmk_5_f15_tuesday [c("Receiver_Final_ID")]
#weight <-   elmk_5_f15_tuesday  [c("sn1")]
#
#
##labels_tuesday <- sn_include_f15_tuesday$Sender_Final_ID 
#
#labels_tuesday <- sn_include_f15_tuesday_5$tuesday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_tuesday <- el
#el_tuesday <- el_tuesday[is.element(el_tuesday$Sender_Final_ID, labels_tuesday),]
#el_tuesday <- el_tuesday[is.element(el_tuesday$Receiver_Final_ID, labels_tuesday),]
#el_tuesday <- as.matrix(el_tuesday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_tuesday, decreasing=FALSE)
#SN_tuesday <- matrix(0, length(labels_tuesday), length(labels_tuesday))
#rownames(SN_tuesday) <- colnames(SN_tuesday) <- labels_tuesday
#SN_tuesday[el_tuesday[,1:2]] <- as.numeric(el_tuesday[,3])
#SN_tuesday
#
#
#
#
#######################################################
#
#
#tuesday_5 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(tuesday_5)
#
#tuesday_5 <- simplify(tuesday_5)
#E(tuesday_5)$weight
#
#
#
#tuesday_5 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(tuesday_5)
#
#tuesday_5 <- simplify(tuesday_5)
#E(tuesday_5)$weight
#
#
#
#net=tuesday_5
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_tuesday <- graph.density(simplify(tuesday_5), loops=FALSE)
#centralization_tuesday <- centralization.degree(tuesday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_tuesday <- reciprocity(tuesday_5, ignore.loops = TRUE)
#
#gs.inbound_tuesday <- graph.strength(tuesday_5, mode="in")
#gs.outbound_tuesday <- graph.strength(tuesday_5, mode="out")
#






###################FAll '15 Wednesday -CONTROL NIGHT


#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 WEDNESDAY Survey 1


sender <-   elmk_1_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_1_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_1_f15_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_f15_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_f15_wednesday_1$wednesday 

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



wednesday_1 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)

summary(wednesday_1)

wednesday_1 <- simplify(wednesday_1)
E(wednesday_1)$weight



net=wednesday_1
# show the names of the vertices you just imported:
V(net)$name


a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
V(net)$role1

#V(net)$shape[gender] <- "rectangle"
#V(g)[V(g)$ethnic=="Saraguro"]$shape <- "circle"


#V(net)$color=V(net)$name
#V(net)$color=gsub("MCCF15_1063","red",V(net)$color)
#V(net)$color=gsub("KCCF15_1063","blue",V(net)$color)


#V(net)$shape=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$shape=gsub("0","square",V(net)$shape) #Females will be red
#V(net)$shape=gsub("1","circle",V(net)$shape) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue





plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=10,
            edge.arrow.size = 0.5, edge.color="black", vertex.shape=V(net)$shape,edge.width=E(net)$weight)



tkplot(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=10,
       edge.arrow.size = 0.5, edge.color="black", vertex.shape=V(net)$shape, edge.width=E(net)$weight)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_1), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_1, ignore.loops = TRUE)


gs.inbound_1  <- graph.strength(wednesday_1, mode="in")
gs.outbound_1 <- graph.strength(wednesday_1, mode="out")




inbound_f15_wed1  <- as.data.frame(gs.inbound_1)
outbound_f15_wed1  <- as.data.frame(gs.outbound_1)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_wed1$maxn <- ((nrow(inbound_f15_wed1))-1)*10
inbound_f15_wed1$gs.inbound1_norm <- inbound_f15_wed1$gs.inbound_1/inbound_f15_wed1$maxn

#outbound
outbound_f15_wed1$maxn <- ((nrow(outbound_f15_wed1))-1)*10
outbound_f15_wed1$gs.outbound1_norm <- outbound_f15_wed1$gs.outbound_1/outbound_f15_wed1$maxn

#putting Fiunal_ID as a column
inbound_f15_wed1$Final_ID = rownames(inbound_f15_wed1)
outbound_f15_wed1$Final_ID = rownames(outbound_f15_wed1)

centralization_wednesday <- as.data.frame(centralization_wednesday)

write.csv(SN_wednesday, file = "F15_Wednesday1.csv",row.names=TRUE, na="")


#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 2


sender <-   elmk_2_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_2_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_2_f15_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_f15_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_f15_wednesday_2$wednesday 

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



wednesday_2 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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






V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue


simplify(net)

plot.igraph(net,  vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=10,
            edge.arrow.size = 0.5, edge.color="black", vertex.shape=V(net)$shape,edge.width=E(net)$weight/5)


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_2), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_2, ignore.loops = TRUE)

gs.inbound_2  <- graph.strength(wednesday_2, mode="in")
gs.outbound_2 <- graph.strength(wednesday_2, mode="out")




inbound_f15_wed2  <- as.data.frame(gs.inbound_2)
outbound_f15_wed2  <- as.data.frame(gs.outbound_2)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_wed2$maxn <- ((nrow(inbound_f15_wed2))-1)*10
inbound_f15_wed2$gs.inbound2_norm <- inbound_f15_wed2$gs.inbound_2/inbound_f15_wed2$maxn

#outbound
outbound_f15_wed2$maxn <- ((nrow(outbound_f15_wed2))-1)*10
outbound_f15_wed2$gs.outbound2_norm <- outbound_f15_wed2$gs.outbound_2/outbound_f15_wed2$maxn

#putting Fiunal_ID as a column
inbound_f15_wed2$Final_ID = rownames(inbound_f15_wed2)
outbound_f15_wed2$Final_ID = rownames(outbound_f15_wed2)

centralization_wednesday <- as.data.frame(centralization_wednesday)

write.csv(SN_wednesday, file = "F15_Wednesday2.csv",row.names=TRUE, na="")

#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 3


sender <-   elmk_3_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_3_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_3_f15_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_f15_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_f15_wednesday_3$wednesday 

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



wednesday_3 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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





V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue




plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=10,
            edge.arrow.size = 0.5, edge.color="black", vertex.shape=V(net)$shape,edge.width=E(net)$weight/5)



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_3), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_3, ignore.loops = TRUE)


gs.inbound_3  <- graph.strength(wednesday_3, mode="in")
gs.outbound_3 <- graph.strength(wednesday_3, mode="out")




inbound_f15_wed3  <- as.data.frame(gs.inbound_3)
outbound_f15_wed3  <- as.data.frame(gs.outbound_3)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_wed3$maxn <- ((nrow(inbound_f15_wed3))-1)*10
inbound_f15_wed3$gs.inbound3_norm <- inbound_f15_wed3$gs.inbound_3/inbound_f15_wed3$maxn

#outbound
outbound_f15_wed3$maxn <- ((nrow(outbound_f15_wed3))-1)*10
outbound_f15_wed3$gs.outbound3_norm <- outbound_f15_wed3$gs.outbound_3/outbound_f15_wed3$maxn

#putting Fiunal_ID as a column
inbound_f15_wed3$Final_ID = rownames(inbound_f15_wed3)
outbound_f15_wed3$Final_ID = rownames(outbound_f15_wed3)

centralization_wednesday <- as.data.frame(centralization_wednesday)

write.csv(SN_wednesday, file = "F15_Wednesday3.csv",row.names=TRUE, na="")


#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 4


sender <-   elmk_4_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_4_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_4_f15_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_f15_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_f15_wednesday_4$wednesday 

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



wednesday_4 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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




V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue




plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=10,
            edge.arrow.size = 0.5, edge.color="black", vertex.shape=V(net)$shape,edge.width=E(net)$weight/5)



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_4), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_4, ignore.loops = TRUE)


gs.inbound_4  <- graph.strength(wednesday_4, mode="in")
gs.outbound_4 <- graph.strength(wednesday_4, mode="out")




inbound_f15_wed4  <- as.data.frame(gs.inbound_4)
outbound_f15_wed4  <- as.data.frame(gs.outbound_4)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_wed4$maxn <- ((nrow(inbound_f15_wed4))-1)*10
inbound_f15_wed4$gs.inbound4_norm <- inbound_f15_wed4$gs.inbound_4/inbound_f15_wed4$maxn

#outbound
outbound_f15_wed4$maxn <- ((nrow(outbound_f15_wed4))-1)*10
outbound_f15_wed4$gs.outbound4_norm <- outbound_f15_wed4$gs.outbound_4/outbound_f15_wed4$maxn

#putting Fiunal_ID as a column
inbound_f15_wed4$Final_ID = rownames(inbound_f15_wed4)
outbound_f15_wed4$Final_ID = rownames(outbound_f15_wed4)

centralization_wednesday <- as.data.frame(centralization_wednesday)


write.csv(SN_wednesday, file = "F15_Wednesday4.csv",row.names=TRUE, na="")


#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 5


sender <-   elmk_5_f15_wednesday [c("Sender_Final_ID")]
receiver <- elmk_5_f15_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_5_f15_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_f15_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_f15_wednesday_5$wednesday 

el <- as.data.frame(cbind(sender, receiver, weight))


class(el) #<- This must read as a "data.frame"
el_wednesday <- el
el_wednesday <- el_wednesday[is.element(el_wednesday$Sender_Final_ID, labels_wednesday),]
el_wednesday <- el_wednesday[is.element(el_wednesday$Receiver_Final_ID, labels_wednesday),]
el_wednesday <- as.matrix(el_wednesday)


# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday <- matrix(NA, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday) <- colnames(SN_wednesday) <- labels_wednesday
SN_wednesday[el_wednesday[,1:2]] <- as.numeric(el_wednesday[,3])
SN_wednesday




######################################################


wednesday_5 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)


summary(wednesday_5)

wednesday_5 <- simplify(wednesday_5)
E(wednesday_5)$weight



wednesday_5 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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




V(net)$color=V(net)$role1 #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("lead mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor coach","grey",V(net)$color) #Females will be red
V(net)$color=gsub("mentor","red",V(net)$color) #Females will be red
V(net)$color=gsub("instructor","grey",V(net)$color) #Males will be blue
V(net)$color=gsub("mentee","green",V(net)$color) #Males will be blue




plot.igraph(net,vertex.label=NA,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=10,
            edge.arrow.size = 0.5, edge.color="black", vertex.shape=V(net)$shape,edge.width=E(net)$weight/5)



V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green


plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_5), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_5, ignore.loops = TRUE)


gs.inbound_5  <- graph.strength(wednesday_5, mode="in")
gs.outbound_5 <- graph.strength(wednesday_5, mode="out")




inbound_f15_wed5  <- as.data.frame(gs.inbound_5)
outbound_f15_wed5  <- as.data.frame(gs.outbound_5)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_f15_wed5$maxn <- ((nrow(inbound_f15_wed5))-1)*10
inbound_f15_wed5$gs.inbound5_norm <- inbound_f15_wed5$gs.inbound_5/inbound_f15_wed5$maxn

#outbound
outbound_f15_wed5$maxn <- ((nrow(outbound_f15_wed5))-1)*10
outbound_f15_wed5$gs.outbound5_norm <- outbound_f15_wed5$gs.outbound_5/outbound_f15_wed5$maxn

#putting Fiunal_ID as a column
inbound_f15_wed5$Final_ID = rownames(inbound_f15_wed5)
outbound_f15_wed5$Final_ID = rownames(outbound_f15_wed5)

centralization_wednesday <- as.data.frame(centralization_wednesday)

write.csv(SN_wednesday, file = "F15_Wednesday5.csv",row.names=TRUE, na="")

#
#
####################FAll '15 Thursday
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 THURSDAY Survey 1
#
#
#sender <-   elmk_1_f15_thursday [c("Sender_Final_ID")]
#receiver <- elmk_1_f15_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_1_f15_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_f15_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_f15_thursday_1$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_1 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_1)
#
#thursday_1 <- simplify(thursday_1)
#E(thursday_1)$weight
#
#
#
#thursday_1 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_1)
#
#thursday_1 <- simplify(thursday_1)
#E(thursday_1)$weight
#
#
#
#net=thursday_1
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_1), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_1, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_1, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_1, mode="out")
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 thursday Survey 2
#
#
#sender <-   elmk_2_f15_thursday [c("Sender_Final_ID")]
#receiver <- elmk_2_f15_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_2_f15_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_f15_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_f15_thursday_2$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_2 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_2)
#
#thursday_2 <- simplify(thursday_2)
#E(thursday_2)$weight
#
#
#
#thursday_2 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_2)
#
#thursday_2 <- simplify(thursday_2)
#E(thursday_2)$weight
#
#
#
#net=thursday_2
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_2), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_2, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_2, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_2, mode="out")
#
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 thursday Survey 3
#
#
#sender <-   elmk_3_f15_thursday [c("Sender_Final_ID")]
#receiver <- elmk_3_f15_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_3_f15_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_f15_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_f15_thursday_3$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_3 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_3)
#
#thursday_3 <- simplify(thursday_3)
#E(thursday_3)$weight
#
#
#
#thursday_3 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_3)
#
#thursday_3 <- simplify(thursday_3)
#E(thursday_3)$weight
#
#
#
#net=thursday_3
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_3), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_3, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_3, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_3, mode="out")
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 thursday Survey 4
#
#
#sender <-   elmk_4_f15_thursday [c("Sender_Final_ID")]
#receiver <- elmk_4_f15_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_4_f15_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_f15_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_f15_thursday_4$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_4 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_4)
#
#thursday_4 <- simplify(thursday_4)
#E(thursday_4)$weight
#
#
#
#thursday_4 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_4)
#
#thursday_4 <- simplify(thursday_4)
#E(thursday_4)$weight
#
#
#
#net=thursday_4
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_4), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_4, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_4, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_4, mode="out")
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 thursday Survey 5
#
#
#sender <-   elmk_5_f15_thursday [c("Sender_Final_ID")]
#receiver <- elmk_5_f15_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_5_f15_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_f15_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_f15_thursday_5$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_5 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_5)
#
#thursday_5 <- simplify(thursday_5)
#E(thursday_5)$weight
#
#
#
#thursday_5 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                           add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_5)
#
#thursday_5 <- simplify(thursday_5)
#E(thursday_5)$weight
#
#
#
#net=thursday_5
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_5), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_5, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_5, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_5, mode="out")
#
#




##########################################################
############################################################SPRING '16
#################################################################################
####################################################################################################




#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 MONDAY Survey 1 
#
#
#sender <-   elmk_1_s16_monday [c("Sender_Final_ID")]
#receiver <- elmk_1_s16_monday [c("Receiver_Final_ID")]
#weight <-   elmk_1_s16_monday  [c("sn1")]
#
#
##labels_monday <- sn_include_s16_monday$Sender_Final_ID 
#
#labels_monday <- sn_include_s16_monday_1$monday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_monday <- el
#el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
#el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
#el_monday <- as.matrix(el_monday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_monday, decreasing=FALSE)
#SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
#rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
#SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
#SN_monday
#
#
#
#
#######################################################
#
#
#monday_1 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(monday_1)
#
#monday_1 <- simplify(monday_1)
#E(monday_1)$weight
#
#
#
#monday_1 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(monday_1)
#
#monday_1 <- simplify(monday_1)
#E(monday_1)$weight
#
#
#
#net=monday_1
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_monday <- graph.density(simplify(monday_1), loops=FALSE)
#centralization_monday <- centralization.degree(monday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_monday <- reciprocity(monday_1, ignore.loops = TRUE)
#
#gs.inbound_monday <- graph.strength(monday_1, mode="in")
#gs.outbound_monday <- graph.strength(monday_1, mode="out")
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 MONDAY Survey 2
#
#
#sender <-   elmk_2_s16_monday [c("Sender_Final_ID")]
#receiver <- elmk_2_s16_monday [c("Receiver_Final_ID")]
#weight <-   elmk_2_s16_monday  [c("sn1")]
#
#
##labels_monday <- sn_include_s16_monday$Sender_Final_ID 
#
#labels_monday <- sn_include_s16_monday$monday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_monday <- el
#el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
#el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
#el_monday <- as.matrix(el_monday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_monday, decreasing=FALSE)
#SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
#rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
#SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
#SN_monday
#
#
#
#
#######################################################
#
#
#monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(monday_2)
#
#monday_2 <- simplify(monday_2)
#E(monday_2)$weight
#
#
#
#monday_2 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(monday_2)
#
#monday_2 <- simplify(monday_2)
#E(monday_2)$weight
#
#
#
#net=monday_2
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_monday <- graph.density(simplify(monday_2), loops=FALSE)
#centralization_monday <- centralization.degree(monday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_monday <- reciprocity(monday_2, ignore.loops = TRUE)
#
#gs.inbound_monday <- graph.strength(monday_2, mode="in")
#gs.outbound_monday <- graph.strength(monday_2, mode="out")
#
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 MONDAY Survey 3
#
#
#sender <-   elmk_3_s16_monday [c("Sender_Final_ID")]
#receiver <- elmk_3_s16_monday [c("Receiver_Final_ID")]
#weight <-   elmk_3_s16_monday  [c("sn1")]
#
#
##labels_monday <- sn_include_s16_monday$Sender_Final_ID 
#
#labels_monday <- sn_include_s16_monday$monday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_monday <- el
#el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
#el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
#el_monday <- as.matrix(el_monday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_monday, decreasing=FALSE)
#SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
#rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
#SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
#SN_monday
#
#
#
#
#######################################################
#
#
#monday_3 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(monday_3)
#
#monday_3 <- simplify(monday_3)
#E(monday_3)$weight
#
#
#
#monday_3 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(monday_3)
#
#monday_3 <- simplify(monday_3)
#E(monday_3)$weight
#
#
#
#net=monday_3
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_monday <- graph.density(simplify(monday_3), loops=FALSE)
#centralization_monday <- centralization.degree(monday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_monday <- reciprocity(monday_3, ignore.loops = TRUE)
#
#gs.inbound_monday <- graph.strength(monday_3, mode="in")
#gs.outbound_monday <- graph.strength(monday_3, mode="out")
#
#
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 MONDAY Survey 4
#
#
#sender <-   elmk_4_s16_monday [c("Sender_Final_ID")]
#receiver <- elmk_4_s16_monday [c("Receiver_Final_ID")]
#weight <-   elmk_4_s16_monday  [c("sn1")]
#
#
##labels_monday <- sn_include_s16_monday$Sender_Final_ID 
#
#labels_monday <- sn_include_s16_monday$monday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_monday <- el
#el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
#el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
#el_monday <- as.matrix(el_monday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_monday, decreasing=FALSE)
#SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
#rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
#SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
#SN_monday
#
#
#
#
#######################################################
#
#
#monday_4 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(monday_4)
#
#monday_4 <- simplify(monday_4)
#E(monday_4)$weight
#
#
#
#monday_4 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(monday_4)
#
#monday_4 <- simplify(monday_4)
#E(monday_4)$weight
#
#
#
#net=monday_4
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_monday <- graph.density(simplify(monday_4), loops=FALSE)
#centralization_monday <- centralization.degree(monday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_monday <- reciprocity(monday_4, ignore.loops = TRUE)
#
#gs.inbound_monday <- graph.strength(monday_4, mode="in")
#gs.outbound_monday <- graph.strength(monday_4, mode="out")
#
#
#
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 MONDAY Survey 5
#
#
#sender <-   elmk_5_s16_monday [c("Sender_Final_ID")]
#receiver <- elmk_5_s16_monday [c("Receiver_Final_ID")]
#weight <-   elmk_5_s16_monday  [c("sn1")]
#
#
##labels_monday <- sn_include_s16_monday$Sender_Final_ID 
#
#labels_monday <- sn_include_s16_monday$monday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_monday <- el
#el_monday <- el_monday[is.element(el_monday$Sender_Final_ID, labels_monday),]
#el_monday <- el_monday[is.element(el_monday$Receiver_Final_ID, labels_monday),]
#el_monday <- as.matrix(el_monday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_monday, decreasing=FALSE)
#SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
#rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
#SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
#SN_monday
#
#
#
#
#######################################################
#
#
#monday_5 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#
#summary(monday_5)
#
#monday_5 <- simplify(monday_5)
#E(monday_5)$weight
#
#
#
#monday_5 <- graph_from_adjacency_matrix(SN_monday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                        add.colnames = NULL, add.rownames = NA)
#
#summary(monday_5)
#
#monday_5 <- simplify(monday_5)
#E(monday_5)$weight
#
#
#
#net=monday_5
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_monday <- graph.density(simplify(monday_5), loops=FALSE)
#centralization_monday <- centralization.degree(monday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_monday <- reciprocity(monday_5, ignore.loops = TRUE)
#
#gs.inbound_monday <- graph.strength(monday_5, mode="in")
#gs.outbound_monday <- graph.strength(monday_5, mode="out")
#



##########################spring '16 Tuesday

############Survey 1 spring '16 Tuesday CONTROL NIGHT


sender <-   elmk_1_s16_tuesday [c("Sender_Final_ID")]
receiver <- elmk_1_s16_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_1_s16_tuesday  [c("sn1")]


#labels_tuesday <- sn_include_s16_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_s16_tuesday$tuesday 

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



tuesday_1 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_1), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_1, ignore.loops = TRUE)

gs.inbound_1  <- graph.strength(tuesday_1, mode="in")
gs.outbound_1 <- graph.strength(tuesday_1, mode="out")



inbound_s16_tue1  <- as.data.frame(gs.inbound_1)
outbound_s16_tue1  <- as.data.frame(gs.outbound_1)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_tue1$maxn <- ((nrow(inbound_s16_tue1))-1)*10
inbound_s16_tue1$gs.inbound1_norm <- inbound_s16_tue1$gs.inbound_1/inbound_s16_tue1$maxn

#outbound
outbound_s16_tue1$maxn <- ((nrow(outbound_s16_tue1))-1)*10
outbound_s16_tue1$gs.outbound1_norm <- outbound_s16_tue1$gs.outbound_1/outbound_s16_tue1$maxn

#putting Fiunal_ID as a column
inbound_s16_tue1$Final_ID = rownames(inbound_s16_tue1)
outbound_s16_tue1$Final_ID = rownames(outbound_s16_tue1)

centralization_tuesday <- as.data.frame(centralization_tuesday)

write.csv(SN_tuesday, file = "s16_tuesday1.csv",row.names=TRUE, na="")




#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 tuesday Survey 2 #Control Night


sender <-   elmk_2_s16_tuesday [c("Sender_Final_ID")]
receiver <- elmk_2_s16_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_2_s16_tuesday  [c("sn1")]


#labels_tuesday <- sn_include_s16_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_s16_tuesday$tuesday 

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



tuesday_2 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_2), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_2, ignore.loops = TRUE)

gs.inbound_2  <- graph.strength(tuesday_2, mode="in")
gs.outbound_2 <- graph.strength(tuesday_2, mode="out")



inbound_s16_tue2  <- as.data.frame(gs.inbound_2)
outbound_s16_tue2  <- as.data.frame(gs.outbound_2)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_tue2$maxn <- ((nrow(inbound_s16_tue2))-1)*10
inbound_s16_tue2$gs.inbound2_norm <- inbound_s16_tue2$gs.inbound_2/inbound_s16_tue2$maxn

#outbound
outbound_s16_tue2$maxn <- ((nrow(outbound_s16_tue2))-1)*10
outbound_s16_tue2$gs.outbound2_norm <- outbound_s16_tue2$gs.outbound_2/outbound_s16_tue2$maxn

#putting Fiunal_ID as a column
inbound_s16_tue2$Final_ID = rownames(inbound_s16_tue2)
outbound_s16_tue2$Final_ID = rownames(outbound_s16_tue2)

centralization_tuesday <- as.data.frame(centralization_tuesday)

write.csv(SN_tuesday, file = "s16_tuesday2.csv",row.names=TRUE, na="")


#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 tuesday Survey 3


sender <-   elmk_3_s16_tuesday [c("Sender_Final_ID")]
receiver <- elmk_3_s16_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_3_s16_tuesday  [c("sn1")]


#labels_tuesday <- sn_include_s16_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_s16_tuesday$tuesday 

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



tuesday_3 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_3), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_3, ignore.loops = TRUE)

gs.inbound_3  <- graph.strength(tuesday_3, mode="in")
gs.outbound_3 <- graph.strength(tuesday_3, mode="out")



inbound_s16_tue3  <- as.data.frame(gs.inbound_3)
outbound_s16_tue3  <- as.data.frame(gs.outbound_3)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_tue3$maxn <- ((nrow(inbound_s16_tue3))-1)*10
inbound_s16_tue3$gs.inbound3_norm <- inbound_s16_tue3$gs.inbound_3/inbound_s16_tue3$maxn

#outbound
outbound_s16_tue3$maxn <- ((nrow(outbound_s16_tue3))-1)*10
outbound_s16_tue3$gs.outbound3_norm <- outbound_s16_tue3$gs.outbound_3/outbound_s16_tue3$maxn

#putting Fiunal_ID as a column
inbound_s16_tue3$Final_ID = rownames(inbound_s16_tue3)
outbound_s16_tue3$Final_ID = rownames(outbound_s16_tue3)

centralization_tuesday <- as.data.frame(centralization_tuesday)


write.csv(SN_tuesday, file = "s16_tuesday3.csv",row.names=TRUE, na="")


#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 tuesday Survey 4


sender <-   elmk_4_s16_tuesday [c("Sender_Final_ID")]
receiver <- elmk_4_s16_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_4_s16_tuesday  [c("sn1")]


#labels_tuesday <- sn_include_s16_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_s16_tuesday$tuesday 

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



tuesday_4 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_4), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_4, ignore.loops = TRUE)


gs.inbound_4  <- graph.strength(tuesday_4, mode="in")
gs.outbound_4 <- graph.strength(tuesday_4, mode="out")


inbound_s16_tue4  <- as.data.frame(gs.inbound_4)
outbound_s16_tue4  <- as.data.frame(gs.outbound_4)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_tue4$maxn <- ((nrow(inbound_s16_tue4))-1)*10
inbound_s16_tue4$gs.inbound4_norm <- inbound_s16_tue4$gs.inbound_4/inbound_s16_tue4$maxn

#outbound
outbound_s16_tue4$maxn <- ((nrow(outbound_s16_tue4))-1)*10
outbound_s16_tue4$gs.outbound4_norm <- outbound_s16_tue4$gs.outbound_4/outbound_s16_tue4$maxn

#putting Fiunal_ID as a column
inbound_s16_tue4$Final_ID = rownames(inbound_s16_tue4)
outbound_s16_tue4$Final_ID = rownames(outbound_s16_tue4)

centralization_tuesday <- as.data.frame(centralization_tuesday)

write.csv(SN_tuesday, file = "s16_tuesday4.csv",row.names=TRUE, na="")


#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 tuesday Survey 5


sender <-   elmk_5_s16_tuesday [c("Sender_Final_ID")]
receiver <- elmk_5_s16_tuesday [c("Receiver_Final_ID")]
weight <-   elmk_5_s16_tuesday  [c("sn1")]


#labels_tuesday <- sn_include_s16_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_s16_tuesday$tuesday 

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



tuesday_5 <- graph_from_adjacency_matrix(SN_tuesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_5), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_5, ignore.loops = TRUE)


gs.inbound_5  <- graph.strength(tuesday_5, mode="in")
gs.outbound_5 <- graph.strength(tuesday_5, mode="out")


inbound_s16_tue5  <- as.data.frame(gs.inbound_5)
outbound_s16_tue5  <- as.data.frame(gs.outbound_5)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_tue5$maxn <- ((nrow(inbound_s16_tue5))-1)*10
inbound_s16_tue5$gs.inbound5_norm <- inbound_s16_tue5$gs.inbound_5/inbound_s16_tue5$maxn

#outbound
outbound_s16_tue5$maxn <- ((nrow(outbound_s16_tue5))-1)*10
outbound_s16_tue5$gs.outbound5_norm <- outbound_s16_tue5$gs.outbound_5/outbound_s16_tue5$maxn

#putting Fiunal_ID as a column
inbound_s16_tue5$Final_ID = rownames(inbound_s16_tue5)
outbound_s16_tue5$Final_ID = rownames(outbound_s16_tue5)

centralization_tuesday <- as.data.frame(centralization_tuesday)


write.csv(SN_tuesday, file = "s16_tuesday5.csv",row.names=TRUE, na="")




###################spring '16 Wednesday #CONTROL NIGHT


#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 WEDNESDAY Survey 1


sender <-   elmk_1_s16_wednesday [c("Sender_Final_ID")]
receiver <- elmk_1_s16_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_1_s16_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_s16_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_s16_wednesday$wednesday 

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



wednesday_1 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue



plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_1), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_1, ignore.loops = TRUE)

gs.inbound_1  <- graph.strength(wednesday_1, mode="in")
gs.outbound_1 <- graph.strength(wednesday_1, mode="out")



inbound_s16_wed1  <- as.data.frame(gs.inbound_1)
outbound_s16_wed1  <- as.data.frame(gs.outbound_1)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_wed1$maxn <- ((nrow(inbound_s16_wed1))-1)*10
inbound_s16_wed1$gs.inbound1_norm <- inbound_s16_wed1$gs.inbound_1/inbound_s16_wed1$maxn

#outbound
outbound_s16_wed1$maxn <- ((nrow(outbound_s16_wed1))-1)*10
outbound_s16_wed1$gs.outbound1_norm <- outbound_s16_wed1$gs.outbound_1/outbound_s16_wed1$maxn

#putting Fiunal_ID as a column
inbound_s16_wed1$Final_ID = rownames(inbound_s16_wed1)
outbound_s16_wed1$Final_ID = rownames(outbound_s16_wed1)

centralization_wednesday <- as.data.frame(centralization_wednesday)


write.csv(SN_wednesday, file = "s16_Wednesday1.csv",row.names=TRUE, na="")



#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 wednesday Survey 2


sender <-   elmk_2_s16_wednesday [c("Sender_Final_ID")]
receiver <- elmk_2_s16_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_2_s16_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_s16_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_s16_wednesday$wednesday 

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



wednesday_2 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue



plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_2), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_2, ignore.loops = TRUE)

gs.inbound_2  <- graph.strength(wednesday_2, mode="in")
gs.outbound_2 <- graph.strength(wednesday_2, mode="out")



inbound_s16_wed2  <- as.data.frame(gs.inbound_2)
outbound_s16_wed2  <- as.data.frame(gs.outbound_2)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_wed2$maxn <- ((nrow(inbound_s16_wed2))-1)*10
inbound_s16_wed2$gs.inbound2_norm <- inbound_s16_wed2$gs.inbound_2/inbound_s16_wed2$maxn

#outbound
outbound_s16_wed2$maxn <- ((nrow(outbound_s16_wed2))-1)*10
outbound_s16_wed2$gs.outbound2_norm <- outbound_s16_wed2$gs.outbound_2/outbound_s16_wed2$maxn

#putting Fiunal_ID as a column
inbound_s16_wed2$Final_ID = rownames(inbound_s16_wed2)
outbound_s16_wed2$Final_ID = rownames(outbound_s16_wed2)

centralization_wednesday <- as.data.frame(centralization_wednesday)


write.csv(SN_wednesday, file = "s16_Wednesday2.csv",row.names=TRUE, na="")




#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 wednesday Survey 3


sender <-   elmk_3_s16_wednesday [c("Sender_Final_ID")]
receiver <- elmk_3_s16_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_3_s16_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_s16_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_s16_wednesday$wednesday 

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



wednesday_3 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue



plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_3), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_3, ignore.loops = TRUE)

gs.inbound_3  <- graph.strength(wednesday_3, mode="in")
gs.outbound_3 <- graph.strength(wednesday_3, mode="out")



inbound_s16_wed3  <- as.data.frame(gs.inbound_3)
outbound_s16_wed3  <- as.data.frame(gs.outbound_3)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_wed3$maxn <- ((nrow(inbound_s16_wed3))-1)*10
inbound_s16_wed3$gs.inbound3_norm <- inbound_s16_wed3$gs.inbound_3/inbound_s16_wed3$maxn

#outbound
outbound_s16_wed3$maxn <- ((nrow(outbound_s16_wed3))-1)*10
outbound_s16_wed3$gs.outbound3_norm <- outbound_s16_wed3$gs.outbound_3/outbound_s16_wed3$maxn

#putting Fiunal_ID as a column
inbound_s16_wed3$Final_ID = rownames(inbound_s16_wed3)
outbound_s16_wed3$Final_ID = rownames(outbound_s16_wed3)

centralization_wednesday <- as.data.frame(centralization_wednesday)

write.csv(SN_wednesday, file = "s16_Wednesday3.csv",row.names=TRUE, na="")

#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 wednesday Survey 4


sender <-   elmk_4_s16_wednesday [c("Sender_Final_ID")]
receiver <- elmk_4_s16_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_4_s16_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_s16_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_s16_wednesday$wednesday 

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



wednesday_4 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue



plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_4), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_4, ignore.loops = TRUE)


gs.inbound_4  <- graph.strength(wednesday_4, mode="in")
gs.outbound_4 <- graph.strength(wednesday_4, mode="out")



inbound_s16_wed4  <- as.data.frame(gs.inbound_4)
outbound_s16_wed4  <- as.data.frame(gs.outbound_4)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_wed4$maxn <- ((nrow(inbound_s16_wed4))-1)*10
inbound_s16_wed4$gs.inbound4_norm <- inbound_s16_wed4$gs.inbound_4/inbound_s16_wed4$maxn

#outbound
outbound_s16_wed4$maxn <- ((nrow(outbound_s16_wed4))-1)*10
outbound_s16_wed4$gs.outbound4_norm <- outbound_s16_wed4$gs.outbound_4/outbound_s16_wed4$maxn

#putting Fiunal_ID as a column
inbound_s16_wed4$Final_ID = rownames(inbound_s16_wed4)
outbound_s16_wed4$Final_ID = rownames(outbound_s16_wed4)

centralization_wednesday <- as.data.frame(centralization_wednesday)

write.csv(SN_wednesday, file = "s16_Wednesday4.csv",row.names=TRUE, na="")

#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 wednesday Survey 5


sender <-   elmk_5_s16_wednesday [c("Sender_Final_ID")]
receiver <- elmk_5_s16_wednesday [c("Receiver_Final_ID")]
weight <-   elmk_5_s16_wednesday  [c("sn1")]


#labels_wednesday <- sn_include_s16_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_s16_wednesday$wednesday 

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



wednesday_5 <- graph_from_adjacency_matrix(SN_wednesday, mode = c("directed"), weighted = NULL, diag = TRUE,
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
V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue



plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)

#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_5), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_5, ignore.loops = TRUE)

gs.inbound_5  <- graph.strength(wednesday_5, mode="in")
gs.outbound_5 <- graph.strength(wednesday_5, mode="out")



inbound_s16_wed5  <- as.data.frame(gs.inbound_5)
outbound_s16_wed5  <- as.data.frame(gs.outbound_5)

#begin standardizing
#standard equation = N-1 (-1 because we ignore loops), *10 (max scale range) 
#                               then divide by max to create a propotion

#inbound
inbound_s16_wed5$maxn <- ((nrow(inbound_s16_wed5))-1)*10
inbound_s16_wed5$gs.inbound5_norm <- inbound_s16_wed5$gs.inbound_5/inbound_s16_wed5$maxn

#outbound
outbound_s16_wed5$maxn <- ((nrow(outbound_s16_wed5))-1)*10
outbound_s16_wed5$gs.outbound5_norm <- outbound_s16_wed5$gs.outbound_5/outbound_s16_wed5$maxn

#putting Fiunal_ID as a column
inbound_s16_wed5$Final_ID = rownames(inbound_s16_wed5)
outbound_s16_wed5$Final_ID = rownames(outbound_s16_wed5)

centralization_wednesday <- as.data.frame(centralization_wednesday)


write.csv(SN_wednesday, file = "s16_Wednesday5.csv",row.names=TRUE, na="")


#
#
####################spring '16 Thursday
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 THURSDAY Survey 1
#
#
#sender <-   elmk_1_s16_thursday [c("Sender_Final_ID")]
#receiver <- elmk_1_s16_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_1_s16_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_s16_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_s16_thursday$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_1 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_1)
#
#thursday_1 <- simplify(thursday_1)
#E(thursday_1)$weight
#
#
#
#thursday_1 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_1)
#
#thursday_1 <- simplify(thursday_1)
#E(thursday_1)$weight
#
#
#
#net=thursday_1
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_1), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_1, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_1, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_1, mode="out")
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 thursday Survey 2
#
#
#sender <-   elmk_2_s16_thursday [c("Sender_Final_ID")]
#receiver <- elmk_2_s16_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_2_s16_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_s16_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_s16_thursday$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_2 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_2)
#
#thursday_2 <- simplify(thursday_2)
#E(thursday_2)$weight
#
#
#
#thursday_2 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_2)
#
#thursday_2 <- simplify(thursday_2)
#E(thursday_2)$weight
#
#
#
#net=thursday_2
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_2), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_2, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_2, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_2, mode="out")
#
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 thursday Survey 3
#
#
#sender <-   elmk_3_s16_thursday [c("Sender_Final_ID")]
#receiver <- elmk_3_s16_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_3_s16_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_s16_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_s16_thursday$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_3 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_3)
#
#thursday_3 <- simplify(thursday_3)
#E(thursday_3)$weight
#
#
#
#thursday_3 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_3)
#
#thursday_3 <- simplify(thursday_3)
#E(thursday_3)$weight
#
#
#
#net=thursday_3
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_3), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_3, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_3, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_3, mode="out")
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 thursday Survey 4
#
#
#sender <-   elmk_4_s16_thursday [c("Sender_Final_ID")]
#receiver <- elmk_4_s16_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_4_s16_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_s16_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_s16_thursday$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_4 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_4)
#
#thursday_4 <- simplify(thursday_4)
#E(thursday_4)$weight
#
#
#
#thursday_4 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_4)
#
#thursday_4 <- simplify(thursday_4)
#E(thursday_4)$weight
#
#
#
#net=thursday_4
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_4), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_4, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_4, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_4, mode="out")
#
#
#
#
##SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 thursday Survey 5
#
#
#sender <-   elmk_5_s16_thursday [c("Sender_Final_ID")]
#receiver <- elmk_5_s16_thursday [c("Receiver_Final_ID")]
#weight <-   elmk_5_s16_thursday  [c("sn1")]
#
#
##labels_thursday <- sn_include_s16_thursday$Sender_Final_ID 
#
#labels_thursday <- sn_include_s16_thursday$thursday 
#
#el <- as.data.frame(cbind(sender, receiver, weight))
#
#
#class(el) #<- This must read as a "data.frame"
#el_thursday <- el
#el_thursday <- el_thursday[is.element(el_thursday$Sender_Final_ID, labels_thursday),]
#el_thursday <- el_thursday[is.element(el_thursday$Receiver_Final_ID, labels_thursday),]
#el_thursday <- as.matrix(el_thursday)
#
#
## create a social network graph for each night - start with an empty matrix of the correct size
#
#sort(labels_thursday, decreasing=FALSE)
#SN_thursday <- matrix(0, length(labels_thursday), length(labels_thursday))
#rownames(SN_thursday) <- colnames(SN_thursday) <- labels_thursday
#SN_thursday[el_thursday[,1:2]] <- as.numeric(el_thursday[,3])
#SN_thursday
#
#
#
#
#######################################################
#
#
#thursday_5 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#
#summary(thursday_5)
#
#thursday_5 <- simplify(thursday_5)
#E(thursday_5)$weight
#
#
#
#thursday_5 <- graph_from_adjacency_matrix(SN_thursday, mode = c("directed"), weighted = NULL, diag = TRUE,
#                                          add.colnames = NULL, add.rownames = NA)
#
#summary(thursday_5)
#
#thursday_5 <- simplify(thursday_5)
#E(thursday_5)$weight
#
#
#
#net=thursday_5
## show the names of the vertices you just imported:
#V(net)$name
#
#
#a=staff_youth_att
#V(net)$gender=as.character(a$gender[match(V(net)$name,a$Final_ID)]) # This code says to create a vertex attribute called "Sex" by extracting the value of the column "Sex" in the attributes file when the Bird ID number matches the vertex name.
#V(net)$role1=as.character(a$role1[match(V(net)$name,a$Final_ID)])
#V(net)$gender # This will print the new vertex attribute, "Sex"
#V(net)$role1
#
#
#
#V(net)$color=V(net)$gender #assign the "Sex" attribute as the vertex color
#V(net)$color=gsub("0","pink",V(net)$color) #Females will be red
#V(net)$color=gsub("1","light blue",V(net)$color) #Males will be blue
#V(net)$color=gsub("-1","green",V(net)$color) #Other will be Green
#
#
#plot.igraph(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#            edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
#tkplot(net,vertex.label=V(net)$role1,layout=layout.fruchterman.reingold,edge.curved=TRUE, vertex.label.cex = 0.7, vertex.size=20,
#       edge.arrow.size = 1.5, edge.color="black",edge.width=E(net)$weight/5)
#
##GETTING SOCIAL NETWORK STATISTICS
#
#density_thursday <- graph.density(simplify(thursday_5), loops=FALSE)
#centralization_thursday <- centralization.degree(thursday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
#reciprocity_thursday <- reciprocity(thursday_5, ignore.loops = TRUE)
#
#gs.inbound_thursday <- graph.strength(thursday_5, mode="in")
#gs.outbound_thursday <- graph.strength(thursday_5, mode="out")




#regression analysis SET UP


inbound_f15_mon1 <- inbound_f15_mon1[order(inbound_f15_mon1$Final_ID),] 
inbound_f15_mon2 <- inbound_f15_mon2[order(inbound_f15_mon2$Final_ID),] 
inbound_f15_mon3 <- inbound_f15_mon3[order(inbound_f15_mon3$Final_ID),] 
inbound_f15_mon4 <- inbound_f15_mon4[order(inbound_f15_mon4$Final_ID),] 
inbound_f15_mon5 <- inbound_f15_mon5[order(inbound_f15_mon5$Final_ID),] 


outbound_f15_mon1 <- outbound_f15_mon1[order(outbound_f15_mon1$Final_ID),] 
outbound_f15_mon2 <- outbound_f15_mon2[order(outbound_f15_mon2$Final_ID),] 
outbound_f15_mon3 <- outbound_f15_mon3[order(outbound_f15_mon3$Final_ID),] 
outbound_f15_mon4 <- outbound_f15_mon4[order(outbound_f15_mon4$Final_ID),] 
outbound_f15_mon5 <- outbound_f15_mon5[order(outbound_f15_mon5$Final_ID),] 


inbound_f15_wed1 <- inbound_f15_wed1[order(inbound_f15_wed1$Final_ID),] 
inbound_f15_wed2 <- inbound_f15_wed2[order(inbound_f15_wed2$Final_ID),] 
inbound_f15_wed3 <- inbound_f15_wed3[order(inbound_f15_wed3$Final_ID),] 
inbound_f15_wed4 <- inbound_f15_wed4[order(inbound_f15_wed4$Final_ID),] 
inbound_f15_wed5 <- inbound_f15_wed5[order(inbound_f15_wed5$Final_ID),] 


outbound_f15_wed1 <- outbound_f15_wed1[order(outbound_f15_wed1$Final_ID),] 
outbound_f15_wed2 <- outbound_f15_wed2[order(outbound_f15_wed2$Final_ID),] 
outbound_f15_wed3 <- outbound_f15_wed3[order(outbound_f15_wed3$Final_ID),] 
outbound_f15_wed4 <- outbound_f15_wed4[order(outbound_f15_wed4$Final_ID),] 
outbound_f15_wed5 <- outbound_f15_wed5[order(outbound_f15_wed5$Final_ID),] 




inbound_s16_tue1 <- inbound_s16_tue1[order(inbound_s16_tue1$Final_ID),] 
inbound_s16_tue2 <- inbound_s16_tue2[order(inbound_s16_tue2$Final_ID),] 
inbound_s16_tue3 <- inbound_s16_tue3[order(inbound_s16_tue3$Final_ID),] 
inbound_s16_tue4 <- inbound_s16_tue4[order(inbound_s16_tue4$Final_ID),] 
inbound_s16_tue5 <- inbound_s16_tue5[order(inbound_s16_tue5$Final_ID),] 


outbound_s16_tue1 <- outbound_s16_tue1[order(outbound_s16_tue1$Final_ID),] 
outbound_s16_tue2 <- outbound_s16_tue2[order(outbound_s16_tue2$Final_ID),] 
outbound_s16_tue3 <- outbound_s16_tue3[order(outbound_s16_tue3$Final_ID),] 
outbound_s16_tue4 <- outbound_s16_tue4[order(outbound_s16_tue4$Final_ID),] 
outbound_s16_tue5 <- outbound_s16_tue5[order(outbound_s16_tue5$Final_ID),] 

inbound_s16_wed1[order(inbound_s16_wed1$Final_ID),] 
inbound_s16_wed2[order(inbound_s16_wed2$Final_ID),] 
inbound_s16_wed3[order(inbound_s16_wed3$Final_ID),] 
inbound_s16_wed4[order(inbound_s16_wed4$Final_ID),] 
inbound_s16_wed5[order(inbound_s16_wed5$Final_ID),] 


 outbound_s16_wed1[order(outbound_s16_wed1$Final_ID),] 
 outbound_s16_wed2[order(outbound_s16_wed2$Final_ID),] 
 outbound_s16_wed3[order(outbound_s16_wed3$Final_ID),] 
 outbound_s16_wed4[order(outbound_s16_wed4$Final_ID),] 
 outbound_s16_wed5[order(outbound_s16_wed5$Final_ID),] 



names(inbound_s16_tue1)[names(inbound_s16_tue1) == 'maxn'] <- 'maxin1'
names(inbound_s16_tue2)[names(inbound_s16_tue2) == 'maxn'] <- 'maxin2'
names(inbound_s16_tue3)[names(inbound_s16_tue3) == 'maxn'] <- 'maxin3'
names(inbound_s16_tue4)[names(inbound_s16_tue4) == 'maxn'] <- 'maxin4'
names(inbound_s16_tue5)[names(inbound_s16_tue5) == 'maxn'] <- 'maxin5'

names(inbound_s16_wed1)[names(inbound_s16_wed1) == 'maxn'] <- 'maxin1'
names(inbound_s16_wed2)[names(inbound_s16_wed2) == 'maxn'] <- 'maxin2'
names(inbound_s16_wed3)[names(inbound_s16_wed3) == 'maxn'] <- 'maxin3'
names(inbound_s16_wed4)[names(inbound_s16_wed4) == 'maxn'] <- 'maxin4'
names(inbound_s16_wed5)[names(inbound_s16_wed5) == 'maxn'] <- 'maxin5'


names(inbound_f15_mon1)[names(inbound_f15_mon1) == 'maxn'] <- 'maxin1'
names(inbound_f15_mon2)[names(inbound_f15_mon2) == 'maxn'] <- 'maxin2'
names(inbound_f15_mon3)[names(inbound_f15_mon3) == 'maxn'] <- 'maxin3'
names(inbound_f15_mon4)[names(inbound_f15_mon4) == 'maxn'] <- 'maxin4'
names(inbound_f15_mon5)[names(inbound_f15_mon5) == 'maxn'] <- 'maxin5'

names(inbound_f15_wed1)[names(inbound_f15_wed1) == 'maxn'] <- 'maxin1'
names(inbound_f15_wed2)[names(inbound_f15_wed2) == 'maxn'] <- 'maxin2'
names(inbound_f15_wed3)[names(inbound_f15_wed3) == 'maxn'] <- 'maxin3'
names(inbound_f15_wed4)[names(inbound_f15_wed4) == 'maxn'] <- 'maxin4'
names(inbound_f15_wed5)[names(inbound_f15_wed5) == 'maxn'] <- 'maxin5'

#outbound

names(outbound_s16_tue1)[names(outbound_s16_tue1) == 'maxn'] <- 'maxoutn1'
names(outbound_s16_tue2)[names(outbound_s16_tue2) == 'maxn'] <- 'maxoutn2'
names(outbound_s16_tue3)[names(outbound_s16_tue3) == 'maxn'] <- 'maxoutn3'
names(outbound_s16_tue4)[names(outbound_s16_tue4) == 'maxn'] <- 'maxoutn4'
names(outbound_s16_tue5)[names(outbound_s16_tue5) == 'maxn'] <- 'maxoutn5'

names(outbound_s16_wed1)[names(outbound_s16_wed1) == 'maxn'] <- 'maxoutn1'
names(outbound_s16_wed2)[names(outbound_s16_wed2) == 'maxn'] <- 'maxoutn2'
names(outbound_s16_wed3)[names(outbound_s16_wed3) == 'maxn'] <- 'maxoutn3'
names(outbound_s16_wed4)[names(outbound_s16_wed4) == 'maxn'] <- 'maxoutn4'
names(outbound_s16_wed5)[names(outbound_s16_wed5) == 'maxn'] <- 'maxoutn5'


names(outbound_f15_mon1)[names(outbound_f15_mon1) == 'maxn'] <- 'maxoutn1'
names(outbound_f15_mon2)[names(outbound_f15_mon2) == 'maxn'] <- 'maxoutn2'
names(outbound_f15_mon3)[names(outbound_f15_mon3) == 'maxn'] <- 'maxoutn3'
names(outbound_f15_mon4)[names(outbound_f15_mon4) == 'maxn'] <- 'maxoutn4'
names(outbound_f15_mon5)[names(outbound_f15_mon5) == 'maxn'] <- 'maxoutn5'

names(outbound_f15_wed1)[names(outbound_f15_wed1) == 'maxn'] <- 'maxoutn1'
names(outbound_f15_wed2)[names(outbound_f15_wed2) == 'maxn'] <- 'maxoutn2'
names(outbound_f15_wed3)[names(outbound_f15_wed3) == 'maxn'] <- 'maxoutn3'
names(outbound_f15_wed4)[names(outbound_f15_wed4) == 'maxn'] <- 'maxoutn4'
names(outbound_f15_wed5)[names(outbound_f15_wed5) == 'maxn'] <- 'maxoutn5'



#COmbining in & out relationships

#FIRST: add semester & night code to each (We'll need to control fro this later )


#merging fall inbounds

inboundf15_mon_total <- merge(inbound_f15_mon1, inbound_f15_mon2, 
                          by.inbound_f15_mon1=c("Final_ID"),
                          by.inbound_f15_mon2=c("Final_ID"), 
                          all=TRUE)

inboundf15_mon_total <- merge(inboundf15_mon_total, inbound_f15_mon3, 
                          by.inboundf15_mon_total=c("Final_ID"),
                          by.inbound_f15_mon3=c("Final_ID"), 
                          all=TRUE)

inboundf15_mon_total <- merge(inboundf15_mon_total, inbound_f15_mon4, 
                          by.inboundf15_mon_total=c("Final_ID"),
                          by.inbound_f15_mon4=c("Final_ID"), 
                          all=TRUE)

inboundf15_mon_total <- merge(inboundf15_mon_total, inbound_f15_mon5, 
                          by.inboundf15_mon_total=c("Final_ID"),
                          by.inbound_f15_mon5=c("Final_ID"), 
                          all=TRUE)


inboundf15_mon_total$day <- inboundf15_mon_total$day <- "monday"


inboundf15_wed_total <- merge(inbound_f15_wed1, inbound_f15_wed2, 
                              by.inbound_f15_wed1=c("Final_ID"),
                              by.inbound_f15_wed2=c("Final_ID"), 
                              all=TRUE)

inboundf15_wed_total <- merge(inboundf15_wed_total, inbound_f15_wed3, 
                              by.inboundf15_total=c("Final_ID"),
                              by.inbound_f15_wed3=c("Final_ID"), 
                              all=TRUE)

inboundf15_wed_total <- merge(inboundf15_wed_total, inbound_f15_wed4, 
                              by.inboundf15_total=c("Final_ID"),
                              by.inbound_f15_wed4=c("Final_ID"), 
                              all=TRUE)

inboundf15_wed_total <- merge(inboundf15_wed_total, inbound_f15_wed5, 
                              by.inboundf15_total=c("Final_ID"),
                              by.inbound_f15_wed5=c("Final_ID"), 
                              all=TRUE)

inboundf15_wed_total$day <- inboundf15_wed_total$day <- "wednesday"



#Fall inbounds

inboundf15_total <- merge(inboundf15_wed_total, inboundf15_mon_total, 
                              by.inboundf15_wed_total=c("Final_ID"),
                              by.inboundf15_mon_total=c("Final_ID"), 
                              all=TRUE)

inboundf15_total$semester <- inboundf15_total$semester <- "f15"

#Merging fall outbounds



outboundf15_mon_total <- merge(outbound_f15_mon1, outbound_f15_mon2, 
                              by.outbound_f15_mon1=c("Final_ID"),
                              by.outbound_f15_mon2=c("Final_ID"), 
                              all=TRUE)

outboundf15_mon_total <- merge(outboundf15_mon_total, outbound_f15_mon3, 
                              by.outboundf15_mon_total=c("Final_ID"),
                              by.outbound_f15_mon3=c("Final_ID"), 
                              all=TRUE)

outboundf15_mon_total <- merge(outboundf15_mon_total, outbound_f15_mon4, 
                              by.outboundf15_mon_total=c("Final_ID"),
                              by.outbound_f15_mon4=c("Final_ID"), 
                              all=TRUE)

outboundf15_mon_total <- merge(outboundf15_mon_total, outbound_f15_mon5, 
                              by.outboundf15_mon_total=c("Final_ID"),
                              by.outbound_f15_mon5=c("Final_ID"), 
                              all=TRUE)


outboundf15_mon_total$day <- outboundf15_mon_total$day <- "monday"


outboundf15_wed_total <- merge(outbound_f15_wed1, outbound_f15_wed2, 
                              by.outbound_f15_wed1=c("Final_ID"),
                              by.outbound_f15_wed2=c("Final_ID"), 
                              all=TRUE)

outboundf15_wed_total <- merge(outboundf15_wed_total, outbound_f15_wed3, 
                              by.outboundf15_total=c("Final_ID"),
                              by.outbound_f15_wed3=c("Final_ID"), 
                              all=TRUE)

outboundf15_wed_total <- merge(outboundf15_wed_total, outbound_f15_wed4, 
                              by.outboundf15_total=c("Final_ID"),
                              by.outbound_f15_wed4=c("Final_ID"), 
                              all=TRUE)

outboundf15_wed_total <- merge(outboundf15_wed_total, outbound_f15_wed5, 
                              by.outboundf15_total=c("Final_ID"),
                              by.outbound_f15_wed5=c("Final_ID"), 
                              all=TRUE)

outboundf15_wed_total$day <- outboundf15_wed_total$day <- "wednesday"



#Fall outbounds

outboundf15_total <- merge(outboundf15_wed_total, outboundf15_mon_total, 
                          by.outboundf15_wed_total=c("Final_ID"),
                          by.outboundf15_mon_total=c("Final_ID"), 
                          all=TRUE)

outboundf15_total$semester <- outboundf15_total$semester <- "f15"



#merging spring inbounds

inbounds16_tue_total <- merge(inbound_s16_tue1, inbound_s16_tue2, 
                              by.inbound_s16_tue1=c("Final_ID"),
                              by.inbound_s16_tue2=c("Final_ID"), 
                              all=TRUE)

inbounds16_tue_total <- merge(inbounds16_tue_total, inbound_s16_tue3, 
                              by.inbounds16_tue_total=c("Final_ID"),
                              by.inbound_s16_tue3=c("Final_ID"), 
                              all=TRUE)

inbounds16_tue_total <- merge(inbounds16_tue_total, inbound_s16_tue4, 
                              by.inbounds16_tue_total=c("Final_ID"),
                              by.inbound_s16_tue4=c("Final_ID"), 
                              all=TRUE)

inbounds16_tue_total <- merge(inbounds16_tue_total, inbound_s16_tue5, 
                              by.inbounds16_tue_total=c("Final_ID"),
                              by.inbound_s16_tue5=c("Final_ID"), 
                              all=TRUE)


inbounds16_tue_total$day <- inbounds16_tue_total$day <- "tuesday"


inbounds16_wed_total <- merge(inbound_s16_wed1, inbound_s16_wed2, 
                              by.inbound_s16_wed1=c("Final_ID"),
                              by.inbound_s16_wed2=c("Final_ID"), 
                              all=TRUE)

inbounds16_wed_total <- merge(inbounds16_wed_total, inbound_s16_wed3, 
                              by.inbounds16_total=c("Final_ID"),
                              by.inbound_s16_wed3=c("Final_ID"), 
                              all=TRUE)

inbounds16_wed_total <- merge(inbounds16_wed_total, inbound_s16_wed4, 
                              by.inbounds16_total=c("Final_ID"),
                              by.inbound_s16_wed4=c("Final_ID"), 
                              all=TRUE)

inbounds16_wed_total <- merge(inbounds16_wed_total, inbound_s16_wed5, 
                              by.inbounds16_total=c("Final_ID"),
                              by.inbound_s16_wed5=c("Final_ID"), 
                              all=TRUE)

inbounds16_wed_total$day <- inbounds16_wed_total$day <- "wednesday"



#Spring inbounds

inbounds16_total <- merge(inbounds16_wed_total, inbounds16_tue_total, 
                          by.inbounds16_wed_total=c("Final_ID"),
                          by.inbounds16_tue_total=c("Final_ID"), 
                          all=TRUE)

inbounds16_total$semester <- inbounds16_total$semester <- "s16"


#Merging Spring outbounds



outbounds16_tue_total <- merge(outbound_s16_tue1, outbound_s16_tue2, 
                               by.outbound_s16_tue1=c("Final_ID"),
                               by.outbound_s16_tue2=c("Final_ID"), 
                               all=TRUE)

outbounds16_tue_total <- merge(outbounds16_tue_total, outbound_s16_tue3, 
                               by.outbounds16_tue_total=c("Final_ID"),
                               by.outbound_s16_tue3=c("Final_ID"), 
                               all=TRUE)

outbounds16_tue_total <- merge(outbounds16_tue_total, outbound_s16_tue4, 
                               by.outbounds16_tue_total=c("Final_ID"),
                               by.outbound_s16_tue4=c("Final_ID"), 
                               all=TRUE)

outbounds16_tue_total <- merge(outbounds16_tue_total, outbound_s16_tue5, 
                               by.outbounds16_tue_total=c("Final_ID"),
                               by.outbound_s16_tue5=c("Final_ID"), 
                               all=TRUE)


outbounds16_tue_total$day <- outbounds16_tue_total$day <- "tuesday"


outbounds16_wed_total <- merge(outbound_s16_wed1, outbound_s16_wed2, 
                               by.outbound_s16_wed1=c("Final_ID"),
                               by.outbound_s16_wed2=c("Final_ID"), 
                               all=TRUE)

outbounds16_wed_total <- merge(outbounds16_wed_total, outbound_s16_wed3, 
                               by.outbounds16_total=c("Final_ID"),
                               by.outbound_s16_wed3=c("Final_ID"), 
                               all=TRUE)

outbounds16_wed_total <- merge(outbounds16_wed_total, outbound_s16_wed4, 
                               by.outbounds16_total=c("Final_ID"),
                               by.outbound_s16_wed4=c("Final_ID"), 
                               all=TRUE)

outbounds16_wed_total <- merge(outbounds16_wed_total, outbound_s16_wed5, 
                               by.outbounds16_total=c("Final_ID"),
                               by.outbound_s16_wed5=c("Final_ID"), 
                               all=TRUE)

outbounds16_wed_total$day <- outbounds16_wed_total$day <- "wednesday"



#SPRING outbounds

outbounds16_total <- merge(outbounds16_wed_total, outbounds16_tue_total, 
                           by.outbounds16_wed_total=c("Final_ID"),
                           by.outbounds16_tue_total=c("Final_ID"), 
                           all=TRUE)

outbounds16_total$semester <- outbounds16_total$semester <- "s16"

#Compiling ALL


inbound_total <- merge(inbounds16_total, inboundf15_total, 
                           by.inboundf15_total=c("Final_ID"),
                           by.inbounds16_total=c("Final_ID"), 
                           all=TRUE)


outbound_total <- merge(outbounds16_total, outboundf15_total, 
                           by.outboundf15_total=c("Final_ID"),
                           by.outbounds16_total=c("Final_ID"), 
                           all=TRUE)


inout <- merge(outbound_total, inbound_total, 
               by.outboundf15_total=c("Final_ID", "semester", "day"),
               by.inbounds16_total=c("Final_ID", "semester", "day"), 
               all=TRUE)

setwd("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA")

#write.csv(inout, file = "inbound_outbound.csv",row.names=FALSE, na="")



setwd("T:/Research folders/CCWTG/Data/Fall2015")



#install.packages("sas7bdat")
library(sas7bdat)




#Fall 15 surveys
mentee_f15 <- read.sas7bdat("T:/Research folders/CCWTG/Data/Fall2015/FINALDATA/mentees.sas7bdat")
mentor_f15 <- read.sas7bdat("T:/Research folders/CCWTG/Data/Fall2015/FINALDATA/mentors.sas7bdat")



#Spring 16 surveys
mentee_s16 <- read.sas7bdat("T:/Research folders/CCWTG/Data/Spring2016/FINALDATA/mentees.sas7bdat")
mentor_s16 <- read.sas7bdat("T:/Research folders/CCWTG/Data/Spring2016/FINALDATA/mentors.sas7bdat")




mentors <- merge(mentor_f15, mentor_s16 , 
                by.mentor_f15=c("Final_ID"),
                by.mentor_s16=c("Final_ID"), 
                all=TRUE)

mentees <- merge(mentee_f15, mentee_s16 , 
                by.mentee_f15=c("Final_ID"),
                by.mentee_s16=c("Final_ID"), 
                all=TRUE)






#head(mentor)

#Youth Depression scale (CESD-10)

cesd0 <- mentees[c("Final_ID", "k0cesd_1", "k0cesd_2", "k0cesd_3", "k0cesd_4", "k0cesd_5", "k0cesd_6", "k0cesd_8", "k0cesd_9", "k0cesd_10")]
cesd5 <- mentees[c("Final_ID", "k5cesd_1", "k5cesd_2", "k5cesd_3", "k5cesd_4", "k5cesd_5", "k5cesd_6", "k5cesd_8", "k5cesd_9", "k5cesd_10")]
  

temp <- mentees[c("k0cesd_1", "k0cesd_2", "k0cesd_3", "k0cesd_4", "k0cesd_5", "k0cesd_6", "k0cesd_8", "k0cesd_9", "k0cesd_10")]

temp$mean0 <- rowMeans(temp)

cesd0$mean0 <- temp$mean0

test <- cesd0[c("mean0")]

#surv5

temp <- mentees[c("k5cesd_1", "k5cesd_2", "k5cesd_3", "k5cesd_4", "k5cesd_5", "k5cesd_6", "k5cesd_8", "k5cesd_9", "k5cesd_10")]

temp$mean5 <- rowMeans(temp)

cesd5$mean5 <- temp$mean5

test$mean5 <- cesd5$mean5

t.test(cesd0$mean0,cesd5$mean5,paired=TRUE)

nodestat=inbound_mon1

nodestat$Final_ID = rownames(nodestat)
#
#cesd <- as.matrix("Final_ID", "cesdmean0", "cesdmean5")
#
#cesd$Final_ID <- cesd5$Final_ID
#cesd$cesdmean5 <- cesd5$mean5
#cesd$cesdmean0 <- cesd0$mean0

cesd <- merge(cesd0, cesd5 , 
                 by.cesd0=c("Final_ID"),
                 by.cesd5=c("Final_ID"), 
                 all=TRUE)

cesd <- cesd[c("Final_ID", "mean0", "mean5")]

names(cesd)[names(cesd) == 'mean0'] <- 'cesd0'
names(cesd)[names(cesd) == 'mean5'] <- 'cesd5'

#DAPS Support

daps_sup0 <- mentees[c("Final_ID", "k0dapsp1_13", "k0dapsp3_5", "k0dapsp3_6", "k0dapsp3_7", "k0dapsp3_9", "k0dapsp3_12", "k0dapsp3_14")]
daps_sup5 <- mentees[c("Final_ID", "k5dapsp1_13", "k5dapsp3_5", "k5dapsp3_6", "k5dapsp3_7", "k5dapsp3_9", "k5dapsp3_12", "k5dapsp3_14")]




temp <- mentees[c("k0dapsp1_13", "k0dapsp3_5", "k0dapsp3_6", "k0dapsp3_7", "k0dapsp3_9", "k0dapsp3_12", "k0dapsp3_14")]

temp$mean0 <- rowMeans(temp)

daps_sup0$mean0 <- temp$mean0

test <- daps_sup0[c("mean0")]

#surv5


temp <- mentees[c("k5dapsp3_5", "k5dapsp3_6", "k5dapsp3_7", "k5dapsp3_9", "k5dapsp3_12", "k5dapsp3_14")]

temp$mean5 <- rowMeans(temp)

daps_sup5$mean5 <- temp$mean5

test$mean5 <- daps_sup5$mean5

#t-test

t.test(daps_sup0$mean0,daps_sup5$mean5,paired=TRUE)



daps_sup <- merge(daps_sup0, daps_sup5 , 
              by.daps_sup0=c("Final_ID"),
              by.daps_sup5=c("Final_ID"), 
              all=TRUE)



daps_sup <- daps_sup[c("Final_ID", "mean0", "mean5")]

names(daps_sup)[names(daps_sup) == 'mean0'] <- 'daps_sup0'
names(daps_sup)[names(daps_sup) == 'mean5'] <- 'daps_sup5'

#CC Mattering


ccblng0 <- mentees[c("Final_ID", "k0blng_1", "k0blng_2", "k0blng_3", "k0blng_4", "k0blng_5")]
ccblng2 <- mentees[c("Final_ID", "k2blng_1", "k2blng_2", "k2blng_3", "k2blng_4", "k2blng_5")]
ccblng3 <- mentees[c("Final_ID", "k3blng_1", "k3blng_2", "k3blng_3", "k3blng_4", "k3blng_5")]
ccblng4 <- mentees[c("Final_ID", "k4blng_1", "k4blng_2", "k4blng_3", "k4blng_4", "k4blng_5")]
ccblng5 <- mentees[c("Final_ID", "k5blng_1", "k5blng_2", "k5blng_3", "k5blng_4", "k5blng_5")]


#baseline

temp <- mentees[c("k0blng_1", "k0blng_2", "k0blng_3", "k0blng_4", "k0blng_5")]

temp$mean0 <- rowMeans(temp)

ccblng0$mean0 <- temp$mean0

test <- ccblng0[c("mean0")]

#surv2

temp <- mentees[c("k2blng_1", "k2blng_2", "k2blng_3", "k2blng_4", "k2blng_5")]

temp$mean2 <- rowMeans(temp)

ccblng2$mean2 <- temp$mean2

test <- ccblng2[c("mean2")]



#surv3

temp <- mentees[c("k3blng_1", "k3blng_2", "k3blng_3", "k3blng_4", "k3blng_5")]

temp$mean3 <- rowMeans(temp)

ccblng3$mean3 <- temp$mean3

test <- ccblng3[c("mean3")]



#surv4

temp <- mentees[c("k4blng_1", "k4blng_2", "k4blng_3", "k4blng_4", "k4blng_5")]

temp$mean4 <- rowMeans(temp)

ccblng4$mean4 <- temp$mean4

test <- ccblng4[c("mean4")]


#surv5

temp <- mentees[c("k5blng_1", "k5blng_2", "k5blng_3", "k5blng_4", "k5blng_5")]

temp$mean5 <- rowMeans(temp)

ccblng5$mean5 <- temp$mean5

test <- ccblng5[c("mean5")]

ccblng <- merge(ccblng0, ccblng2 , 
              by.ccblng0=c("Final_ID"),
              by.ccblng2=c("Final_ID"), 
              all=TRUE)

ccblng <- merge(ccblng, ccblng3 , 
                by.ccblng=c("Final_ID"),
                by.ccblng3=c("Final_ID"), 
                all=TRUE)

ccblng <- merge(ccblng, ccblng4 , 
                by.ccblng=c("Final_ID"),
                by.ccblng4=c("Final_ID"), 
                all=TRUE)

ccblng <- merge(ccblng, ccblng5 , 
                by.ccblng=c("Final_ID"),
                by.ccblng5=c("Final_ID"), 
                all=TRUE)

ccblng <- ccblng[c("Final_ID", "mean0", "mean2", "mean3", "mean4", "mean5")]


names(ccblng)[names(ccblng) == 'mean0'] <- 'ccblng0'
names(ccblng)[names(ccblng) == 'mean2'] <- 'ccblng2'
names(ccblng)[names(ccblng) == 'mean3'] <- 'ccblng3'
names(ccblng)[names(ccblng) == 'mean4'] <- 'ccblng4'
names(ccblng)[names(ccblng) == 'mean5'] <- 'ccblng5'


#mentees survey Alliance survey 3


Kalliance3 <- mentees[c("k3mas_1", "k3mas_2", "k3mas_3", "k3mas_4", "k3mas_5", "k3mas_6", "k3mas_7",
                      "k3mas_8", "k3mas_9", "k3mas_10", "k3mas_11", "k3mas_12", "k3mas_13", "k3mas_14", "k3mas_15")]


#Backward codes

Kalliance3$k3mas_3R  <-  6-Kalliance3$k3mas_3
Kalliance3$k3mas_6R  <-  6-Kalliance3$k3mas_6
Kalliance3$k3mas_9R  <-  6-Kalliance3$k3mas_9
Kalliance3$k3mas_12R <-  6-Kalliance3$k3mas_12
Kalliance3$k3mas_13R <-  6-Kalliance3$k3mas_13
Kalliance3$k3mas_14R <-  6-Kalliance3$k3mas_14
Kalliance3$k3mas_15R <-  6-Kalliance3$k3mas_15


Kalliance3 <- Kalliance3[c("k3mas_1", "k3mas_2", "k3mas_3R", "k3mas_4", "k3mas_5", "k3mas_6R", "k3mas_7",
                            "k3mas_8", "k3mas_9R", "k3mas_10", "k3mas_11", "k3mas_12R", "k3mas_13R", "k3mas_14R", "k3mas_15R")]




#mentees survey Alliance survey 5


Kalliance5 <- mentees[c("k5mas_1", "k5mas_2", "k5mas_3", "k5mas_4", "k5mas_5", "k5mas_6", "k5mas_7",
                       "k5mas_8", "k5mas_9", "k5mas_10", "k5mas_11", "k5mas_12", "k5mas_13", "k5mas_14", "k5mas_15")]


#Backward codes

Kalliance5$k5mas_3R  <-  6-Kalliance5$k5mas_3
Kalliance5$k5mas_6R  <-  6-Kalliance5$k5mas_6
Kalliance5$k5mas_9R  <-  6-Kalliance5$k5mas_9
Kalliance5$k5mas_12R <-  6-Kalliance5$k5mas_12
Kalliance5$k5mas_13R <-  6-Kalliance5$k5mas_13
Kalliance5$k5mas_14R <-  6-Kalliance5$k5mas_14
Kalliance5$k5mas_15R <-  6-Kalliance5$k5mas_15


Kalliance5 <- Kalliance5[c("k5mas_1", "k5mas_2", "k5mas_3R", "k5mas_4", "k5mas_5", "k5mas_6R", "k5mas_7",
                           "k5mas_8", "k5mas_9R", "k5mas_10", "k5mas_11", "k5mas_12R", "k5mas_13R", "k5mas_14R", "k5mas_15R")]



mentees <- merge(ccblng, mentees, 
                by.ccblng=c("Final_ID"), # "semester", "day"),
                by.mentees=c("Final_ID"), # "semester", "day"), 
                all=TRUE)

mentees <- merge(daps_sup, mentees, 
                 by.daps_sup=c("Final_ID"), # "semester", "day"),
                 by.mentees=c("Final_ID"), # "semester", "day"), 
                 all=TRUE)


mentees <- merge(cesd, mentees, 
                 by.cesd=c("Final_ID"), # "semester", "day"),
                 by.mentees=c("Final_ID"), # "semester", "day"), 
                 all=TRUE)

daps_sup


#mentees <- merge(ccblng2, mentees, 
#                by.ccblng2=c("Final_ID"), # "semester", "day"),
#                by.mentees=c("Final_ID"), # "semester", "day"), 
#                all=TRUE)
#
#mentees <- merge(ccblng3, mentees, 
#                by.ccblng3=c("Final_ID"),  #"semester", "day"),
#                by.mentees=c("Final_ID"),  #"semester", "day"), 
#                all=TRUE)
#
#mentees <- merge(ccblng4, mentees, 
#                by.ccblng4=c("Final_ID"),  #"semester", "day"),
#                by.mentees=c("Final_ID"),  #"semester", "day"), 
#                all=TRUE)
#
#mentees <- merge(ccblng5, mentees, 
#                by.ccblng5=c("Final_ID"),  #"semester", "day"),
#                by.mentees=c("Final_ID"),  #"semester", "day"), 
#                all=TRUE)
#
#
#mentees <- merge(cesd, mentees, 
#                by.cesd=c("Final_ID"),    #"semester", "day"),
#                by.mentees=c("Final_ID"),  #"semester", "day"), 
#                all=TRUE)





setwd("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA")

#write.csv(mentees, file = "mentee.csv",row.names=FALSE, na="")
#write.csv(mentees, file = "mentor.csv",row.names=FALSE, na="")
 



###UCI NET



#devtools::install_git('https://github.com/jfaganUK/rucinet')
library(rucinet)
fn <- 'T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine'

#Fall '15 Monday Node level results

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon1-cent")
f15_uci_mon1 <- as.data.frame(m)
f15_uci_mon1$Final_ID = rownames(f15_uci_mon1)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon2-cent")
f15_uci_mon2 <- as.data.frame(m)
f15_uci_mon2$Final_ID = rownames(f15_uci_mon2)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon3-cent")
f15_uci_mon3 <- as.data.frame(m)
f15_uci_mon3$Final_ID = rownames(f15_uci_mon3)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon4-cent")
f15_uci_mon4 <- as.data.frame(m)
f15_uci_mon4$Final_ID = rownames(f15_uci_mon4)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon5-cent")
f15_uci_mon5 <- as.data.frame(m)
f15_uci_mon5$Final_ID = rownames(f15_uci_mon5)


#f15 wed node level results

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed1-cent")
f15_uci_wed1 <- as.data.frame(m)
f15_uci_wed1$Final_ID = rownames(f15_uci_wed1)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed2-cent")
f15_uci_wed2 <- as.data.frame(m)
f15_uci_wed2$Final_ID = rownames(f15_uci_wed2)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed3-cent")
f15_uci_wed3 <- as.data.frame(m)
f15_uci_wed3$Final_ID = rownames(f15_uci_wed3)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed4-cent")
f15_uci_wed4 <- as.data.frame(m)
f15_uci_wed4$Final_ID = rownames(f15_uci_wed4)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed5-cent")
f15_uci_wed5 <- as.data.frame(m)
f15_uci_wed5$Final_ID = rownames(f15_uci_wed5)

#s16 tue node level results

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue1-cent")
s16_uci_tue1 <- as.data.frame(m)
s16_uci_tue1$Final_ID = rownames(s16_uci_tue1)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue2-cent")
s16_uci_tue2 <- as.data.frame(m)
s16_uci_tue2$Final_ID = rownames(s16_uci_tue2)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue3-cent")
s16_uci_tue3 <- as.data.frame(m)
s16_uci_tue3$Final_ID = rownames(s16_uci_tue3)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue4-cent")
s16_uci_tue4 <- as.data.frame(m)
s16_uci_tue4$Final_ID = rownames(s16_uci_tue4)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue5-cent")
s16_uci_tue5 <- as.data.frame(m)
s16_uci_tue5$Final_ID = rownames(s16_uci_tue5)


#s16 wed results

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed1-cent")
s16_uci_wed1 <- as.data.frame(m)
s16_uci_wed1$Final_ID = rownames(s16_uci_wed1)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed2-cent")
s16_uci_wed2 <- as.data.frame(m)
s16_uci_wed2$Final_ID = rownames(s16_uci_wed2)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed3-cent")
s16_uci_wed3 <- as.data.frame(m)
s16_uci_wed3$Final_ID = rownames(s16_uci_wed3)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed4-cent")
s16_uci_wed4 <- as.data.frame(m)
s16_uci_wed4$Final_ID = rownames(s16_uci_wed4)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed5-cent")
s16_uci_wed5 <- as.data.frame(m)
s16_uci_wed5$Final_ID = rownames(s16_uci_wed5)





str(f15_uci_mon1) 

#Change Names Fall
  
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.OutDeg'   ] <-  'OutDeg_1'    
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.Indeg'    ] <-   'Indeg_1'   
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.Out2local']<- 'Out2loca_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.In2local' ] <- 'In2loca_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.OutBonPwr' ]<-'OutBonPw_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.InBonPwr' ] <-'InBonPwr_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.Out2Step' ] <-'Out2Step_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.In2Step'  ] <- 'In2Step_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.OutARD'   ] <-  'OutARD_1'  
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.InARD'    ] <-   'InARD_1'   
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.OutClose' ] <-'OutClose_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.InClose'  ] <- 'InClose_1' 
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.OutEigen' ] <-'OutEigen_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.InEigen'  ] <- 'InEigen_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.Between'  ] <- 'Between_1'
names(f15_uci_mon1)[ names(f15_uci_mon1) == 'F15_Mon1.2StepBet' ] <- 'StepBet_1'
     


names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.OutDeg'  ] <-   'OutDeg_2' 
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.Indeg'    ] <-   'Indeg_2'  
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.Out2local']<- 'Out2loca_2'  
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.Out2local']<- 'Out2loca_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.In2local'] <-  'In2loca_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.OutBonPwr']<- 'OutBonPw_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.InBonPwr'] <- 'InBonPwr_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.Out2Step'] <- 'Out2Step_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.In2Step' ] <-  'In2Step_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.OutARD'  ] <-   'OutARD_2'  
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.InARD'   ] <-    'InARD_2'   
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.OutClose'] <- 'OutClose_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.InClose' ] <-  'InClose_2' 
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.OutEigen'] <- 'OutEigen_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.InEigen' ] <-  'InEigen_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.Between' ] <-  'Between_2'
names(f15_uci_mon2)[ names(f15_uci_mon2) == 'F15_Mon2.2StepBet'] <-  'StepBet_2'

names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.OutDeg'  ] <-   'OutDeg_3'    
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.Indeg'   ] <-    'Indeg_3'   
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.Out2local']<- 'Out2loca_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.In2local'] <- 'In2local_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.OutBonPwr'] <-'OutBonPw_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.InBonPwr'] <- 'InBonPwr_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.Out2Step'] <- 'Out2Step_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.In2Step' ] <-  'In2Step_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.OutARD'  ] <-   'OutARD_3'  
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.InARD'   ] <-    'InARD_3'   
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.OutClose'] <- 'OutClose_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.InClose' ] <-  'InClose_3' 
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.OutEigen'] <- 'OutEigen_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.InEigen' ] <-  'InEigen_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.Between' ] <-  'Between_3'
names(f15_uci_mon3)[ names(f15_uci_mon3) == 'F15_mon3.2StepBet'] <-  'StepBet_3'


names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.OutDeg'  ] <-   'OutDeg_4'    
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.Indeg'   ] <-    'Indeg_4'   
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.Out2local']<- 'Out2loca_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.In2local'] <- 'In2local_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.OutBonPwr'] <-'OutBonPw_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.InBonPwr'] <- 'InBonPwr_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.Out2Step'] <- 'Out2Step_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.In2Step' ] <-  'In2Step_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.OutARD'  ] <-   'OutARD_4'  
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.InARD'   ] <-    'InARD_4'   
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.OutClose'] <- 'OutClose_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.InClose' ] <-  'InClose_4' 
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.OutEigen'] <- 'OutEigen_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.InEigen' ] <-  'InEigen_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.Between' ] <-  'Between_4'
names(f15_uci_mon4)[ names(f15_uci_mon4) == 'F15_mon4.2StepBet'] <-  'StepBet_4'



names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.OutDeg'  ] <-   'OutDeg_5'    
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.Indeg'   ] <-    'Indeg_5'   
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.Out2local']<- 'Out2loca_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.In2local'] <- 'In2local_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.OutBonPwr'] <-'OutBonPw_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.InBonPwr'] <- 'InBonPwr_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.Out2Step'] <- 'Out2Step_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.In2Step' ] <-  'In2Step_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.OutARD'  ] <-   'OutARD_5'  
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.InARD'   ] <-    'InARD_5'   
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.OutClose'] <- 'OutClose_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.InClose' ] <-  'InClose_5' 
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.OutEigen'] <- 'OutEigen_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.InEigen' ] <-  'InEigen_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.Between' ] <-  'Between_5'
names(f15_uci_mon5)[ names(f15_uci_mon5) == 'F15_mon5.2StepBet'] <-  'StepBet_5'



#F15 wednesday Rename


names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.OutDeg'   ] <-  'OutDeg_1'    
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.Indeg'    ] <-   'Indeg_1'   
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.Out2local']<- 'Out2loca_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.In2local' ] <- 'In2loca_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.OutBonPwr' ]<-'OutBonPw_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.InBonPwr' ] <-'InBonPwr_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.Out2Step' ] <-'Out2Step_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.In2Step'  ] <- 'In2Step_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.OutARD'   ] <-  'OutARD_1'  
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.InARD'    ] <-   'InARD_1'   
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.OutClose' ] <-'OutClose_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.InClose'  ] <- 'InClose_1' 
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.OutEigen' ] <-'OutEigen_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.InEigen'  ] <- 'InEigen_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.Between'  ] <- 'Between_1'
names(f15_uci_wed1)[ names(f15_uci_wed1) == 'F15_wed1.2StepBet' ] <- 'StepBet_1'



names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.OutDeg'  ] <-   'OutDeg_2'   
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.Indeg'    ] <-   'Indeg_2' 
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.Out2local']<- 'Out2loca_2'  
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.Out2local']<- 'Out2loca_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.In2local'] <-  'In2loca_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.OutBonPwr']<- 'OutBonPw_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.InBonPwr'] <- 'InBonPwr_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.Out2Step'] <- 'Out2Step_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.In2Step' ] <-  'In2Step_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.OutARD'  ] <-   'OutARD_2'  
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.InARD'   ] <-    'InARD_2'   
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.OutClose'] <- 'OutClose_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.InClose' ] <-  'InClose_2' 
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.OutEigen'] <- 'OutEigen_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.InEigen' ] <-  'InEigen_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.Between' ] <-  'Between_2'
names(f15_uci_wed2)[ names(f15_uci_wed2) == 'F15_wed2.2StepBet'] <-  'StepBet_2'

names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.OutDeg'  ] <-   'OutDeg_3'    
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.Indeg'   ] <-    'Indeg_3'   
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.Out2local']<- 'Out2loca_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.In2local'] <- 'In2local_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.OutBonPwr'] <-'OutBonPw_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.InBonPwr'] <- 'InBonPwr_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.Out2Step'] <- 'Out2Step_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.In2Step' ] <-  'In2Step_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.OutARD'  ] <-   'OutARD_3'  
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.InARD'   ] <-    'InARD_3'   
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.OutClose'] <- 'OutClose_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.InClose' ] <-  'InClose_3' 
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.OutEigen'] <- 'OutEigen_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.InEigen' ] <-  'InEigen_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.Between' ] <-  'Between_3'
names(f15_uci_wed3)[ names(f15_uci_wed3) == 'F15_wed3.2StepBet'] <-  'StepBet_3'


names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.OutDeg'  ] <-   'OutDeg_4'    
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.Indeg'   ] <-    'Indeg_4'   
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.Out2local']<- 'Out2loca_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.In2local'] <- 'In2local_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.OutBonPwr'] <-'OutBonPw_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.InBonPwr'] <- 'InBonPwr_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.Out2Step'] <- 'Out2Step_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.In2Step' ] <-  'In2Step_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.OutARD'  ] <-   'OutARD_4'  
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.InARD'   ] <-    'InARD_4'   
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.OutClose'] <- 'OutClose_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.InClose' ] <-  'InClose_4' 
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.OutEigen'] <- 'OutEigen_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.InEigen' ] <-  'InEigen_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.Between' ] <-  'Between_4'
names(f15_uci_wed4)[ names(f15_uci_wed4) == 'F15_wed4.2StepBet'] <-  'StepBet_4'



names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.OutDeg'  ] <-   'OutDeg_5'    
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.Indeg'   ] <-    'Indeg_5'   
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.Out2local']<- 'Out2loca_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.In2local'] <- 'In2local_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.OutBonPwr'] <-'OutBonPw_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.InBonPwr'] <- 'InBonPwr_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.Out2Step'] <- 'Out2Step_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.In2Step' ] <-  'In2Step_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.OutARD'  ] <-   'OutARD_5'  
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.InARD'   ] <-    'InARD_5'   
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.OutClose'] <- 'OutClose_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.InClose' ] <-  'InClose_5' 
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.OutEigen'] <- 'OutEigen_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.InEigen' ] <-  'InEigen_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.Between' ] <-  'Between_5'
names(f15_uci_wed5)[ names(f15_uci_wed5) == 'F15_wed5.2StepBet'] <-  'StepBet_5'




#S16 Tuesday rename



names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.OutDeg'   ] <-  'OutDeg_1'    
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.Indeg'    ] <-   'Indeg_1'   
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.Out2local']<- 'Out2loca_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.In2local' ] <- 'In2loca_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.OutBonPwr' ]<-'OutBonPw_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.InBonPwr' ] <-'InBonPwr_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.Out2Step' ] <-'Out2Step_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.In2Step'  ] <- 'In2Step_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.OutARD'   ] <-  'OutARD_1'  
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.InARD'    ] <-   'InARD_1'   
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.OutClose' ] <-'OutClose_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.InClose'  ] <- 'InClose_1' 
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.OutEigen' ] <-'OutEigen_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.InEigen'  ] <- 'InEigen_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.Between'  ] <- 'Between_1'
names(s16_uci_tue1)[ names(s16_uci_tue1) == 'S16_tue1.2StepBet' ] <- 'StepBet_1'



names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.OutDeg'  ] <-   'OutDeg_2'   
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.Indeg'    ] <-   'Indeg_2' 
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.Out2local']<- 'Out2loca_2'  
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.Out2local']<- 'Out2loca_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.In2local'] <-  'In2loca_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.OutBonPwr']<- 'OutBonPw_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.InBonPwr'] <- 'InBonPwr_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.Out2Step'] <- 'Out2Step_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.In2Step' ] <-  'In2Step_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.OutARD'  ] <-   'OutARD_2'  
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.InARD'   ] <-    'InARD_2'   
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.OutClose'] <- 'OutClose_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.InClose' ] <-  'InClose_2' 
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.OutEigen'] <- 'OutEigen_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.InEigen' ] <-  'InEigen_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.Between' ] <-  'Between_2'
names(s16_uci_tue2)[ names(s16_uci_tue2) == 'S16_tue2.2StepBet'] <-  'StepBet_2'

names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.OutDeg'  ] <-   'OutDeg_3'    
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.Indeg'   ] <-    'Indeg_3'   
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.Out2local']<- 'Out2loca_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.In2local'] <- 'In2local_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.OutBonPwr'] <-'OutBonPw_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.InBonPwr'] <- 'InBonPwr_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.Out2Step'] <- 'Out2Step_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.In2Step' ] <-  'In2Step_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.OutARD'  ] <-   'OutARD_3'  
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.InARD'   ] <-    'InARD_3'   
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.OutClose'] <- 'OutClose_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.InClose' ] <-  'InClose_3' 
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.OutEigen'] <- 'OutEigen_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.InEigen' ] <-  'InEigen_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.Between' ] <-  'Between_3'
names(s16_uci_tue3)[ names(s16_uci_tue3) == 'S16_tue3.2StepBet'] <-  'StepBet_3'


names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.OutDeg'  ] <-   'OutDeg_4'    
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.Indeg'   ] <-    'Indeg_4'   
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.Out2local']<- 'Out2loca_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.In2local'] <- 'In2local_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.OutBonPwr'] <-'OutBonPw_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.InBonPwr'] <- 'InBonPwr_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.Out2Step'] <- 'Out2Step_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.In2Step' ] <-  'In2Step_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.OutARD'  ] <-   'OutARD_4'  
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.InARD'   ] <-    'InARD_4'   
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.OutClose'] <- 'OutClose_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.InClose' ] <-  'InClose_4' 
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.OutEigen'] <- 'OutEigen_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.InEigen' ] <-  'InEigen_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.Between' ] <-  'Between_4'
names(s16_uci_tue4)[ names(s16_uci_tue4) == 'S16_tue4.2StepBet'] <-  'StepBet_4'



names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.OutDeg'  ] <-   'OutDeg_5'    
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.Indeg'   ] <-    'Indeg_5'   
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.Out2local']<- 'Out2loca_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.In2local'] <- 'In2local_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.OutBonPwr'] <-'OutBonPw_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.InBonPwr'] <- 'InBonPwr_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.Out2Step'] <- 'Out2Step_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.In2Step' ] <-  'In2Step_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.OutARD'  ] <-   'OutARD_5'  
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.InARD'   ] <-    'InARD_5'   
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.OutClose'] <- 'OutClose_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.InClose' ] <-  'InClose_5' 
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.OutEigen'] <- 'OutEigen_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.InEigen' ] <-  'InEigen_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.Between' ] <-  'Between_5'
names(s16_uci_tue5)[ names(s16_uci_tue5) == 's16_tue5.2StepBet'] <-  'StepBet_5'



#S16 Wednesday rename 


names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.OutDeg'   ] <-  'OutDeg_1'    
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.Indeg'    ] <-   'Indeg_1'   
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.Out2local']<- 'Out2loca_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.In2local' ] <- 'In2loca_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.OutBonPwr' ]<-'OutBonPw_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.InBonPwr' ] <-'InBonPwr_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.Out2Step' ] <-'Out2Step_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.In2Step'  ] <- 'In2Step_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.OutARD'   ] <-  'OutARD_1'  
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.InARD'    ] <-   'InARD_1'   
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.OutClose' ] <-'OutClose_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.InClose'  ] <- 'InClose_1' 
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.OutEigen' ] <-'OutEigen_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.InEigen'  ] <- 'InEigen_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.Between'  ] <- 'Between_1'
names(s16_uci_wed1)[ names(s16_uci_wed1) == 'S16_wed1.2StepBet' ] <- 'StepBet_1'

names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.OutDeg'  ] <-   'OutDeg_2'   
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.Indeg'    ] <-   'Indeg_2' 
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.Out2local']<- 'Out2loca_2'  
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.Out2local']<- 'Out2loca_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.In2local'] <-  'In2loca_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.OutBonPwr']<- 'OutBonPw_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.InBonPwr'] <- 'InBonPwr_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.Out2Step'] <- 'Out2Step_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.In2Step' ] <-  'In2Step_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.OutARD'  ] <-   'OutARD_2'  
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.InARD'   ] <-    'InARD_2'   
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.OutClose'] <- 'OutClose_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.InClose' ] <-  'InClose_2' 
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.OutEigen'] <- 'OutEigen_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.InEigen' ] <-  'InEigen_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.Between' ] <-  'Between_2'
names(s16_uci_wed2)[ names(s16_uci_wed2) == 'S16_wed2.2StepBet'] <-  'StepBet_2'

names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.OutDeg'  ] <-   'OutDeg_3'    
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.Indeg'   ] <-    'Indeg_3'   
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.Out2local']<- 'Out2loca_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.In2local'] <- 'In2local_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.OutBonPwr'] <-'OutBonPw_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.InBonPwr'] <- 'InBonPwr_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.Out2Step'] <- 'Out2Step_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.In2Step' ] <-  'In2Step_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.OutARD'  ] <-   'OutARD_3'  
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.InARD'   ] <-    'InARD_3'   
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.OutClose'] <- 'OutClose_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.InClose' ] <-  'InClose_3' 
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.OutEigen'] <- 'OutEigen_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.InEigen' ] <-  'InEigen_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.Between' ] <-  'Between_3'
names(s16_uci_wed3)[ names(s16_uci_wed3) == 'S16_wed3.2StepBet'] <-  'StepBet_3'

names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.OutDeg'  ] <-   'OutDeg_4'    
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.Indeg'   ] <-    'Indeg_4'   
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.Out2local']<- 'Out2loca_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.In2local'] <- 'In2local_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.OutBonPwr'] <-'OutBonPw_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.InBonPwr'] <- 'InBonPwr_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.Out2Step'] <- 'Out2Step_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.In2Step' ] <-  'In2Step_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.OutARD'  ] <-   'OutARD_4'  
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.InARD'   ] <-    'InARD_4'   
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.OutClose'] <- 'OutClose_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.InClose' ] <-  'InClose_4' 
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.OutEigen'] <- 'OutEigen_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.InEigen' ] <-  'InEigen_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.Between' ] <-  'Between_4'
names(s16_uci_wed4)[ names(s16_uci_wed4) == 'S16_wed4.2StepBet'] <-  'StepBet_4'

names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.OutDeg'  ] <-   'OutDeg_5'    
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.Indeg'   ] <-    'Indeg_5'   
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.Out2local']<- 'Out2loca_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.In2local'] <- 'In2local_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.OutBonPwr'] <-'OutBonPw_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.InBonPwr'] <- 'InBonPwr_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.Out2Step'] <- 'Out2Step_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.In2Step' ] <-  'In2Step_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.OutARD'  ] <-   'OutARD_5'  
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.InARD'   ] <-    'InARD_5'   
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.OutClose'] <- 'OutClose_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.InClose' ] <-  'InClose_5' 
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.OutEigen'] <- 'OutEigen_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.InEigen' ] <-  'InEigen_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.Between' ] <-  'Between_5'
names(s16_uci_wed5)[ names(s16_uci_wed5) == 'S16_wed5.2StepBet'] <-  'StepBet_5'



f15_mon_network <- merge(f15_uci_mon1,                                                 f15_uci_mon2, 
                by.f15_uci_mon1=c("Final_ID"), # "semester", "day"),
                by.f15_uci_mon2=c("Final_ID"), # "semester", "day"), 
                all=TRUE)

f15_mon_network <- merge(f15_mon_network,                                              f15_uci_mon3, 
                by.f15_mon_network=c("Final_ID"), # "semester", "day"),
                by.f15_uci_mon3=c("Final_ID"), # "semester", "day"), 
                all=TRUE)


f15_mon_network <- merge(f15_mon_network,                                              f15_uci_mon4, 
                by.f15_mon_network=c("Final_ID"), # "semester", "day"),
                by.f15_uci_mon4=c("Final_ID"), # "semester", "day"), 
                all=TRUE)

f15_mon_network <- merge(f15_mon_network,                                              f15_uci_mon5, 
               by.f15_mon_network=c("Final_ID"), # "semester", "day"),
               by.f15_uci_mon5=c("Final_ID"), # "semester", "day"), 
               all=TRUE)


#F15 wed merger

f15_wed_network <- merge(f15_uci_wed1,                                                 f15_uci_wed2, 
                      by.f15_uci_wed1=c("Final_ID"), # "semester", "day"),
                      by.f15_uci_wed2=c("Final_ID"), # "semester", "day"), 
                                       all=TRUE)

f15_wed_network <- merge(f15_wed_network,                                              f15_uci_wed3, 
                      by.f15_wed_network=c("Final_ID"), # "semester", "day"),
                      by.f15_uci_wed3=c("Final_ID"), # "semester", "day"), 
                                        all=TRUE)


f15_wed_network <- merge(f15_wed_network,                                              f15_uci_wed4, 
                      by.f15_wed_network=c("Final_ID"), # "semester", "day"),
                      by.f15_uci_wed4=c("Final_ID"), # "semester", "day"), 
                                         all=TRUE)

f15_wed_network <- merge(f15_wed_network,                                              f15_uci_wed5, 
                      by.f15_wed_network=c("Final_ID"), # "semester", "day"),
                      by.f15_uci_wed5=c("Final_ID"), # "semester", "day"), 
                                        all=TRUE)



#S16 tue merger

s16_tue_network <- merge(s16_uci_tue1,                                                 s16_uci_tue2, 
                      by.s16_uci_tue1=c("Final_ID"), # "semester", "day"),
                      by.s16_uci_tue2=c("Final_ID"), # "semester", "day"), 
                      all=TRUE)

s16_tue_network <- merge(s16_tue_network,                                              s16_uci_tue3, 
                      by.s16_tue_network=c("Final_ID"), # "semester", "day"),
                      by.s16_uci_tue3=c("Final_ID"), # "semester", "day"), 
                      all=TRUE)


s16_tue_network <- merge(s16_tue_network,                                              s16_uci_tue4, 
                      by.s16_tue_network=c("Final_ID"), # "semester", "day"),
                      by.s16_uci_tue4=c("Final_ID"), # "semester", "day"), 
                      all=TRUE)

s16_tue_network <- merge(s16_tue_network,                                              s16_uci_tue5, 
                         by.s16_tue_network=c("Final_ID"), # "semester", "day"),
                         by.s16_uci_tue5=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)


#S16 wed merger

s16_wed_network <- merge(s16_uci_wed1,                                                 s16_uci_wed2, 
                      by.s16_uci_wed1=c("Final_ID"), # "semester", "day"),
                      by.s16_uci_wed2=c("Final_ID"), # "semester", "day"), 
                             all=TRUE)

s16_wed_network <- merge(s16_wed_network,                                              s16_uci_wed3, 
                      by.s16_wed_network=c("Final_ID"), # "semester", "day"),
                      by.s16_uci_wed3=c("Final_ID"), # "semester", "day"), 
                             all=TRUE)


s16_wed_network <- merge(s16_wed_network,                                              s16_uci_wed4, 
                      by.s16_wed_network=c("Final_ID"), # "semester", "day"),
                      by.s16_uci_wed4=c("Final_ID"), # "semester", "day"), 
                             all=TRUE)

s16_wed_network <- merge(s16_wed_network,                                              s16_uci_wed5, 
                         by.s16_wed_network=c("Final_ID"), # "semester", "day"),
                         by.s16_uci_wed5=c("Final_ID"), # "semester", "day"), 
                                   all=TRUE)


#Merge Fall


f15_network <- merge(f15_wed_network,                                              f15_mon_network, 
                         by.f15_wed_network=c("Final_ID"), # "semester", "day"),
                         by.f15_mon_network=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)

#Merge spring

s16_network <- merge(s16_wed_network,                                              s16_tue_network, 
                         by.s16_wed_network=c("Final_ID"), # "semester", "day"),
                         by.s16_tue_network=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)


#Merge Fall Spring


network <- merge(s16_network,                                                      f15_network, 
                     by.s16_network=c("Final_ID"), # "semester", "day"),
                     by.f15_network=c("Final_ID"), # "semester", "day"), 
                     all=TRUE)

#Final network data


network <- network [order(network$Final_ID),] 
inout <- inout [order(inout$Final_ID),] 


network_final <- merge(network,                                                      inout, 
                 by.network=c("Final_ID"), # "semester", "day"),
                 by.inout=c("Final_ID"), # "semester", "day"), 
                 all=TRUE)



#Import reciprocity

fn <- 'T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine'

#F15 monday

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon1_Reciprocity")
F15_Reciprocity_mon1 <- as.data.frame(m)
F15_Reciprocity_mon1$Final_ID = rownames(F15_Reciprocity_mon1)


m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon2_NodeReciprocity")
F15_Reciprocity_mon2 <- as.data.frame(m)
F15_Reciprocity_mon2$Final_ID = rownames(F15_Reciprocity_mon2)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon3_NodeReciprocity")
F15_Reciprocity_mon3 <- as.data.frame(m)
F15_Reciprocity_mon3$Final_ID = rownames(F15_Reciprocity_mon3)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon4_NodeReciprocity")
F15_Reciprocity_mon4 <- as.data.frame(m)
F15_Reciprocity_mon4$Final_ID = rownames(F15_Reciprocity_mon4)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_Mon5_NodeReciprocity")
F15_Reciprocity_mon5 <- as.data.frame(m)
F15_Reciprocity_mon5$Final_ID = rownames(F15_Reciprocity_mon5)


#F15 Wednesday


m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed1_NodeReciprocity")
F15_Reciprocity_wed1 <- as.data.frame(m)
F15_Reciprocity_wed1$Final_ID = rownames(F15_Reciprocity_wed1)


m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed2_NodeReciprocity")
F15_Reciprocity_wed2 <- as.data.frame(m)
F15_Reciprocity_wed2$Final_ID = rownames(F15_Reciprocity_wed2)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed3_NodeReciprocity")
F15_Reciprocity_wed3 <- as.data.frame(m)
F15_Reciprocity_wed3$Final_ID = rownames(F15_Reciprocity_wed3)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed4_NodeReciprocity")
F15_Reciprocity_wed4 <- as.data.frame(m)
F15_Reciprocity_wed4$Final_ID = rownames(F15_Reciprocity_wed4)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-F15_wed5_NodeReciprocity")
F15_Reciprocity_wed5 <- as.data.frame(m)
F15_Reciprocity_wed5$Final_ID = rownames(F15_Reciprocity_wed5)



#S16 Tuesday

 
                      m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue1_NodeReciprocity")
S16_Reciprocity_tue1 <- as.data.frame(m)
S16_Reciprocity_tue1$Final_ID = rownames(S16_Reciprocity_tue1)


                      m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue2_NodeReciprocity")
S16_Reciprocity_tue2 <- as.data.frame(m)
S16_Reciprocity_tue2$Final_ID = rownames(S16_Reciprocity_tue2)

                      m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue3_NodeReciprocity")
S16_Reciprocity_tue3 <- as.data.frame(m)
S16_Reciprocity_tue3$Final_ID = rownames(S16_Reciprocity_tue3)

                      m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue4_NodeReciprocity")
S16_Reciprocity_tue4 <- as.data.frame(m)
S16_Reciprocity_tue4$Final_ID = rownames(S16_Reciprocity_tue4)

                      m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_tue5_NodeReciprocity")
S16_Reciprocity_tue5 <- as.data.frame(m)
S16_Reciprocity_tue5$Final_ID = rownames(S16_Reciprocity_tue5)


#S16 Wednesday


m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed1_NodeReciprocity")
S16_Reciprocity_wed1 <- as.data.frame(m)
S16_Reciprocity_wed1$Final_ID = rownames(S16_Reciprocity_wed1)


m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed2_NodeReciprocity")
S16_Reciprocity_wed2 <- as.data.frame(m)
S16_Reciprocity_wed2$Final_ID = rownames(S16_Reciprocity_wed2)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed3_NodeReciprocity")
S16_Reciprocity_wed3 <- as.data.frame(m)
S16_Reciprocity_wed3$Final_ID = rownames(S16_Reciprocity_wed3)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed4_NodeReciprocity")
S16_Reciprocity_wed4 <- as.data.frame(m)
S16_Reciprocity_wed4$Final_ID = rownames(S16_Reciprocity_wed4)

m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/SN_Combine-S16_wed5_NodeReciprocity")
S16_Reciprocity_wed5 <- as.data.frame(m)
S16_Reciprocity_wed5$Final_ID = rownames(S16_Reciprocity_wed5)




str(F15_Reciprocity_mon1) 

#Change Names Fall
names(F15_Reciprocity_mon1)[ names(F15_Reciprocity_mon1) ==   "Symmetric"] <-              'Symmetric_1'       
names(F15_Reciprocity_mon1)[ names(F15_Reciprocity_mon1) ==   "Non-Symmetric"] <-      'Non_Symmetric_1'    
names(F15_Reciprocity_mon1)[ names(F15_Reciprocity_mon1) ==   "Out/NonSym"] <-            'Out_NonSym_1'   
names(F15_Reciprocity_mon1)[ names(F15_Reciprocity_mon1) ==   "In/NonSym"]<-               'In_NonSym_1'
names(F15_Reciprocity_mon1)[ names(F15_Reciprocity_mon1) ==   "Sym/Out"] <-                  'Sym_Out_1'
names(F15_Reciprocity_mon1)[ names(F15_Reciprocity_mon1) ==   "Sym/In"]<-                     'Sym_In_1'

names(F15_Reciprocity_mon2)[ names(F15_Reciprocity_mon2) ==   "Symmetric"] <-              'Symmetric_2'       
names(F15_Reciprocity_mon2)[ names(F15_Reciprocity_mon2) ==   "Non-Symmetric"] <-      'Non_Symmetric_2'    
names(F15_Reciprocity_mon2)[ names(F15_Reciprocity_mon2) ==   "Out/NonSym"] <-            'Out_NonSym_2'   
names(F15_Reciprocity_mon2)[ names(F15_Reciprocity_mon2) ==   "In/NonSym"]<-               'In_NonSym_2'
names(F15_Reciprocity_mon2)[ names(F15_Reciprocity_mon2) ==   "Sym/Out"] <-                  'Sym_Out_2'
names(F15_Reciprocity_mon2)[ names(F15_Reciprocity_mon2) ==   "Sym/In"]<-                     'Sym_In_2'

names(F15_Reciprocity_mon3)[ names(F15_Reciprocity_mon3) ==   "Symmetric"] <-              'Symmetric_3'       
names(F15_Reciprocity_mon3)[ names(F15_Reciprocity_mon3) ==   "Non-Symmetric"] <-      'Non_Symmetric_3'    
names(F15_Reciprocity_mon3)[ names(F15_Reciprocity_mon3) ==   "Out/NonSym"] <-            'Out_NonSym_3'   
names(F15_Reciprocity_mon3)[ names(F15_Reciprocity_mon3) ==   "In/NonSym"]<-               'In_NonSym_3'
names(F15_Reciprocity_mon3)[ names(F15_Reciprocity_mon3) ==   "Sym/Out"] <-                  'Sym_Out_3'
names(F15_Reciprocity_mon3)[ names(F15_Reciprocity_mon3) ==   "Sym/In"]<-                     'Sym_In_3'

names(F15_Reciprocity_mon4)[ names(F15_Reciprocity_mon4) ==   "Symmetric"] <-              'Symmetric_4'       
names(F15_Reciprocity_mon4)[ names(F15_Reciprocity_mon4) ==   "Non-Symmetric"] <-      'Non_Symmetric_4'    
names(F15_Reciprocity_mon4)[ names(F15_Reciprocity_mon4) ==   "Out/NonSym"] <-            'Out_NonSym_4'   
names(F15_Reciprocity_mon4)[ names(F15_Reciprocity_mon4) ==   "In/NonSym"]<-               'In_NonSym_4'
names(F15_Reciprocity_mon4)[ names(F15_Reciprocity_mon4) ==   "Sym/Out"] <-                  'Sym_Out_4'
names(F15_Reciprocity_mon4)[ names(F15_Reciprocity_mon4) ==   "Sym/In"]<-                     'Sym_In_4'

names(F15_Reciprocity_mon5)[ names(F15_Reciprocity_mon5) ==   "Symmetric"] <-              'Symmetric_5'       
names(F15_Reciprocity_mon5)[ names(F15_Reciprocity_mon5) ==   "Non-Symmetric"] <-      'Non_Symmetric_5'    
names(F15_Reciprocity_mon5)[ names(F15_Reciprocity_mon5) ==   "Out/NonSym"] <-            'Out_NonSym_5'   
names(F15_Reciprocity_mon5)[ names(F15_Reciprocity_mon5) ==   "In/NonSym"]<-               'In_NonSym_5'
names(F15_Reciprocity_mon5)[ names(F15_Reciprocity_mon5) ==   "Sym/Out"] <-                  'Sym_Out_5'
names(F15_Reciprocity_mon5)[ names(F15_Reciprocity_mon5) ==   "Sym/In"]<-                     'Sym_In_5'


#Change Name fall Wed

names(F15_Reciprocity_wed1)[ names(F15_Reciprocity_wed1) ==   "Symmetric"] <-              'Symmetric_1'       
names(F15_Reciprocity_wed1)[ names(F15_Reciprocity_wed1) ==   "Non-Symmetric"] <-      'Non_Symmetric_1'    
names(F15_Reciprocity_wed1)[ names(F15_Reciprocity_wed1) ==   "Out/NonSym"] <-            'Out_NonSym_1'   
names(F15_Reciprocity_wed1)[ names(F15_Reciprocity_wed1) ==   "In/NonSym"]<-               'In_NonSym_1'
names(F15_Reciprocity_wed1)[ names(F15_Reciprocity_wed1) ==   "Sym/Out"] <-                  'Sym_Out_1'
names(F15_Reciprocity_wed1)[ names(F15_Reciprocity_wed1) ==   "Sym/In"]<-                     'Sym_In_1'

names(F15_Reciprocity_wed2)[ names(F15_Reciprocity_wed2) ==   "Symmetric"] <-              'Symmetric_2'       
names(F15_Reciprocity_wed2)[ names(F15_Reciprocity_wed2) ==   "Non-Symmetric"] <-      'Non_Symmetric_2'    
names(F15_Reciprocity_wed2)[ names(F15_Reciprocity_wed2) ==   "Out/NonSym"] <-            'Out_NonSym_2'   
names(F15_Reciprocity_wed2)[ names(F15_Reciprocity_wed2) ==   "In/NonSym"]<-               'In_NonSym_2'
names(F15_Reciprocity_wed2)[ names(F15_Reciprocity_wed2) ==   "Sym/Out"] <-                  'Sym_Out_2'
names(F15_Reciprocity_wed2)[ names(F15_Reciprocity_wed2) ==   "Sym/In"]<-                     'Sym_In_2'

names(F15_Reciprocity_wed3)[ names(F15_Reciprocity_wed3) ==   "Symmetric"] <-              'Symmetric_3'       
names(F15_Reciprocity_wed3)[ names(F15_Reciprocity_wed3) ==   "Non-Symmetric"] <-      'Non_Symmetric_3'    
names(F15_Reciprocity_wed3)[ names(F15_Reciprocity_wed3) ==   "Out/NonSym"] <-            'Out_NonSym_3'   
names(F15_Reciprocity_wed3)[ names(F15_Reciprocity_wed3) ==   "In/NonSym"]<-               'In_NonSym_3'
names(F15_Reciprocity_wed3)[ names(F15_Reciprocity_wed3) ==   "Sym/Out"] <-                  'Sym_Out_3'
names(F15_Reciprocity_wed3)[ names(F15_Reciprocity_wed3) ==   "Sym/In"]<-                     'Sym_In_3'

names(F15_Reciprocity_wed4)[ names(F15_Reciprocity_wed4) ==   "Symmetric"] <-              'Symmetric_4'       
names(F15_Reciprocity_wed4)[ names(F15_Reciprocity_wed4) ==   "Non-Symmetric"] <-      'Non_Symmetric_4'    
names(F15_Reciprocity_wed4)[ names(F15_Reciprocity_wed4) ==   "Out/NonSym"] <-            'Out_NonSym_4'   
names(F15_Reciprocity_wed4)[ names(F15_Reciprocity_wed4) ==   "In/NonSym"]<-               'In_NonSym_4'
names(F15_Reciprocity_wed4)[ names(F15_Reciprocity_wed4) ==   "Sym/Out"] <-                  'Sym_Out_4'
names(F15_Reciprocity_wed4)[ names(F15_Reciprocity_wed4) ==   "Sym/In"]<-                     'Sym_In_4'

names(F15_Reciprocity_wed5)[ names(F15_Reciprocity_wed5) ==   "Symmetric"] <-              'Symmetric_5'       
names(F15_Reciprocity_wed5)[ names(F15_Reciprocity_wed5) ==   "Non-Symmetric"] <-      'Non_Symmetric_5'    
names(F15_Reciprocity_wed5)[ names(F15_Reciprocity_wed5) ==   "Out/NonSym"] <-            'Out_NonSym_5'   
names(F15_Reciprocity_wed5)[ names(F15_Reciprocity_wed5) ==   "In/NonSym"]<-               'In_NonSym_5'
names(F15_Reciprocity_wed5)[ names(F15_Reciprocity_wed5) ==   "Sym/Out"] <-                  'Sym_Out_5'
names(F15_Reciprocity_wed5)[ names(F15_Reciprocity_wed5) ==   "Sym/In"]<-                     'Sym_In_5'

#Change Name Spring Tue


names(S16_Reciprocity_tue1)[ names(S16_Reciprocity_tue1) ==   "Symmetric"] <-              'Symmetric_1'       
names(S16_Reciprocity_tue1)[ names(S16_Reciprocity_tue1) ==   "Non-Symmetric"] <-      'Non_Symmetric_1'    
names(S16_Reciprocity_tue1)[ names(S16_Reciprocity_tue1) ==   "Out/NonSym"] <-            'Out_NonSym_1'   
names(S16_Reciprocity_tue1)[ names(S16_Reciprocity_tue1) ==   "In/NonSym"]<-               'In_NonSym_1'
names(S16_Reciprocity_tue1)[ names(S16_Reciprocity_tue1) ==   "Sym/Out"] <-                  'Sym_Out_1'
names(S16_Reciprocity_tue1)[ names(S16_Reciprocity_tue1) ==   "Sym/In"]<-                     'Sym_In_1'

names(S16_Reciprocity_tue2)[ names(S16_Reciprocity_tue2) ==   "Symmetric"] <-              'Symmetric_2'       
names(S16_Reciprocity_tue2)[ names(S16_Reciprocity_tue2) ==   "Non-Symmetric"] <-      'Non_Symmetric_2'    
names(S16_Reciprocity_tue2)[ names(S16_Reciprocity_tue2) ==   "Out/NonSym"] <-            'Out_NonSym_2'   
names(S16_Reciprocity_tue2)[ names(S16_Reciprocity_tue2) ==   "In/NonSym"]<-               'In_NonSym_2'
names(S16_Reciprocity_tue2)[ names(S16_Reciprocity_tue2) ==   "Sym/Out"] <-                  'Sym_Out_2'
names(S16_Reciprocity_tue2)[ names(S16_Reciprocity_tue2) ==   "Sym/In"]<-                     'Sym_In_2'

names(S16_Reciprocity_tue3)[ names(S16_Reciprocity_tue3) ==   "Symmetric"] <-              'Symmetric_3'       
names(S16_Reciprocity_tue3)[ names(S16_Reciprocity_tue3) ==   "Non-Symmetric"] <-      'Non_Symmetric_3'    
names(S16_Reciprocity_tue3)[ names(S16_Reciprocity_tue3) ==   "Out/NonSym"] <-            'Out_NonSym_3'   
names(S16_Reciprocity_tue3)[ names(S16_Reciprocity_tue3) ==   "In/NonSym"]<-               'In_NonSym_3'
names(S16_Reciprocity_tue3)[ names(S16_Reciprocity_tue3) ==   "Sym/Out"] <-                  'Sym_Out_3'
names(S16_Reciprocity_tue3)[ names(S16_Reciprocity_tue3) ==   "Sym/In"]<-                     'Sym_In_3'

names(S16_Reciprocity_tue4)[ names(S16_Reciprocity_tue4) ==   "Symmetric"] <-              'Symmetric_4'       
names(S16_Reciprocity_tue4)[ names(S16_Reciprocity_tue4) ==   "Non-Symmetric"] <-      'Non_Symmetric_4'    
names(S16_Reciprocity_tue4)[ names(S16_Reciprocity_tue4) ==   "Out/NonSym"] <-            'Out_NonSym_4'   
names(S16_Reciprocity_tue4)[ names(S16_Reciprocity_tue4) ==   "In/NonSym"]<-               'In_NonSym_4'
names(S16_Reciprocity_tue4)[ names(S16_Reciprocity_tue4) ==   "Sym/Out"] <-                  'Sym_Out_4'
names(S16_Reciprocity_tue4)[ names(S16_Reciprocity_tue4) ==   "Sym/In"]<-                     'Sym_In_4'

names(S16_Reciprocity_tue5)[ names(S16_Reciprocity_tue5) ==   "Symmetric"] <-              'Symmetric_5'       
names(S16_Reciprocity_tue5)[ names(S16_Reciprocity_tue5) ==   "Non-Symmetric"] <-      'Non_Symmetric_5'    
names(S16_Reciprocity_tue5)[ names(S16_Reciprocity_tue5) ==   "Out/NonSym"] <-            'Out_NonSym_5'   
names(S16_Reciprocity_tue5)[ names(S16_Reciprocity_tue5) ==   "In/NonSym"]<-               'In_NonSym_5'
names(S16_Reciprocity_tue5)[ names(S16_Reciprocity_tue5) ==   "Sym/Out"] <-                  'Sym_Out_5'
names(S16_Reciprocity_tue5)[ names(S16_Reciprocity_tue5) ==   "Sym/In"]<-                     'Sym_In_5'


   
#Change Name spring Wed

names(S16_Reciprocity_wed1)[ names(S16_Reciprocity_wed1) ==   "Symmetric"] <-              'Symmetric_1'       
names(S16_Reciprocity_wed1)[ names(S16_Reciprocity_wed1) ==   "Non-Symmetric"] <-      'Non_Symmetric_1'    
names(S16_Reciprocity_wed1)[ names(S16_Reciprocity_wed1) ==   "Out/NonSym"] <-            'Out_NonSym_1'   
names(S16_Reciprocity_wed1)[ names(S16_Reciprocity_wed1) ==   "In/NonSym"]<-               'In_NonSym_1'
names(S16_Reciprocity_wed1)[ names(S16_Reciprocity_wed1) ==   "Sym/Out"] <-                  'Sym_Out_1'
names(S16_Reciprocity_wed1)[ names(S16_Reciprocity_wed1) ==   "Sym/In"]<-                     'Sym_In_1'

names(S16_Reciprocity_wed2)[ names(S16_Reciprocity_wed2) ==   "Symmetric"] <-              'Symmetric_2'       
names(S16_Reciprocity_wed2)[ names(S16_Reciprocity_wed2) ==   "Non-Symmetric"] <-      'Non_Symmetric_2'    
names(S16_Reciprocity_wed2)[ names(S16_Reciprocity_wed2) ==   "Out/NonSym"] <-            'Out_NonSym_2'   
names(S16_Reciprocity_wed2)[ names(S16_Reciprocity_wed2) ==   "In/NonSym"]<-               'In_NonSym_2'
names(S16_Reciprocity_wed2)[ names(S16_Reciprocity_wed2) ==   "Sym/Out"] <-                  'Sym_Out_2'
names(S16_Reciprocity_wed2)[ names(S16_Reciprocity_wed2) ==   "Sym/In"]<-                     'Sym_In_2'

names(S16_Reciprocity_wed3)[ names(S16_Reciprocity_wed3) ==   "Symmetric"] <-              'Symmetric_3'       
names(S16_Reciprocity_wed3)[ names(S16_Reciprocity_wed3) ==   "Non-Symmetric"] <-      'Non_Symmetric_3'    
names(S16_Reciprocity_wed3)[ names(S16_Reciprocity_wed3) ==   "Out/NonSym"] <-            'Out_NonSym_3'   
names(S16_Reciprocity_wed3)[ names(S16_Reciprocity_wed3) ==   "In/NonSym"]<-               'In_NonSym_3'
names(S16_Reciprocity_wed3)[ names(S16_Reciprocity_wed3) ==   "Sym/Out"] <-                  'Sym_Out_3'
names(S16_Reciprocity_wed3)[ names(S16_Reciprocity_wed3) ==   "Sym/In"]<-                     'Sym_In_3'

names(S16_Reciprocity_wed4)[ names(S16_Reciprocity_wed4) ==   "Symmetric"] <-              'Symmetric_4'       
names(S16_Reciprocity_wed4)[ names(S16_Reciprocity_wed4) ==   "Non-Symmetric"] <-      'Non_Symmetric_4'    
names(S16_Reciprocity_wed4)[ names(S16_Reciprocity_wed4) ==   "Out/NonSym"] <-            'Out_NonSym_4'   
names(S16_Reciprocity_wed4)[ names(S16_Reciprocity_wed4) ==   "In/NonSym"]<-               'In_NonSym_4'
names(S16_Reciprocity_wed4)[ names(S16_Reciprocity_wed4) ==   "Sym/Out"] <-                  'Sym_Out_4'
names(S16_Reciprocity_wed4)[ names(S16_Reciprocity_wed4) ==   "Sym/In"]<-                     'Sym_In_4'

names(S16_Reciprocity_wed5)[ names(S16_Reciprocity_wed5) ==   "Symmetric"] <-              'Symmetric_5'       
names(S16_Reciprocity_wed5)[ names(S16_Reciprocity_wed5) ==   "Non-Symmetric"] <-      'Non_Symmetric_5'    
names(S16_Reciprocity_wed5)[ names(S16_Reciprocity_wed5) ==   "Out/NonSym"] <-            'Out_NonSym_5'   
names(S16_Reciprocity_wed5)[ names(S16_Reciprocity_wed5) ==   "In/NonSym"]<-               'In_NonSym_5'
names(S16_Reciprocity_wed5)[ names(S16_Reciprocity_wed5) ==   "Sym/Out"] <-                  'Sym_Out_5'
names(S16_Reciprocity_wed5)[ names(S16_Reciprocity_wed5) ==   "Sym/In"]<-                     'Sym_In_5'



###########################################################################################
############################################################################################
##########################################################################################
#############################################################################################
##############################################################################################


F15_Reciprocity_mon1 <- F15_Reciprocity_mon1 [order(F15_Reciprocity_mon1$Final_ID),]
F15_Reciprocity_mon2 <- F15_Reciprocity_mon2 [order(F15_Reciprocity_mon2$Final_ID),]
F15_Reciprocity_mon3 <- F15_Reciprocity_mon3 [order(F15_Reciprocity_mon3$Final_ID),]
F15_Reciprocity_mon4 <- F15_Reciprocity_mon4 [order(F15_Reciprocity_mon4$Final_ID),]
F15_Reciprocity_mon5 <- F15_Reciprocity_mon5 [order(F15_Reciprocity_mon5$Final_ID),]

F15_Reciprocity_wed1 <- F15_Reciprocity_wed1 [order(F15_Reciprocity_wed1$Final_ID),]
F15_Reciprocity_wed2 <- F15_Reciprocity_wed2 [order(F15_Reciprocity_wed2$Final_ID),]
F15_Reciprocity_wed3 <- F15_Reciprocity_wed3 [order(F15_Reciprocity_wed3$Final_ID),]
F15_Reciprocity_wed4 <- F15_Reciprocity_wed4 [order(F15_Reciprocity_wed4$Final_ID),]
F15_Reciprocity_wed5 <- F15_Reciprocity_wed5 [order(F15_Reciprocity_wed5$Final_ID),]

S16_Reciprocity_tue1 <- S16_Reciprocity_tue1 [order(S16_Reciprocity_tue1$Final_ID),]
S16_Reciprocity_tue2 <- S16_Reciprocity_tue2 [order(S16_Reciprocity_tue2$Final_ID),]
S16_Reciprocity_tue3 <- S16_Reciprocity_tue3 [order(S16_Reciprocity_tue3$Final_ID),]
S16_Reciprocity_tue4 <- S16_Reciprocity_tue4 [order(S16_Reciprocity_tue4$Final_ID),]
S16_Reciprocity_tue5 <- S16_Reciprocity_tue5 [order(S16_Reciprocity_tue5$Final_ID),]

S16_Reciprocity_wed1 <- S16_Reciprocity_wed1 [order(S16_Reciprocity_wed1$Final_ID),]
S16_Reciprocity_wed2 <- S16_Reciprocity_wed2 [order(S16_Reciprocity_wed2$Final_ID),]
S16_Reciprocity_wed3 <- S16_Reciprocity_wed3 [order(S16_Reciprocity_wed3$Final_ID),]
S16_Reciprocity_wed4 <- S16_Reciprocity_wed4 [order(S16_Reciprocity_wed4$Final_ID),]
S16_Reciprocity_wed5 <- S16_Reciprocity_wed5 [order(S16_Reciprocity_wed5$Final_ID),]



f15_mon_rec <- merge(F15_Reciprocity_mon1,                                     F15_Reciprocity_mon2, 
                         by.F15_Reciprocity_mon1=c("Final_ID"), # "semester", "day"),
                         by.F15_Reciprocity_mon2=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)

f15_mon_rec <- merge(f15_mon_rec,                                              F15_Reciprocity_mon3, 
                         by.f15_mon_rec=c("Final_ID"), # "semester", "day"),
                         by.F15_Reciprocity_mon3=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)


f15_mon_rec <- merge(f15_mon_rec,                                              F15_Reciprocity_mon4, 
                         by.f15_mon_rec=c("Final_ID"), # "semester", "day"),
                         by.F15_Reciprocity_mon4=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)

f15_mon_rec <- merge(f15_mon_rec,                                              F15_Reciprocity_mon5, 
                         by.f15_mon_rec=c("Final_ID"), # "semester", "day"),
                         by.F15_Reciprocity_mon5=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)


#F15 wed merger

f15_wed_rec <- merge(F15_Reciprocity_wed1,                                     F15_Reciprocity_wed2, 
                         by.F15_Reciprocity_wed1=c("Final_ID"), # "semester", "day"),
                         by.F15_Reciprocity_wed2=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)

f15_wed_rec <- merge(f15_wed_rec,                                              F15_Reciprocity_wed3, 
                         by.f15_wed_rec=c("Final_ID"), # "semester", "day"),
                         by.F15_Reciprocity_wed3=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)


f15_wed_rec <- merge(f15_wed_rec,                                              F15_Reciprocity_wed4, 
                         by.f15_wed_rec=c("Final_ID"), # "semester", "day"),
                         by.F15_Reciprocity_wed4=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)

f15_wed_rec <- merge(f15_wed_rec,                                              F15_Reciprocity_wed5, 
                         by.f15_wed_rec=c("Final_ID"), # "semester", "day"),
                         by.F15_Reciprocity_wed5=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)



#S16 tue merger

s16_tue_rec <- merge(S16_Reciprocity_tue1,                                     S16_Reciprocity_tue2, 
                         by.S16_Reciprocity_tue1=c("Final_ID"), # "semester", "day"),
                         by.S16_Reciprocity_tue2=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)

s16_tue_rec <- merge(s16_tue_rec,                                              S16_Reciprocity_tue3, 
                         by.s16_tue_rec=c("Final_ID"), # "semester", "day"),
                         by.S16_Reciprocity_tue3=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)


s16_tue_rec <- merge(s16_tue_rec,                                              S16_Reciprocity_tue4, 
                         by.s16_tue_rec=c("Final_ID"), # "semester", "day"),
                         by.S16_Reciprocity_tue4=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)

s16_tue_rec <- merge(s16_tue_rec,                                              S16_Reciprocity_tue5, 
                         by.s16_tue_rec=c("Final_ID"), # "semester", "day"),
                         by.S16_Reciprocity_tue5=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)


#S16 wed merger

s16_wed_rec <- merge(S16_Reciprocity_wed1,                                    S16_Reciprocity_wed2, 
                         by.S16_Reciprocity_wed1=c("Final_ID"), # "semester", "day"),
                         by.S16_Reciprocity_wed2=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)

s16_wed_rec <- merge(s16_wed_rec,                                              S16_Reciprocity_wed3, 
                         by.s16_wed_rec=c("Final_ID"), # "semester", "day"),
                         by.S16_Reciprocity_wed3=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)


s16_wed_rec <- merge(s16_wed_rec,                                              S16_Reciprocity_wed4, 
                         by.s16_wed_rec=c("Final_ID"), # "semester", "day"),
                         by.S16_Reciprocity_wed4=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)

s16_wed_rec <- merge(s16_wed_rec,                                              S16_Reciprocity_wed5, 
                         by.s16_wed_rec=c("Final_ID"), # "semester", "day"),
                         by.S16_Reciprocity_wed5=c("Final_ID"), # "semester", "day"), 
                         all=TRUE)


#merge Fall - reciprocity

f15_rec <- merge(f15_mon_rec,                                              f15_wed_rec, 
                     by.f15_mon_rec=c("Final_ID"), # "semester", "day"),
                     by.f15_wed_rec=c("Final_ID"), # "semester", "day"), 
                     all=TRUE)


#merge spring - reciprocity

s16_rec <- merge(s16_tue_rec,                                              s16_wed_rec, 
                 by.s16_tue_rec=c("Final_ID"), # "semester", "day"),
                 by.s16_wed_rec=c("Final_ID"), # "semester", "day"), 
                 all=TRUE)

#Final

reciprocity_final <- merge(f15_rec,                                              s16_rec, 
                                by.f15_rec=c("Final_ID"), # "semester", "day"),
                                by.s16_rec=c("Final_ID"), # "semester", "day"), 
                                all=TRUE)


#merging into network_final


network_final <- merge(network_final,                                                      reciprocity_final, 
                       by.network_final=c("Final_ID"), # "semester", "day"),
                       by.reciprocity_final=c("Final_ID"), # "semester", "day"), 
                       all=TRUE)


m <- readUCINET("T:/Research folders/CCWTG/Analyses/Papers/NEIL CAPSTONE/DATA/UCINet/csv adjacency files/SN_Combine/Results/Images/Mentee only3")
mentee_only <- as.data.frame(m)
mentee_only$Final_ID = rownames(mentee_only)



#write.csv(network_final, file = "network_data.csv",row.names=FALSE, na="")


##############################################################################################################
##############################################################################################################
##############################################################################################################
##############################################################################################################
##############################################################################################################
##############################################################################################################
##############################################################################################################
##############################################################################################################
##############################################################################################################
##############################################################################################################
##############################################################################################################




