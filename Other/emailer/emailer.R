#                                 This program was creared on 08.23.18 by Neil Yetz
#                                 The purpose of this program is to send emails to mentors at Campus Connections
#                                 It automatically detects their names, ID#'s and send emails to the indicated email address.
#                                 
#                                 

#install.packages("mailR")
library(mailR)
library(tidyverse)
library(readxl)

#Read in contact info file file
setwd()

contact <- read_csv("test.csv")

#Select variables of interest
contact <- contact %>% 
  select(Mentor_ID, name, Email)

#Survey link
link = "www.facebook.com"

#Create email function
email_fun <- function(sender, email, staff_list,  names, ID, website, row_num){
  if (!require(mailR)){
    install.packages("mailR")
  } 
  send.mail(from = sender, 
            to = email[row_num], 
            subject = "Campus Connections survey", 
            body = paste("Hi", names[row_num], "\n\nMy name is Neil Yetz. I am a researcher for Campus Connections. You are receiving this email because you consented to participate in the Campus Connections research. Please click follow this link:", website, 
                          "to participate. Please enter the following ID# when prompted:", ID[row_num], 
                         "Thank you!", "\n\nNeil Yetz, MPH \nCampus Connections Researcher"), 
            smtp = list(host.name = "smtp.gmail.com", port = 587,  
                        user.name = "ndyetz@gmail.com", 
                        passwd = "", 
                        ssl = TRUE), 
            authenticate = TRUE, send = TRUE)
  
}


#Indicate arguments & Rows.
email_fun(sender = "neil.yetz@colostate.edu", email = contact$Email, names = contact$name, ID = contact$Mentor_ID, website = link,  row_num = 1)
email_fun(sender = "neil.yetz@colostate.edu", email = contact$Email, names = contact$name, ID = contact$Mentor_ID, website = link,  row_num = 2)





