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
elmk <- read.csv("S16_SN_MentorMentee.csv", header = TRUE) 

sn_include<- read.csv("F15_SN_Include.csv", header = TRUE)
#sn_include_youth <- read.csv("F15_SN_Include_Youth.csv", header = TRUE)


##Monday surveys

sn_include_monday_1    <- read.csv("S16_SN_inc_mon_surv1.csv", header = TRUE)
sn_include_monday_2    <- read.csv("S16_SN_inc_mon_surv2.csv", header = TRUE)
sn_include_monday_3    <- read.csv("S16_SN_inc_mon_surv3.csv", header = TRUE)
sn_include_monday_4    <- read.csv("S16_SN_inc_mon_surv4.csv", header = TRUE)
sn_include_monday_5    <- read.csv("S16_SN_inc_mon_surv5.csv", header = TRUE)

##Tuesday surveys

sn_include_tuesday_1    <- read.csv("S16_SN_inc_tue_surv1.csv", header = TRUE)
sn_include_tuesday_2    <- read.csv("S16_SN_inc_tue_surv2.csv", header = TRUE)
sn_include_tuesday_3    <- read.csv("S16_SN_inc_tue_surv3.csv", header = TRUE)
sn_include_tuesday_4    <- read.csv("S16_SN_inc_tue_surv4.csv", header = TRUE)
sn_include_tuesday_5    <- read.csv("S16_SN_inc_tue_surv5.csv", header = TRUE)



##Wednesday surveys

sn_include_wednesday_1    <- read.csv("S16_SN_inc_wed_surv1.csv", header = TRUE)
sn_include_wednesday_2    <- read.csv("S16_SN_inc_wed_surv2.csv", header = TRUE)
sn_include_wednesday_3    <- read.csv("S16_SN_inc_wed_surv3.csv", header = TRUE)
sn_include_wednesday_4    <- read.csv("S16_SN_inc_wed_surv4.csv", header = TRUE)
sn_include_wednesday_5    <- read.csv("S16_SN_inc_wed_surv5.csv", header = TRUE)


##STILL NEED TO CREATE THURSDAY FILES IN FORMAT FILE


################################################################################################################################
################################################################################################################################
###########################NEIL CREATING YOUTH SOCIAL NETWORKS FOR PROJECT SPRING '16###########################################
################################################Control Nights = T/W############################################################
################################################################################################################################
################################################################################################################################
################################################################################################################################

#sn1_1 <- elmk_1_monday[c("sn1")]
#sn1_5 <- elmk_5_monday[c("sn1")]


#mytable <- table(sn1_1$sn1)
#mytable5 <- table(sn1_5$sn1)

#Separating The edgelists by night


elmk_1 <- subset(elmk, survnum == 1)
elmk_2 <- subset(elmk, survnum == 2)
elmk_3 <- subset(elmk, survnum == 3)
elmk_4 <- subset(elmk, survnum == 4)
elmk_5 <- subset(elmk, survnum == 5)

#survey 1 edgelist by night

elmk_1_monday <-    subset(elmk_1, night=="monday")
elmk_1_tuesday <-   subset(elmk_1, night=="tuesday")
elmk_1_wednesday <- subset(elmk_1, night=="wednesday")
elmk_1_thursday <-  subset(elmk_1, night=="thursday")


#survey 2 edgelist by night

elmk_2_monday <-    subset(elmk_2, night=="monday")
elmk_2_tuesday <-   subset(elmk_2, night=="tuesday")
elmk_2_wednesday <- subset(elmk_2, night=="wednesday")
elmk_2_thursday <-  subset(elmk_2, night=="thursday")


#survey 3 edgelist by night

elmk_3_monday <-    subset(elmk_3, night=="monday")
elmk_3_tuesday <-   subset(elmk_3, night=="tuesday")
elmk_3_wednesday <- subset(elmk_3, night=="wednesday")
elmk_3_thursday <-  subset(elmk_3, night=="thursday")

#survey 4 edgelist by night

elmk_4_monday <-    subset(elmk_4, night=="monday")
elmk_4_tuesday <-   subset(elmk_4, night=="tuesday")
elmk_4_wednesday <- subset(elmk_4, night=="wednesday")
elmk_4_thursday <-  subset(elmk_4, night=="thursday")

#survey 5 edgelist by night

elmk_5_monday <-    subset(elmk_5, night=="monday")
elmk_5_tuesday <-   subset(elmk_5, night=="tuesday")
elmk_5_wednesday <- subset(elmk_5, night=="wednesday")
elmk_5_thursday <-  subset(elmk_5, night=="thursday")

