##Load libraries
library(dplyr)

##0. Load data to data frame
titanic_dataset <- read.csv(file="./Data Wrangling/Exo2/titanic_original.csv"
                       , head = TRUE, sep=",")
str(titanic_dataset)


##1. Replace missing values in embarked with S
#tt <- titanic_dataset
#( tt$embarked[ which(is.na(tt$embarked)) ] <- "S" )
if( is.factor(titanic_dataset$embarked)){
  levels(titanic_dataset$embarked)[1] <- "S"
}else{
  titanic_dataset$embarked[ is.na(titanic_dataset$embarked) |  
                              titanic_dataset$embarked == ""] <- "S" 
}


##2.a Replace missing age with mean age
av_age <- mean( titanic_dataset$age, na.rm = TRUE)
titanic_dataset$age[ is.na(titanic_dataset$age) ] <- av_age

##2.b
#Could not replace with 0, because it's a wrong age for someone alive
#Could not replace with a negative value because it might impact calculations on the age column


##3. Replace missing values in LifeBoat column with "None"
tt$boat[ which(is.na(tt$boat)) ] <- "None"
tt$boat
if( is.factor(titanic_dataset$boat)){
  levels(titanic_dataset$boat)[1] <- "None"
}else{
  titanic_dataset$boat[is.na(titanic_dataset$boat) ] <- "None"
}


##4. Add flag has_cabin_number
#We should not replace missing cabin numbers because not all passengers 
# purchased cabins
titanic_dataset <- titanic_dataset %>% mutate(has_cabin_number = ifelse( 
  is.na(titanic_dataset$cabin) | (titanic_dataset$cabin) == "", 0, 1) ) 


##Output
str(titanic_dataset)
write.csv(titanic_dataset, file = "./Data Wrangling//Exo2/titanic_clean.csv"
          , row.names = FALSE, append = FALSE)


