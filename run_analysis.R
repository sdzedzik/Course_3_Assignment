#Creating directory and download the file
if (!file.exists("Course_3_Assignment")){
        dir.create("Course_3_Assignment")
}
setwd("./Course_3_Assignment")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "data.zip")
unzip("data.zip")

#Loading the tables
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt")
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainlabels <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Merging the training and the test sets to create one data set.
library(dplyr)
testmerged <- bind_cols(testsubject, testlabels, testdata)
rm(testdata, testlabels, testsubject)
trainmerged <- bind_cols(trainsubject, trainlabels, traindata)
rm(traindata, trainlabels, trainsubject)
mergeddata <- bind_rows(testmerged, trainmerged)
rm(testmerged, trainmerged)

#Appropriately labeling the data set with descriptive variable names.
colnames(mergeddata) <- c("SubjectId", "Activity", as.character(features[,2])) %>% 
        make.names(unique = TRUE) %>%
        gsub("\\.{3}", "-", .) %>% 
        gsub("[[:punct:]]$","", .) %>%
        gsub("[[:punct:]]$","", .)

#Using descriptive activity names to name the activities in the data set
mergeddata$Activity <- as.factor(mergeddata$Activity)
for (i in 1:6){
        levels(mergeddata$Activity)[i] <- as.character(activitylabels[i,2])
}

#Extracting only the measurements on the mean and standard deviation for each measurement.
mergeddata <- select(mergeddata, 1, 2, grep("mean", names(mergeddata)), grep("std", names(mergeddata)))

#Creating a second, independent tidy data set with the average of each variable for each activity and each subject.
mergeddata %>% group_by(SubjectId, Activity) %>% summarize_all(mean) -> average