#Ordering appropriately and removing uneccesary variables

#Monday edgelist surveys 1-5

elmk_1_monday <- elmk_1_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_monday <- elmk_2_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_monday <- elmk_3_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_monday <- elmk_4_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_monday <- elmk_5_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]


#Tueday edgelist surveys 1-5

elmk_1_tuesday <- elmk_1_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_tuesday <- elmk_2_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_tuesday <- elmk_3_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_tuesday <- elmk_4_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_tuesday <- elmk_5_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]


#Wednesday edgelist surveys 1-5

elmk_1_wednesday <- elmk_1_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_wednesday <- elmk_2_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_wednesday <- elmk_3_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_wednesday <- elmk_4_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_wednesday <- elmk_5_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]



#Thursday edgelist surveys 1-5

elmk_1_thursday <- elmk_1_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_2_thursday <- elmk_2_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_3_thursday <- elmk_3_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_4_thursday <- elmk_4_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elmk_5_thursday <- elmk_5_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]






#SETTING UP FINAL EDGELIST FOR GRAPH - Spring '16 MONDAY Survey 1


sender1 <- elmk_1_tuesday [c("Sender_Final_ID")]
receiver1 <- elmk_1_tuesday[c("Receiver_Final_ID")]
weight1 <- elmk_1_tuesday[c("sn1")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_tuesday_1$tuesday 

el1 <- as.data.frame(cbind(sender1, receiver1, weight1))


class(el1)
el_tuesday1 <- el1
el_tuesday1 <- el_tuesday1[is.element(el_tuesday1$Sender_Final_ID, labels_tuesday),]
el_tuesday1 <- el_tuesday1[is.element(el_tuesday1$Receiver_Final_ID, labels_tuesday),]
el_tuesday1 <- as.matrix(el_tuesday1)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday1 <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday1) <- colnames(SN_tuesday1) <- labels_tuesday
SN_tuesday1[el_tuesday1[,1:2]] <- as.numeric(el_tuesday1[,3])
SN_tuesday1





# delete column 1
#SN_tuesday <-SN_tuesday[,-20] # delete column 20
#SN_tuesday <-SN_tuesday[,-1]


######################################################


tuesday_1 <- graph_from_adjacency_matrix(SN_tuesday1, mode = c("directed"), weighted = NULL, diag = TRUE,
                            add.colnames = NULL, add.rownames = NA)




# remove loops
tuesday_1 <- simplify(tuesday_1)

#set labels and degrees of vertices
#V(test)$label <- V(test)$name
#V(test)$degree <- degree(test)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(tuesday_1)
plot(tuesday_1, layout=layout1)

plot(tuesday_1, layout=layout.kamada.kawai)
tkplot(tuesday_1, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_1), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_1, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_1, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_1, mode="out")









#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 tuesday Survey 2


sender2 <- elmk_2_tuesday [c("Sender_Final_ID")]
receiver2 <- elmk_2_tuesday[c("Receiver_Final_ID")]
weight2 <- elmk_2_tuesday[c("sn1")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_tuesday_2$tuesday 

el2 <- as.data.frame(cbind(sender2, receiver2, weight2))


class(el2)
el_tuesday2 <- el2
el_tuesday2 <- el_tuesday2[is.element(el_tuesday2$Sender_Final_ID, labels_tuesday),]
el_tuesday2 <- el_tuesday2[is.element(el_tuesday2$Receiver_Final_ID, labels_tuesday),]
el_tuesday2 <- as.matrix(el_tuesday2)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday2 <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday2) <- colnames(SN_tuesday2) <- labels_tuesday
SN_tuesday2[el_tuesday2[,1:2]] <- as.numeric(el_tuesday2[,3])
SN_tuesday2



######################################################


tuesday_2 <- graph_from_adjacency_matrix(SN_tuesday2, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)




# remove loops
tuesday_2 <- simplify(tuesday_2)



# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(tuesday_2)
plot(tuesday_2, layout=layout1)

plot(tuesday_2, layout=layout.kamada.kawai)
tkplot(tuesday_2, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_2), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_2, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_2, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_2, mode="out")







#SETTING UP FINAL EDGELIST FOR GRAPH -Spring '16 tuesday Survey 3


