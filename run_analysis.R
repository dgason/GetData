###############################################
#run_analysis.R
#
# USAGE:
#	From within an R environment:
#	 >source("run_analysis.R")
#  >run.analysis()
#
# alternate usage:
# >summaryData <- run.analysis()
#
# RETURNS:
#   1. writes a file in the current working directory called "tidy.txt"
#   2. writes a file in the current working directory called "summmary.txt"
#   3. run.analysis() returns in the R environment a data set called 
#     this contains the summary data for the assignment
#
# CONSTRAINTS:
#   1.this program expects a folder named "UCI HAR Dataset" to be
#     in the current working directory
#   2. depends on the following libraries
#        - plyr
#        - dplyr
#
# TO READ THE DATA BACK IN:
#   >testRead <- read.table("./tidy.txt", header = TRUE, sep = "")
#   >testSummary <- read.table("./summary.txt", header = TRUE, sep = "")



library(plyr)
library(dplyr)
#library(data.table)

#############################################
#readFeatures
# returns the list of features for the dataset
readFeatures <- function() {
  features <- read.table("UCI HAR Dataset/features.txt", header = FALSE, sep = "")
  
  features
}

###############################################
#readX
# read in the X dataset
#	filePath: provide a path to the file: "UCI HAR Dataset/test/X_test.txt"
readX<- function(filePath, colNames) {
  x_test <- read.table(filePath, header = FALSE, col.names = colNames, colClasses = "numeric", sep = "")
  
  x_test
}
 
###############################################
#readY
# read in the y dataset
#	filePath: provide a path to the file: "UCI HAR Dataset/test/y_test.txt"
readY <- function(filePath) {
  y_test <- read.table(filePath, col.names="activity_id", header = FALSE, sep = "")
  
  colnames(y_test) <- c("activity_id")
  y_test
}

###############################################
#readSubject
# read in the subject info dataset
#	filePath: provide a path to the file: "UCI HAR Dataset/test/subject_test.txt"
readSubject <- function(filePath) {
  subjectTest <- read.table(filePath, col.names="subject_id", header = FALSE, sep = "")

  subjectTest
}

###############################################
#readActivityLabels
# read in the activity labels
readActivityLabels <- function() {
  activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity"), header = FALSE,  sep = "")
  
  activityLabels
}

###############################################
#run.analysis()
# returns a summary analysis table
# writes the summary data and tidy data to output files
#
run.analysis <- function() {
  print("begin run_analysis...............")

	#read the features (columns) of the data, save in a factor
	features <- readFeatures()
	dataColNames <- features$V2

	#read in the activity labels
	activityLabels <- readActivityLabels()

	############################################
	### test data
	############################################

  print("Read and process the test data")

	#read in the y labels for the test data
	testY <- readY("UCI HAR Dataset/test/y_test.txt")
	
	#read in the test data
	testData <- readX("UCI HAR Dataset/test/X_test.txt", dataColNames)

	#filter on columns for the mean or standard deviation
	meanSet <- testData[, grep("mean", colnames(testData))]
	stdSet  <- testData[, grep("std", colnames(testData))]

	combinedSet <- cbind(meanSet, stdSet)

	#add the activity from the Y set to the combined set
	combinedSet <- cbind(testY$activity_id, combinedSet)
	colnames(combinedSet)[1] <- "activity_id"

	#use the activity labels as a lookup table
	combinedSet <- join(activityLabels, combinedSet, by="activity_id")

	#clean up of the column names: do this for legibility
	colNames <- colnames(combinedSet)
	newColNames <- gsub("mean","Mean",colnames(combinedSet))
	newColNames <- gsub("std","Std",newColNames)
	#remove non alphanumeric characters using a regex
	newColNames <- gsub("[^a-zA-Z0-9]","",newColNames)
	colnames(combinedSet) <- newColNames

	#add the subject ID to the combinedSet
	subjectTest <- readSubject("UCI HAR Dataset/test/subject_test.txt")
	combinedSet <- cbind(subjectTest, combinedSet)


	#convert to a data.table to take advantage of the SQL-like group by command
	#combinedTable <- data.table(combinedSet)

	
	############################################
	### train data
	############################################

  print("Read and process the train data")

	#read in the y labels for the train data
	trainY <- readY("UCI HAR Dataset/train/y_train.txt")
	
	#read in the train data
	trainData <- readX("UCI HAR Dataset/train/X_train.txt", dataColNames)

	#filter on columns for the mean or standard deviation
	meanSet <- trainData[, grep("mean", colnames(trainData))]
	stdSet  <- trainData[, grep("std", colnames(trainData))]

	trainSet <- cbind(meanSet, stdSet)

	#add the activity from the Y set to the combined set
	trainSet <- cbind(trainY$activity_id, trainSet)
	colnames(trainSet)[1] <- "activity_id"

	#use the activity labels as a lookup table
	trainSet <- join(activityLabels, trainSet, by="activity_id")

	#clean up of the column names: do this for legibility
	colNames <- colnames(trainSet)
	newColNames <- gsub("mean","Mean",colnames(trainSet))
	newColNames <- gsub("std","Std",newColNames)
	#remove non alphanumeric characters using a regex
	newColNames <- gsub("[^a-zA-Z0-9]","",newColNames)
	colnames(trainSet) <- newColNames

	#add the subject ID to the trainSet
	subjecttrain <- readSubject("UCI HAR Dataset/train/subject_train.txt")
	trainSet <- cbind(subjecttrain, trainSet)
	
	############################################
	### combine test and train
	############################################
  print("Combine test and train data")
	combinedSet <- rbind(combinedSet, trainSet)

	############################################
	### create the summary
	############################################
	print("Create the summary")
	
	#summaryTable <- combinedTable[,list(meanX=mean(tBodyAccMeanX),meanY=mean(tBodyAccMeanY),meanZ=mean(tBodyAccMeanZ)),by=subject_id]

	#summaryTable <- combinedTable %>% group_by(subject_id, activityid, activity) %>% summarise_each(funs(mean))
	summaryTable <- combinedSet %>% group_by(subject_id, activityid, activity) %>% summarise_each(funs(mean))

  ###########################################
  ### write out the combined set and the summary set
  ###########################################
  print("Write out the data")
  write.table(combinedSet, file="tidy.txt", row.name = FALSE)

  write.table(summaryTable, file="summary.txt", row.name = FALSE)

  print("End run_analysis....................")
  
  summaryTable
}
