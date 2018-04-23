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
elk <- read.csv("YouthSN.csv", header = TRUE) 

sn_include<- read.csv("F15_SN_Include.csv", header = TRUE)
sn_include_youth <- read.csv("F15_SN_Include_Youth.csv", header = TRUE)
sn_include_monday <- read.csv("F15_SN_Monday.csv", header = TRUE)



################################################################################################################################
################################################################################################################################
###########################NEIL CREATING YOUTH SOCIAL NETWORKS FOR PROJECT #####################################################
################################################################################################################################
################################################################################################################################
################################################################################################################################

sn1_1 <- elk_1_monday[c("sn1")]
sn1_5 <- elk_5_monday[c("sn1")]


mytable <- table(sn1_1$sn1)
mytable5 <- table(sn1_5$sn1)

#Separating The edgelists by night


elk_1 <- subset(elk, survnum == 1)
elk_2 <- subset(elk, survnum == 2)
elk_3 <- subset(elk, survnum == 3)
elk_4 <- subset(elk, survnum == 4)
elk_5 <- subset(elk, survnum == 5)

#survey 1 edgelist by night

elk_1_monday <-    subset(elk_1, night=="monday")
elk_1_tuesday <-   subset(elk_1, night=="tuesday")
elk_1_wednesday <- subset(elk_1, night=="wednesday")
elk_1_thursday <-  subset(elk_1, night=="thursday")


#survey 2 edgelist by night

elk_2_monday <-    subset(elk_2, night=="monday")
elk_2_tuesday <-   subset(elk_2, night=="tuesday")
elk_2_wednesday <- subset(elk_2, night=="wednesday")
elk_2_thursday <-  subset(elk_2, night=="thursday")


#survey 3 edgelist by night

elk_3_monday <-    subset(elk_3, night=="monday")
elk_3_tuesday <-   subset(elk_3, night=="tuesday")
elk_3_wednesday <- subset(elk_3, night=="wednesday")
elk_3_thursday <-  subset(elk_3, night=="thursday")

#survey 4 edgelist by night

elk_4_monday <-    subset(elk_4, night=="monday")
elk_4_tuesday <-   subset(elk_4, night=="tuesday")
elk_4_wednesday <- subset(elk_4, night=="wednesday")
elk_4_thursday <-  subset(elk_4, night=="thursday")

#survey 5 edgelist by night

elk_5_monday <-    subset(elk_5, night=="monday")
elk_5_tuesday <-   subset(elk_5, night=="tuesday")
elk_5_wednesday <- subset(elk_5, night=="wednesday")
elk_5_thursday <-  subset(elk_5, night=="thursday")

#Ordering appropriately and removing uneccesary variables

#Monday edgelist surveys 1-5

elk_1_monday <- elk_1_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_2_monday <- elk_2_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_3_monday <- elk_3_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_4_monday <- elk_4_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_5_monday <- elk_5_monday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]


#Tueday edgelist surveys 1-5

elk_1_tuesday <- elk_1_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_2_tuesday <- elk_2_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_3_tuesday <- elk_3_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_4_tuesday <- elk_4_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_5_tuesday <- elk_5_tuesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]


#Wednesday edgelist surveys 1-5

elk_1_wednesday <- elk_1_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_2_wednesday <- elk_2_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_3_wednesday <- elk_3_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_4_wednesday <- elk_4_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_5_wednesday <- elk_5_wednesday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]



#Thursday edgelist surveys 1-5

elk_1_thursday <- elk_1_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_2_thursday <- elk_2_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_3_thursday <- elk_3_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_4_thursday <- elk_4_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]
elk_5_thursday <- elk_5_thursday[c("Sender_Final_ID", "Receiver_Final_ID", "night", "sn1")]






#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 1


sender1 <- elk_1_monday [c("Sender_Final_ID")]
receiver1 <- elk_1_monday[c("Receiver_Final_ID")]
weight1 <- elk_1_monday[c("sn1")]


labels_monday <- sn_include_monday$Sender_Final_ID 


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


test <- graph_from_adjacency_matrix(SN_monday1, mode = c("directed"), weighted = NULL, diag = TRUE,
                            add.colnames = NULL, add.rownames = NA)




# remove loops
test <- simplify(test)

#set labels and degrees of vertices
#V(test)$label <- V(test)$name
#V(test)$degree <- degree(test)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(test)
plot(test, layout=layout1)