sender3 <- elmk_3_tuesday [c("Sender_Final_ID")]
receiver3 <- elmk_3_tuesday[c("Receiver_Final_ID")]
weight3 <- elmk_3_tuesday[c("sn1")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_tuesday_3$tuesday 

el3 <- as.data.frame(cbind(sender3, receiver3, weight3))


class(el3)
el_tuesday3 <- el3
el_tuesday3 <- el_tuesday3[is.element(el_tuesday3$Sender_Final_ID, labels_tuesday),]
el_tuesday3 <- el_tuesday3[is.element(el_tuesday3$Receiver_Final_ID, labels_tuesday),]
el_tuesday3 <- as.matrix(el_tuesday3)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday3 <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday3) <- colnames(SN_tuesday3) <- labels_tuesday
SN_tuesday3[el_tuesday3[,1:2]] <- as.numeric(el_tuesday3[,3])
SN_tuesday3



######################################################


tuesday_3 <- graph_from_adjacency_matrix(SN_tuesday3, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)




# remove loops
tuesday_3 <- simplify(tuesday_3)



# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(tuesday_3)
plot(tuesday_3, layout=layout1)

plot(tuesday_3, layout=layout.kamada.kawai)
tkplot(tuesday_3, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_3), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_3, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_3, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_3, mode="out")







#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 tuesday Survey 4


sender4 <- elmk_4_tuesday [c("Sender_Final_ID")]
receiver4 <- elmk_4_tuesday[c("Receiver_Final_ID")]
weight4 <- elmk_4_tuesday[c("sn1")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 

labels_tuesday <- sn_include_tuesday_4$tuesday  

el4 <- as.data.frame(cbind(sender4, receiver4, weight4))


class(el4)
el_tuesday4 <- el4
el_tuesday4 <- el_tuesday4[is.element(el_tuesday4$Sender_Final_ID, labels_tuesday),]
el_tuesday4 <- el_tuesday4[is.element(el_tuesday4$Receiver_Final_ID, labels_tuesday),]
el_tuesday4 <- as.matrix(el_tuesday4)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday4 <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday4) <- colnames(SN_tuesday4) <- labels_tuesday
SN_tuesday4[el_tuesday4[,1:2]] <- as.numeric(el_tuesday4[,3])
SN_tuesday4



######################################################


tuesday_4 <- graph_from_adjacency_matrix(SN_tuesday4, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)




# remove loops
tuesday_4 <- simplify(tuesday_4)



# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(tuesday_4)
plot(tuesday_4, layout=layout1)

plot(tuesday_4, layout=layout.kamada.kawai)
tkplot(tuesday_4, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_4), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_4, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_4, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_4, mode="out")



#SETTING UP FINAL EDGELIST FOR GRAPH - spring '16 tuesday Survey 5#




sender5 <- elmk_5_tuesday [c("Sender_Final_ID")]
receiver5 <- elmk_5_tuesday[c("Receiver_Final_ID")]
weight5 <- elmk_5_tuesday[c("sn1")]


#labels_tuesday <- sn_include_tuesday$Sender_Final_ID 
labels_tuesday <- sn_include_tuesday_5$tuesday 

el5 <- as.data.frame(cbind(sender5, receiver5, weight5))


class(el5)
el_tuesday5 <- el5
el_tuesday5 <- el_tuesday5[is.element(el_tuesday5$Sender_Final_ID, labels_tuesday),]
el_tuesday5 <- el_tuesday5[is.element(el_tuesday5$Receiver_Final_ID, labels_tuesday),]
el_tuesday5 <- as.matrix(el_tuesday5)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_tuesday, decreasing=FALSE)
SN_tuesday5 <- matrix(0, length(labels_tuesday), length(labels_tuesday))
rownames(SN_tuesday5) <- colnames(SN_tuesday5) <- labels_tuesday
SN_tuesday5[el_tuesday5[,1:2]] <- as.numeric(el_tuesday5[,3])
SN_tuesday5


#Remove NA's from the social Network.
#SN_tuesday5 <- SN_tuesday5[rowSums(is.na(SN_tuesday5[,5:6]))==0,]
#SN_tuesday5 <- SN_tuesday5[is.na(SN_tuesday5)==0,]
#
#SN_tuesday_5 <- as.data.frame(SN_tuesday5)
#
#SN_tuesday5 <- na.omit(SN_tuesday5)
#
#SN_tuesday5 <- as.matrix(SN_tuesday5)





tuesday_5 <- graph_from_adjacency_matrix (SN_tuesday5, mode = c("directed"), weighted = NULL, diag = TRUE,
       add.colnames = NULL, add.rownames = NA)


# remove loops
tuesday_5 <- simplify(tuesday_5)

#set labels and degrees of vertices
#V(test)$label <- V(test)$name
#V(test)$degree <- degree(test)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(tuesday_5)
plot(tuesday_5, layout=layout1)

plot(tuesday_5, layout=layout.kamada.kawai)
tkplot(tuesday_5, layout=layout.kamada.kawai)



