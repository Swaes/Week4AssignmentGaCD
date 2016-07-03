## Assignement - Getting and cleaning data
## By Sietske van Waesberghe, 3 july 2016

SetWorkDirectory <- function(directory, NewDir)  {
  
  ## function for getting and setting workdirectory
  ## 'directory' is a character vector of length 1 indicating
  ## the location for the new workdirectory
  ## 'newDir'is the name for the new workdirectory to be created
  
  setwd(directory)
  getwd()
  
  if (!file.exists(NewDir)) {dir.create(NewDir)}
  else print("Directory already exists")
  
  setwd(NewDir)
  
  if (!file.exists("data")) {dir.create("data")}  ## a separate data directory is created in the new workdirectory
  else print("Data file already exists")
  
  list.files()
}

SetWorkDirectory("C://Users//Sietske//Rprogramming//GettingAndCleaningData", "Assignment")


## Download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")
list.files("./data")

## Get de download date and time
dateDownloaded <- date()
dateDownloaded

## Unzip the downloaded data
unzip(zipfile="./data/Dataset.zip",exdir="./data")
list.files("./data/UCI HAR Dataset")
list.dirs("./data/UCI HAR Dataset")

## load libraories
library(data.table)
library(dplyr)

## I find it easier to use dplyr. So I have to subset de data.frames
subjectTest <- tbl_df(read.table("./data/UCI HAR Dataset/test/subject_test.txt"))    ## Test subjects
xTest <- tbl_df(read.table("./data/UCI HAR Dataset/test/X_test.txt"))                ## Test data set
yTest <- tbl_df(read.table("./data/UCI HAR Dataset/test/y_test.txt"))                ## activity labels for test
subjectTrain <- tbl_df(read.table("./data/UCI HAR Dataset/train/subject_train.txt")) ## Train subjects
xTrain <- tbl_df(read.table("./data/UCI HAR Dataset/train/X_train.txt"))             ## Train data set
yTrain <- tbl_df(read.table("./data/UCI HAR Dataset/train/y_train.txt"))             ## activity labels for train
features <- tbl_df(read.table("./data/UCI HAR Dataset/features.txt"))                ## List of all features
Activities <- tbl_df(read.table("./data/UCI HAR Dataset/activity_labels.txt"))       ## List of activities

## Explore data in the different tables
xTrain
yTrain
xTest
## yTest
subjectTest
## subjectTrain
Activities
## dim(features)
## dim(features)
## View(yTest)
## View(yTrain)
## View(subjectTest)
## View(subjectTrain)
## View(features)
## View(xTrain)
## View(xTest)
## View(Activities)


## Features column "V2" contains 561 rows of names for the 561 columns in xTest and xTrain
colnames(xTest) <- features$V2  ## Set columnnames for xTest from the Feature column "V2"
colnames(xTrain) <- features$V2 ## Set columnnames for xTrain from the Feature column "V2"

## To match activities in dataset later on, make logical columnnames for Activities
colnames(Activities) <- c("activityID", "activities")
colnames(yTrain) <- "activityID"
colnames(yTest) <- "activityID"
colnames(subjectTest) <- "subjectID"
colnames(subjectTrain) <- "subjectID"

## yTrain column "ActivityID" contains the 7352 rows of activity Idintifiers
## for the 7352 rows of measurements in xTrain
xTrain <- tbl_df(cbind(xTrain, yTrain))

## yTest column "ActivityID" contains the 2947 rows of activity labels
## for the 2947 rows of measurements in xTest
xTest <- tbl_df(cbind(xTest, yTest))

## subjectTest column "subjectID" contains 2947 rows of subject-identifiers
## for the 2947 rows of measurements in xTest
xTest <- tbl_df(cbind(xTest, subjectTest))

## subjectTrain column "subjectID" contains 7352 rows of subject-identifiers 
## for the 7352 rows of measurements in xTrain
xTrain <- tbl_df(cbind(xTrain, subjectTrain))

## Check
## names(xTest)
## names(xTrain)

## Assignment 1 - Now we merge the training en test sets together
xTrainTest <- tbl_df(rbind(xTrain, xTest))
xTrainTest ## Check number of columns should be 563 and number of rows 10299

## Check
## names(xTrainTest)