plot(test, layout=layout.kamada.kawai)
tkplot(test, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(test), loops=FALSE)
centralization_monday <- centralization.degree(test, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(test, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(test, mode="in")
gs.outbound_monday <- graph.strength(test, mode="out")




###################################





library(igraph)
# build a graph from the above matrix
g <- graph.adjacency(SN_monday1, weighted=T, mode = "directed")

# remove loops
g <- simplify(g)

#set labels and degrees of vertices
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)

plot(g, layout=layout.kamada.kawai)
tkplot(g, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(g), loops=FALSE)
centralization_monday <- centralization.degree(g, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(g, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(g, mode="in")
gs.outbound_monday <- graph.strength(g, mode="out")


#install.packages("RCurl"); install.packages("ergm")
#library(RCurl); library(ergm)

#ga.base<-ergm(g~edges+nodematch("sn1")) #Estimate the model
#summary(ga.base) #Summarize the model






#SETTING UP FINAL EDGELIST FOR GRAPH - Fall '15 MONDAY Survey 5




sender5 <- elk_5_monday [c("Sender_Final_ID")]
receiver5 <- elk_5_monday[c("Receiver_Final_ID")]
weight5 <- elk_5_monday[c("sn1")]


labels_monday <- sn_include_monday$Sender_Final_ID 


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





test <- graph_from_adjacency_matrix (SN_monday5, mode = c("directed"), weighted = NULL, diag = TRUE,
       add.colnames = NULL, add.rownames = NA)


# remove loops
test <- simplify(test)

#set labels and degrees of vertices
#V(test)$label <- V(test)$name
#V(test)$degree <- degree(test)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(test)
plot(test, layout=layout1)

plot(test, layout=layout.kamada.kawai)
tkplot(test, layout=layout.kamada.kawai)
























#Plot social Network


















library(igraph)
# build a graph from the above matrix
g <- graph.adjacency(SN_monday5, weighted=T, mode = "directed")

# remove loops
g <- simplify(g)

#set labels and degrees of vertices
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)


# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)

plot(g, layout=layout.kamada.kawai)
tkplot(g, layout=layout.kamada.kawai)


#GETTING SOCIAL NETWORK STATISTICS

density_monday <- graph.density(simplify(g), loops=FALSE)
centralization_monday <- centralization.degree(g, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_monday <- reciprocity(g, ignore.loops = TRUE)

gs.inbound_monday <- graph.strength(g, mode="in")
gs.outbound_monday <- graph.strength(g, mode="out")






































######################EVERYTHING BELOW NOT WORKING -NEIL###########################
#some plot to make it look better below


#V(g)$label.cex <- 2.2 * V(g)$degree / max(V(g)$degree)+ .2
#V(g)$label.color <- rgb(0, 0, .2, .8)
#V(g)$frame.color <- NA
#egam <- (log(E(g)$weight)+.4) / max(log(E(g)$weight)+.4)
#E(g)$color <- rgb(.5, .5, 0, egam)
#E(g)$width <- egam
## plot the graph in layout1
#plot(g, layout=layout1)














elk_Monday <- graph.adjacency(SN_monday, mode="directed", weighted=TRUE, diag=FALSE)
V(elk_Monday)$KID=as.character(monday$KID[match(V(elk_Monday)$name, Monday$Sender_ID)])
V(elk_Monday)$color=V(SN_Monday)$KID
V(SN_Monday)$color=gsub("0","red",V(SN_Monday)$color) #Staff will be red
V(SN_Monday)$color=gsub("1","blue",V(SN_Monday)$color) #Kids will be blue





#Kim Example





sender <- c("KCCS16_1001", "KCCS16_1002", "KCCS16_1003", "KCCS16_1001", "KCCS16_1002", "KCCS16_1004")
receiver <- c("KCCS16_1002", "KCCS16_1003", "KCCS16_1001", "KCCS16_1003", "KCCS16_1001", "KCCS16_1005")
weight <- c(5, 3, 1, 9, 2, 6)



labels_monday <- c("KCCS16_1001", "KCCS16_1002", "KCCS16_1003")



el <- as.data.frame(cbind(Sender_Final_ID, Receiver_Final_ID, sn1))

class(el)
el_monday <- el
el_monday <- el_monday[is.element(el_monday$sender, labels_monday),]
el_monday <- el_monday[is.element(el_monday$receiver, labels_monday),]
el_monday <- as.matrix(el_monday)



# create a social network graph for each night - start with an empty matrix of the correct size

sort(labels_monday, decreasing=FALSE)
SN_monday <- matrix(0, length(labels_monday), length(labels_monday))
rownames(SN_monday) <- colnames(SN_monday) <- labels_monday
SN_monday[el_monday[,1:2]] <- as.numeric(el_monday[,3])
SN_monday



#Plot social Network


library(igraph)
# build a graph from the above matrix
g <- graph.adjacency(SN_monday, weighted=T, mode = "directed")

# remove loops
g <- simplify(g)

#set labels and degrees of vertices
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)


# set seed to make the layout reproducible
  set.seed(3952)
layout1 <- layout.fruchterman.reingold(g)
plot(g, layout=layout1)

plot(g, layout=layout.kamada.kawai)
tkplot(g, layout=layout.kamada.kawai)


density <- graph.density(simplify(g), loops=FALSE)
centralization_Wednesday <- centralization.degree(SN_Wednesday, mode=c("in"), normalized = TRUE, loops = FALSE)
reciprocity_Wednesday <- reciprocity(SN_Wednesday, ignore.loops = TRUE)



#some plot to make it look better below

V(g)$label.cex <- 2.2 * V(g)$degree / max(V(g)$degree)+ .2
V(g)$label.color <- rgb(0, 0, .2, .8)
V(g)$frame.color <- NA
egam <- (log(E(g)$weight)+.4) / max(log(E(g)$weight)+.4)
E(g)$color <- rgb(.5, .5, 0, egam)
E(g)$width <- egam
# plot the graph in layout1
  plot(g, layout=layout1)








#elk_Monday <- graph.adjacency(elk_Monday, mode="directed", weighted=TRUE, diag=FALSE)
#V(elk_Monday)$KID=as.character(monday$KID[match(V(elk_Monday)$name, Monday$Sender_ID)])
V(SN_monday)$color=V(SN_Monday)$KID
V(SN_monday)$color=gsub("0","red",V(SN_monday)$color) #Staff will be red
V(SN_monday)$color=gsub("1","blue",V(SN_monday)$color) #Kids will be blue






#NOT WORKING NEIL



#labels_monday <- sn_include_monday$Sender_Final_ID #create the labels_monday from the sn_monday (it's literaly just the same file renamed)
#elk_1_monday <- as.matrix(elk_1_monday) #convert monday edgelist into a matrix
#elk_1_monday <- na.omit(elk_1_monday) #remove na's from Monday edge list




#sort(labels_monday, decreasing=FALSE) #sort the labels file before creating blank matrix
#sn_monday <- matrix(NA, length(labels_monday), length(labels_monday)) #creates adjaceny table with NA values, making it the length of
#the labels_monday data
#rownames(sn_monday) <- colnames(sn_monday) <- labels_monday #names the rows and columsn the same as the Final_ID's








library(igraph)
dat <- sn_monday # reading in the adjacency table
el=as.matrix(dat) # coerces the data into a two-column matrix format that igraph likes 
el[,1]=as.character(el[,1])
el[,2]=as.character(el[,2])


test <- elk_1_monday[c("Sender_Final_ID", "Receiver_Final_ID")]
#test <- 
test <- as.matrix(test)
g=graph.edgelist(test,directed=FALSE)  # turns the edgelist into a 'graph object'







#########NEIL STOP########################
#ALL Below is NON-working code. NEED TO FIX#




install.packages("RCurl"); install.packages("ergm")
library(RCurl); library(ergm)





#Monday adjacency table. Empty matrix 






Monday <- subset(sn_include, monday=="monday")
Monday <- Monday[order(Monday$ID) , ]


Monday <- sn_include [c("monday")]
Monday <- Monday[order(Monday$monday) , ]
labels_Monday <- unique(c(Monday$monday))

View(Monday)

elk_1_monday <- as.matrix(subset(elk_1, night=="monday"))




# fill in the matrix with weights from the edgelist - this assumes that the SENDERID and RECEIVERID are in columns 1 and 2,
# and the weight is in column 4 - change as necessary.


#sort(monday_include, decreasing=FALSE)
SN_k_monday <- matrix(0, length(monday_include), length(monday_include))
rownames(elk_1_monday) <- colnames(elk_1_monday) <- monday_include
SN_k_monday[elk_1_monday[,1:2]] <- as.numeric(elk_1_monday[,4])



View(SN_k_monday)




elk_Tuesday <- as.matrix(subset(elk, night=="tuesday"))
elk_Wednesday <- as.matrix(subset(elk, night=="wednesday"))
elk_Thursday <- as.matrix(subset(elk, night=="thursday"))



elk_Monday <- graph.adjacency(SN_monday, mode="directed", weighted=TRUE, diag=FALSE)
V(elk_Monday)$KID=as.character(monday$KID[match(V(elk_1_Monday)$name, monday$Sender_ID)])
V(SN_Monday)$color=V(SN_Monday)$KID
V(SN_Monday)$color=gsub("0","red",V(SN_Monday)$color) #Staff will be red
V(SN_Monday)$color=gsub("1","blue",V(SN_Monday)$color) #Kids will be blue