#GETTING SOCIAL NETWORK STATISTICS

density_tuesday <- graph.density(simplify(tuesday_5), loops=FALSE)
centralization_tuesday <- centralization.degree(tuesday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_tuesday <- reciprocity(tuesday_5, ignore.loops = TRUE)

gs.inbound_tuesday <- graph.strength(tuesday_5, mode="in")
gs.outbound_tuesday <- graph.strength(tuesday_5, mode="out")




##################################################################################################################################################
########################WEDNESDAY#################################################################################################################
##################################################################################################################################################
##################################################################################################################################################



#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 1


sender1 <- elmk_1_wednesday [c("Sender_Final_ID")]
receiver1 <- elmk_1_wednesday[c("Receiver_Final_ID")]
weight1 <- elmk_1_wednesday[c("sn1")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 


labels_wednesday <- sn_include_wednesday_1$wednesday

el1 <- as.data.frame(cbind(sender1, receiver1, weight1))


class(el1)
el_wednesday1 <- el1
el_wednesday1 <- el_wednesday1[is.element(el_wednesday1$Sender_Final_ID, labels_wednesday),]
el_wednesday1 <- el_wednesday1[is.element(el_wednesday1$Receiver_Final_ID, labels_wednesday),]
el_wednesday1 <- as.matrix(el_wednesday1)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday1 <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday1) <- colnames(SN_wednesday1) <- labels_wednesday
SN_wednesday1[el_wednesday1[,1:2]] <- as.numeric(el_wednesday1[,3])
SN_wednesday1





# delete column 1
#SN_wednesday <-SN_wednesday[,-20] # delete column 20
#SN_wednesday <-SN_wednesday[,-1]


######################################################


wednesday_1 <- graph_from_adjacency_matrix(SN_wednesday1, mode = c("directed"), weighted = NULL, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)




# remove loops
wednesday_1 <- simplify(wednesday_1)

#set labels and degrees of vertices
#V(test)$label <- V(test)$name
#V(test)$degree <- degree(test)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(wednesday_1)
plot(wednesday_1, layout=layout1)

plot(wednesday_1, layout=layout.kamada.kawai)
tkplot(wednesday_1, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_1), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_1, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_1, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_1, mode="out")









#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 2


sender2 <- elmk_2_wednesday [c("Sender_Final_ID")]
receiver2 <- elmk_2_wednesday[c("Receiver_Final_ID")]
weight2 <- elmk_2_wednesday[c("sn1")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_wednesday_2$wednesday

el2 <- as.data.frame(cbind(sender2, receiver2, weight2))


class(el2)
el_wednesday2 <- el2
el_wednesday2 <- el_wednesday2[is.element(el_wednesday2$Sender_Final_ID, labels_wednesday),]
el_wednesday2 <- el_wednesday2[is.element(el_wednesday2$Receiver_Final_ID, labels_wednesday),]
el_wednesday2 <- as.matrix(el_wednesday2)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday2 <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday2) <- colnames(SN_wednesday2) <- labels_wednesday
SN_wednesday2[el_wednesday2[,1:2]] <- as.numeric(el_wednesday2[,3])
SN_wednesday2



######################################################


wednesday_2 <- graph_from_adjacency_matrix(SN_wednesday2, mode = c("directed"), weighted = NULL, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)




# remove loops
wednesday_2 <- simplify(wednesday_2)



# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(wednesday_2)
plot(wednesday_2, layout=layout1)

plot(wednesday_2, layout=layout.kamada.kawai)
tkplot(wednesday_2, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_2), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_2, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_2, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_2, mode="out")







#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 3


sender3 <- elmk_3_wednesday [c("Sender_Final_ID")]
receiver3 <- elmk_3_wednesday[c("Receiver_Final_ID")]
weight3 <- elmk_3_wednesday[c("sn1")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_wednesday_3$wednesday

el3 <- as.data.frame(cbind(sender3, receiver3, weight3))


class(el3)
el_wednesday3 <- el3
el_wednesday3 <- el_wednesday3[is.element(el_wednesday3$Sender_Final_ID, labels_wednesday),]
el_wednesday3 <- el_wednesday3[is.element(el_wednesday3$Receiver_Final_ID, labels_wednesday),]
el_wednesday3 <- as.matrix(el_wednesday3)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday3 <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday3) <- colnames(SN_wednesday3) <- labels_wednesday
SN_wednesday3[el_wednesday3[,1:2]] <- as.numeric(el_wednesday3[,3])
SN_wednesday3



######################################################


