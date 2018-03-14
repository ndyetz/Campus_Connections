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
elmk <- read.csv("F15_SN_MentorMentee.csv", header = TRUE) 

sn_include<- read.csv("F15_SN_Include.csv", header = TRUE)

#SN INCLUDE FILES

##Monday surveys

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






#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 1


sender1 <- elmk_1_monday [c("Sender_Final_ID")]
receiver1 <- elmk_1_monday[c("Receiver_Final_ID")]
weight1 <- elmk_1_monday[c("sn1")]


#labels_monday <- sn_include_monday$Sender_Final_ID 

labels_monday <- sn_include_monday_1$monday 

el1 <- as.data.frame(cbind(sender1, receiver1, weight1))


class(el1)
el_monday1 <- el1
el_monday1 <- el_monday1[is.element(el_monday1$Sender_Final_ID, labels_monday),]
el_monday1 <- el_monday1[is.element(el_monday1$Receiver_Final_ID, labels_monday),]
el_monday1 <- as.matrix(el_monday1)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday1 <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday1) <- colnames(SN_monday1) <- labels_monday
SN_monday1[el_monday1[,1:2]] <- as.numeric(el_monday1[,3])
SN_monday1


#KCCF15_1074 = No picture in SN1 but was able to choose.


# delete column 1
#SN_monday <-SN_monday[,-20] # delete column 20
#SN_monday <-SN_monday[,-1]


######################################################


monday_1 <- graph_from_adjacency_matrix(SN_monday1, mode = c("directed"), weighted = NULL, diag = TRUE,
                            add.colnames = NULL, add.rownames = NA)




# remove loops
monday_1 <- simplify(monday_1)

#set labels and degrees of vertices
#V(test)$label <- V(test)$name
#V(test)$degree <- degree(test)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(monday_1)
plot(monday_1, layout=layout1)

plot(monday_1, layout=layout.kamada.kawai)
tkplot(monday_1, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_1), loops=FALSE)
centralization_monday <- centralization.degree(monday_1, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_1, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_1, mode="in")
gs.outbound_monday <- graph.strength(monday_1, mode="out")









#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 2


sender2 <- elmk_2_monday [c("Sender_Final_ID")]
receiver2 <- elmk_2_monday[c("Receiver_Final_ID")]
weight2 <- elmk_2_monday[c("sn1")]


#labels_monday <- sn_include_monday$Sender_Final_ID 

labels_monday <- sn_include_monday_2$monday 

el2 <- as.data.frame(cbind(sender2, receiver2, weight2))


class(el2)
el_monday2 <- el2
el_monday2 <- el_monday2[is.element(el_monday2$Sender_Final_ID, labels_monday),]
el_monday2 <- el_monday2[is.element(el_monday2$Receiver_Final_ID, labels_monday),]
el_monday2 <- as.matrix(el_monday2)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday2 <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday2) <- colnames(SN_monday2) <- labels_monday
SN_monday2[el_monday2[,1:2]] <- as.numeric(el_monday2[,3])
SN_monday2



######################################################


monday_2 <- graph_from_adjacency_matrix(SN_monday2, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)




# remove loops
monday_2 <- simplify(monday_2)



# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(monday_2)
plot(monday_2, layout=layout1)

plot(monday_2, layout=layout.kamada.kawai)
tkplot(monday_2, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_2), loops=FALSE)
centralization_monday <- centralization.degree(monday_2, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_2, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_2, mode="in")
gs.outbound_monday <- graph.strength(monday_2, mode="out")







#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 3


sender3 <- elmk_3_monday [c("Sender_Final_ID")]
receiver3 <- elmk_3_monday[c("Receiver_Final_ID")]
weight3 <- elmk_3_monday[c("sn1")]


#labels_monday <- sn_include_monday$Sender_Final_ID 

labels_monday <- sn_include_monday_3$monday 

el3 <- as.data.frame(cbind(sender3, receiver3, weight3))


class(el3)
el_monday3 <- el3
el_monday3 <- el_monday3[is.element(el_monday3$Sender_Final_ID, labels_monday),]
el_monday3 <- el_monday3[is.element(el_monday3$Receiver_Final_ID, labels_monday),]
el_monday3 <- as.matrix(el_monday3)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday3 <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday3) <- colnames(SN_monday3) <- labels_monday
SN_monday3[el_monday3[,1:2]] <- as.numeric(el_monday3[,3])
SN_monday3



