# README.md

##Usage:
From an R command prompt, simply enter the following commands:
* source("run_analysis.R")
* run.analysis()

## RETURNS:
   1. writes a file in the current working directory called "tidy.txt"
   2. writes a file in the current working directory called "summmary.txt"
   3. run.analysis() returns in the R environment a data set called summaryTable
     this contains the summary data for the assignment

It is possible to read the data into R using the following command:
* testRead <- read.table("./tidy.txt", header = TRUE, sep = "")

The variable "testRead" will contain the tidy data.


## Constraints:
   1.this program expects a folder named "UCI HAR Dataset" to be
     in the current working directory
   2. The script depends on the following libraries
    - plyr
	- dplyr
	The script will not run without these libraries being first installed.
	The script will load them as part of the execution.


##File descriptions:

### Included files in this package:
* run_analysis.R - The script used to convert the dataset into tidy data and product a summary

* README.md - this file

* CodeBook.md - a file describing the data created by run_analysis.R


### Generated files from run_analysis.R:
* tidy.txt - the tidy data output file

* summary.txt - the summarized data


## About the Data

The script, run_analysis.R, was designed to clean and tidy the dataset, "Human Activity Recognition Using Smartphones", from the UCH Machine Learning Repository. The original source of the data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The goal of this project was to take the original data and turn it into "tidy" data as defined by Hadley in the Journal of Statistical Software here: http://www.jstatsoft.org/v59/i10/paper

In particular, tidy data contains the three following characteristics:
1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.


### Tidy Data
The dataset was saved using write.table() command. Specifically, the following command was used:
write.table(combinedSet, file="tidy.txt", row.name = FALSE)

It is possible to read the data into R using the following command.
* testRead <- read.table("./tidy.txt", header = TRUE, sep = "")

The variable "testRead" will contain the tidy data.


###Summmary Data
The summary dataset was also saved using the write.table() command. Here is the command syntax used:
write.table(summaryTable, file="summary.txt", row.name = FALSE)

The data can be read as follows:
* testSummary <- read.table("./summary.txt", header = TRUE, sep = "")

### Why the data created by this script should be considered tidy. 
The output dataset, tidy.txt, has a separate row for each observation, each column is a variable, and the entire table forms an observational unit. This is consistent with Hadley's description of a tidy dataset. 