wednesday_3 <- graph_from_adjacency_matrix(SN_wednesday3, mode = c("directed"), weighted = NULL, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)




# remove loops
wednesday_3 <- simplify(wednesday_3)



# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(wednesday_3)
plot(wednesday_3, layout=layout1)

plot(wednesday_3, layout=layout.kamada.kawai)
tkplot(wednesday_3, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_3), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_3, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_3, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_3, mode="out")







#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 4


sender4 <- elmk_4_wednesday [c("Sender_Final_ID")]
receiver4 <- elmk_4_wednesday[c("Receiver_Final_ID")]
weight4 <- elmk_4_wednesday[c("sn1")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 

labels_wednesday <- sn_include_wednesday_4$wednesday

el4 <- as.data.frame(cbind(sender4, receiver4, weight4))


class(el4)
el_wednesday4 <- el4
el_wednesday4 <- el_wednesday4[is.element(el_wednesday4$Sender_Final_ID, labels_wednesday),]
el_wednesday4 <- el_wednesday4[is.element(el_wednesday4$Receiver_Final_ID, labels_wednesday),]
el_wednesday4 <- as.matrix(el_wednesday4)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday4 <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday4) <- colnames(SN_wednesday4) <- labels_wednesday
SN_wednesday4[el_wednesday4[,1:2]] <- as.numeric(el_wednesday4[,3])
SN_wednesday4



######################################################


wednesday_4 <- graph_from_adjacency_matrix(SN_wednesday4, mode = c("directed"), weighted = NULL, diag = TRUE,
                                           add.colnames = NULL, add.rownames = NA)




# remove loops
wednesday_4 <- simplify(wednesday_4)



# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(wednesday_4)
plot(wednesday_4, layout=layout1)

plot(wednesday_4, layout=layout.kamada.kawai)
tkplot(wednesday_4, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_4), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_4, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_4, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_4, mode="out")



#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 wednesday Survey 5#




sender5 <- elmk_5_wednesday [c("Sender_Final_ID")]
receiver5 <- elmk_5_wednesday[c("Receiver_Final_ID")]
weight5 <- elmk_5_wednesday[c("sn1")]


#labels_wednesday <- sn_include_wednesday$Sender_Final_ID 
labels_wednesday <- sn_include_wednesday_5$wednesday

el5 <- as.data.frame(cbind(sender5, receiver5, weight5))


class(el5)
el_wednesday5 <- el5
el_wednesday5 <- el_wednesday5[is.element(el_wednesday5$Sender_Final_ID, labels_wednesday),]
el_wednesday5 <- el_wednesday5[is.element(el_wednesday5$Receiver_Final_ID, labels_wednesday),]
el_wednesday5 <- as.matrix(el_wednesday5)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_wednesday, decreasing=FALSE)
SN_wednesday5 <- matrix(0, length(labels_wednesday), length(labels_wednesday))
rownames(SN_wednesday5) <- colnames(SN_wednesday5) <- labels_wednesday
SN_wednesday5[el_wednesday5[,1:2]] <- as.numeric(el_wednesday5[,3])
SN_wednesday5


#Remove NA's from the social Network.
#SN_wednesday5 <- SN_wednesday5[rowSums(is.na(SN_wednesday5[,5:6]))==0,]
#SN_wednesday5 <- SN_wednesday5[is.na(SN_wednesday5)==0,]
#
#SN_wednesday_5 <- as.data.frame(SN_wednesday5)
#
#SN_wednesday5 <- na.omit(SN_wednesday5)
#
#SN_wednesday5 <- as.matrix(SN_wednesday5)





wednesday_5 <- graph_from_adjacency_matrix (SN_wednesday5, mode = c("directed"), weighted = NULL, diag = TRUE,
                                            add.colnames = NULL, add.rownames = NA)


# remove loops
wednesday_5 <- simplify(wednesday_5)

#set labels and degrees of vertices
#V(test)$label <- V(test)$name
#V(test)$degree <- degree(test)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(wednesday_5)
plot(wednesday_5, layout=layout1)

plot(wednesday_5, layout=layout.kamada.kawai)
tkplot(wednesday_5, layout=layout.kamada.kawai)



#GETTING SOCIAL NETWORK STATISTICS

density_wednesday <- graph.density(simplify(wednesday_5), loops=FALSE)
centralization_wednesday <- centralization.degree(wednesday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_wednesday <- reciprocity(wednesday_5, ignore.loops = TRUE)

gs.inbound_wednesday <- graph.strength(wednesday_5, mode="in")
gs.outbound_wednesday <- graph.strength(wednesday_5, mode="out")






