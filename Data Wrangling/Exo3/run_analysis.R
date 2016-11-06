##  Load libraries
library(dplyr)
library(tidyr)


## a. Merge training and test datasets into one dataset
features <- read.table( 
  file = "./Data Wrangling/Exo3/UCI HAR Dataset/features.txt") 
str(features)
head(features)

### Merge x training and test sets
xTrain <- read.table( 
  file = "./Data Wrangling/Exo3/UCI HAR Dataset/train/X_train.txt")
xTest <- read.table( 
  file = "./Data Wrangling/Exo3/UCI HAR Dataset/test/X_test.txt")
x <- rbind(xTrain, xTest)
str(x)

### Name feature columns in x
names(x) <- make.names(features$V2, unique = TRUE)
str(x)

### Read activities
activityLabels <- read.table( 
  file = "./Data Wrangling/Exo3/UCI HAR Dataset/activity_labels.txt") 

### Label activities
names(activityLabels) <- c('ActivityLabel', 'ActivityName')
str(activityLabels)
head(activityLabels)


### Merge subject train and test sets
subjectTrain <- read.table( 
  file = "./Data Wrangling/Exo3/UCI HAR Dataset/train/subject_train.txt") 
subjectTest <- read.table( 
  file = "./Data Wrangling/Exo3/UCI HAR Dataset/test/subject_test.txt") 
subject <- rbind(subjectTrain, subjectTest)

names(subject) <- c('subject')
str(subject)

### Merge y training and test sets
yTrain <- read.table( 
  file = "./Data Wrangling/Exo3/UCI HAR Dataset/train/y_train.txt")
yTest <- read.table( 
  file = "./Data Wrangling/Exo3/UCI HAR Dataset/test/y_test.txt")
y <- rbind(yTrain, yTest)

names(y) <- c('ActivityLabel')
str(y)
head(y)


# bodyAccXTrain <- read.table( 
#   file = "./Data Wrangling/Exo3/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
# str(bodyAccXTrain)
# head(bodyAccXTrain)


### Merge all the datasets into 1
smartphoneDataset <- cbind(subject, y) %>% left_join(activityLabels) %>% cbind(x)
str(smartphoneDataset)
head(smartphoneDataset)



## b. Extract/remove columns containing mean and standard deviation for each variable
smartphoneDatasetReduced <- smartphoneDataset %>% select( -matches("mean|std"))
str(smartphoneDatasetReduced)
head(smartphoneDatasetReduced)



## c. Create tidy dataset with the average of each variable for each activity and each subject
smartphoneDatasetAverages <- smartphoneDatasetReduced %>% 
  group_by(subject, ActivityName) %>%
  summarise_each(funs(mean), 
                 vars=-one_of(c('subject', 'ActivityLabel', 'ActivityName')) )
str(smartphoneDatasetAverages)
head(smartphoneDatasetAverages)



## Output
write.csv(smartphoneDataset, file = "./Data Wrangling/Exo3/smartphone_merged.csv"
          , row.names = FALSE, append = FALSE)
write.csv(smartphoneDatasetAverages, file = "./Data Wrangling//Exo3/smartphone_averages.csv"
          , row.names = FALSE, append = FALSE)

