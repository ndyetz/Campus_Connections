rm(list = ls(all.names = TRUE))

install.packages("CTT")
install.packages("GGally")
install.packages("ggplot2")
install.packages("lattice")
install.packages("gridExtra")
install.packages("igraph")
install.packages("dplyr")
install.packages("tidyr")
install.packages("igraph")
install.packages("statnet")

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



elmk_2 <- subset(elmk, Receiver_Missing == 0)
elmk_2 <- subset(elmk, Sender_Missing == 0)

elmk_2 <- elmk_2[c("Sender_Final_ID", "survnum", "Receiver_Final_ID", "night", "sn1", "sn2")]

elmk_2_s1 <- subset(elmk_2, survnum == 1)
elmk_2_s2 <- subset(elmk_2, survnum == 2)
elmk_2_s3 <- subset(elmk_2, survnum == 3)
elmk_2_s4 <- subset(elmk_2, survnum == 4)
elmk_2_s5 <- subset(elmk_2, survnum == 5)


elmk_2[["sn1"]][is.na(elmk_2[["sn1"]])] <- 0


sender <-   elmk_2[c("Sender_Final_ID")]
receiver <- elmk_2[c("Receiver_Final_ID")]
weight <-   elmk_2 [c("sn1")]


el <- as.data.frame(cbind(sender, receiver, weight))

class(el) #<- This must read as a "data.frame"



sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(NA, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday

evcent(dat, g=1, nodes=NULL, gmode="digraph", diag=FALSE,
       tmaxdev=FALSE, rescale=FALSE)










