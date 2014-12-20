# Code Book for Getting and Cleaning Data Class Project

## Introduction

The purpose of this Code Book is to describe the variables, the data and transformations applied to produce a tidy dataset of only the mean and standard deviation measurements from the original data set.

## Transformations 

The transformations were to take the original data and turn it into "tidy" data that contain the following characteristics as defined by Hadley:
1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

## Transformations Applied

After reading in the data, the first transformation applied was to filter the data to contain only the mean and standard deviation columns. This was accomplished with the help of the "grep" command, which is similar in spirit to the UNIX grep function, used for searching.

The second major step was to add the y data or the activity ID of each observation to the data set. This was done with the "cbind()" function for joining columns to datasets. To make the data more friendly to human readers, a join() function was used to add an activity label.

The original names of the columns contained non-alpha numeric characters. The third step was to filter out non-alphanumeric characters using the "gsub()" function and a regular expression.

The fourth step added the subject ID to dataset, using another "cbind()" command.

Each of the 4 steps was completed for both the test and train data. Once both datasets were read in, the data was merged together using the "rbind()" command.

## Transformations - Summary table
The summary table was created using dplyr. In particular, the data was organized using the "group_by()" function on the subject ID and activity, and the remaining columns then had the "mean()" function applied to them.


## The Data
Originally, the data was divided up into two folders, a "test" and "train" dataset. Within the folders, the data was further divided into 3 file sets as follows:
* subject_test.txt / subject_train.txt: a file containing the subject ID of the person wearing the computing device taking the measurement for each record

* X_test.txt / X_train.txt: the files containing the measurement data

* y_test.txt / y_train.txt: the files containing the activity ID of the measurement data

### Why the data created by this script should be considered tidy. 
The output dataset, tidy.txt, has a separate row for each observation, each column is a variable, and the entire table forms an observational unit. This is consistent with Hadley's description of a tidy dataset. 



## Variable list and description
"subject_id" - this is the subject ID of the person wearing the recording device. The expected values are between 1 and 30.
                 
"activityid" - a numeric number corresponding to the activity the test subject was performing
               
"activity" - a text description of the activity

The following are mean body linear acceleration on the X, Y, and Z axis. Units of measure: time in seconds.
"tBodyAccMeanX"                
"tBodyAccMeanY"               
"tBodyAccMeanZ" 

The following are mean gravity linear acceleration on the X, Y, and Z axis. 
Units of measure: time in seconds.               
"tGravityAccMeanX"             
"tGravityAccMeanY"             
"tGravityAccMeanZ"     

The following are mean body linear acceleration jerk signals on the X, Y, and Z axis. 
Units of measure: time in secconds.        
"tBodyAccJerkMeanX"           
"tBodyAccJerkMeanY"            
"tBodyAccJerkMeanZ"   

The following are mean gravity gyroscope signals on the X, Y, and Z axis.
Units of measure: radians per second.         
"tBodyGyroMeanX"               
"tBodyGyroMeanY"               
"tBodyGyroMeanZ"   

The following are mean gravity gyroscope jerk signals on the X, Y, and Z axis.
Units of measure: radians per second.           
"tBodyGyroJerkMeanX"           
"tBodyGyroJerkMeanY"           
"tBodyGyroJerkMeanZ"    
   
 
"tBodyAccMagMean" - magnitude of the mean body linear acceleration. Units: time in seconds.
            
"tGravityAccMagMean" - magnitude of the mean gravity acceleration. Units: time in seconds.
        
"tBodyAccJerkMagMean" - magnitude of the mean gravity jerk signal. Units: radians / second.
      
"tBodyGyroMagMean"  -  magnitude of the gravity gyroscope signal. Units: radians / second.          
"tBodyGyroJerkMagMean" - magnitude of the mean gravity gyroscope jerk signal. Units: raidans / second.


### The following variables had a Fast Fourier Transform applied to the signals to produce their values
       
	   
The following are the frequency of the mean body linear acceleration along the X, Y, and Z axis. 
Units: time in seconds.
"fBodyAccMeanX"                
"fBodyAccMeanY"               
"fBodyAccMeanZ" 

The following are the average frequency of mean linear acceleration along the X, Y, and Z axis.
Units: time in seconds.               
"fBodyAccMeanFreqX"            
"fBodyAccMeanFreqY"            
"fBodyAccMeanFreqZ"  

The following are the mean gravity gyroscope jerk signals along the X, Y, and Z axis.    
Units: time in seconds.      
"fBodyAccJerkMeanX"           
"fBodyAccJerkMeanY"            
"fBodyAccJerkMeanZ" 

The following are the average frequency for the gyroscope jerk signals along the X, Y, and Z axis.
Units: time in seconds.       
"fBodyAccJerkMeanFreqX"        
"fBodyAccJerkMeanFreqY"        
"fBodyAccJerkMeanFreqZ" 

The following are the mean of the gyroscope signal along the X, Y, and Z axis.
Units: radians /second
"fBodyGyroMeanX"               
"fBodyGyroMeanY"               
"fBodyGyroMeanZ"   

The following are the mean frequency of the gyroscope signal along the X, Y, and Z axis.
Units: radians /second
"fBodyGyroMeanFreqX"           
"fBodyGyroMeanFreqY"          
"fBodyGyroMeanFreqZ"   

        
"fBodyAccMagMean" - magnitude of the mean acceleration. Units: time in seconds.
          
"fBodyAccMagMeanFreq" - magnitude of the mean frequency. Units: time in seconds.
          
"fBodyBodyAccJerkMagMean"  - mean magnitude of the jerk acceleration. Units: time in seconds.

"fBodyBodyAccJerkMagMeanFreq" - mean magnitude of the jertk accleration frequency. Units: time in seconds.

"fBodyBodyGyroMagMean" - average of the magnitude of the mean gyroscope gravity signal. Units: radians per second.

"fBodyBodyGyroMagMeanFreq" - average of the magnitude of the mean frequency of the gravity signal. Units: radians per second.
    
"fBodyBodyGyroJerkMagMean" - mean magnitude of the gyroscope gravity signal. Units: radians per second.
  
"fBodyBodyGyroJerkMagMeanFreq" - average of the mean frequency of the gyroscope. Units: radians per second.




### The following variables contain standard deviation values for each measurement. As with the mean data, X, Y, or Z are used to denote signals in the X, Y, and Z directions.
"tBodyAccStdX"                
"tBodyAccStdY"                 
"tBodyAccStdZ"                 
"tGravityAccStdX"              
"tGravityAccStdY"              
"tGravityAccStdZ"             
"tBodyAccJerkStdX"             
"tBodyAccJerkStdY"             
"tBodyAccJerkStdZ"             
"tBodyGyroStdX"                
"tBodyGyroStdY"               
"tBodyGyroStdZ"                
"tBodyGyroJerkStdX"            
"tBodyGyroJerkStdY"            
"tBodyGyroJerkStdZ"            
"tBodyAccMagStd"              
"tGravityAccMagStd"            
"tBodyAccJerkMagStd"           
"tBodyGyroMagStd"              
"tBodyGyroJerkMagStd"          
"fBodyAccStdX"                
"fBodyAccStdY"                 
"fBodyAccStdZ"                 
"fBodyAccJerkStdX"             
"fBodyAccJerkStdY"             
"fBodyAccJerkStdZ"            
"fBodyGyroStdX"                
"fBodyGyroStdY"                
"fBodyGyroStdZ"                
"fBodyAccMagStd"               
"fBodyBodyAccJerkMagStd"      
"fBodyBodyGyroMagStd"          
"fBodyBodyGyroJerkMagStd"     