######################################################


monday_3 <- graph_from_adjacency_matrix(SN_monday3, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)




# remove loops
monday_3 <- simplify(monday_3)



# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(monday_3)
plot(monday_3, layout=layout1)

plot(monday_3, layout=layout.kamada.kawai)
tkplot(monday_3, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_3), loops=FALSE)
centralization_monday <- centralization.degree(monday_3, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_3, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_3, mode="in")
gs.outbound_monday <- graph.strength(monday_3, mode="out")







#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 4


sender4 <- elmk_4_monday [c("Sender_Final_ID")]
receiver4 <- elmk_4_monday[c("Receiver_Final_ID")]
weight4 <- elmk_4_monday[c("sn1")]


#labels_monday <- sn_include_monday$Sender_Final_ID 

labels_monday <- sn_include_monday_4$monday 

el4 <- as.data.frame(cbind(sender4, receiver4, weight4))


class(el4)
el_monday4 <- el4
el_monday4 <- el_monday4[is.element(el_monday4$Sender_Final_ID, labels_monday),]
el_monday4 <- el_monday4[is.element(el_monday4$Receiver_Final_ID, labels_monday),]
el_monday4 <- as.matrix(el_monday4)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday4 <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday4) <- colnames(SN_monday4) <- labels_monday
SN_monday4[el_monday4[,1:2]] <- as.numeric(el_monday4[,3])
SN_monday4



######################################################


monday_4 <- graph_from_adjacency_matrix(SN_monday4, mode = c("directed"), weighted = NULL, diag = TRUE,
                                        add.colnames = NULL, add.rownames = NA)




# remove loops
monday_4 <- simplify(monday_4)



# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(monday_4)
plot(monday_4, layout=layout1)

plot(monday_4, layout=layout.kamada.kawai)
tkplot(monday_4, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_4), loops=FALSE)
centralization_monday <- centralization.degree(monday_4, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_4, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_4, mode="in")
gs.outbound_monday <- graph.strength(monday_4, mode="out")



#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 5#




sender5 <- elmk_5_monday [c("Sender_Final_ID")]
receiver5 <- elmk_5_monday[c("Receiver_Final_ID")]
weight5 <- elmk_5_monday[c("sn1")]


#labels_monday <- sn_include_monday$Sender_Final_ID 
labels_monday <- sn_include_monday_5$monday

el5 <- as.data.frame(cbind(sender5, receiver5, weight5))


class(el5)
el_monday5 <- el5
el_monday5 <- el_monday5[is.element(el_monday5$Sender_Final_ID, labels_monday),]
el_monday5 <- el_monday5[is.element(el_monday5$Receiver_Final_ID, labels_monday),]
el_monday5 <- as.matrix(el_monday5)

# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday5 <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday5) <- colnames(SN_monday5) <- labels_monday
SN_monday5[el_monday5[,1:2]] <- as.numeric(el_monday5[,3])
SN_monday5


#Remove NA's from the social Network.
#SN_monday5 <- SN_monday5[rowSums(is.na(SN_monday5[,5:6]))==0,]
#SN_monday5 <- SN_monday5[is.na(SN_monday5)==0,]
#
#SN_monday_5 <- as.data.frame(SN_monday5)
#
#SN_monday5 <- na.omit(SN_monday5)
#
#SN_monday5 <- as.matrix(SN_monday5)





monday_5 <- graph_from_adjacency_matrix (SN_monday5, mode = c("directed"), weighted = NULL, diag = TRUE,
       add.colnames = NULL, add.rownames = NA)


# remove loops
monday_5 <- simplify(monday_5)

#set labels and degrees of vertices
#V(test)$label <- V(test)$name
#V(test)$degree <- degree(test)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(monday_5)
plot(monday_5, layout=layout1)

plot(monday_5, layout=layout.kamada.kawai)
tkplot(monday_5, layout=layout.kamada.kawai)



#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(monday_5), loops=FALSE)
centralization_monday <- centralization.degree(monday_5, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(monday_5, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(monday_5, mode="in")
gs.outbound_monday <- graph.strength(monday_5, mode="out")

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


#KCCF15_1074 = No picture in SN1 but was able to choose.


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


