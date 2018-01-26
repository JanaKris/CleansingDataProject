---
title: "Code Book"
author: "JanaKris"
date: "January 26, 2018"
output: html_document
---


## INTRODUCTION

Human Activity Recognition Using Smartphones 

The following information was obtained from:
activityrecognition@smartlab.ws
www.smartlab.ws


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 



## CHALLENGE
Read a number of data files, cleanse them, merge them, add additional details when
necessary and produce an summarized data to gain inference from the original datasets.


## STEPS

The critical step to tackling this assignment is to understand the various files
and its data. Project README and Forum blogs helped tremendously!

### 1. Build the required dataset
     
     There are 2 main dataset - TEST & TRAIN
     Each with a set of:
     - Observations (x_test, x_train)
     - Activities (y-test, y_train)
     - Subjects (subject_test, subject_train)
     
     I added ID fields to each of the datasets to help merge them all into one.
     I added an addional field called "setname" to identify between TEST and TRAIN observations.
     (This is however not used in the final summary file).
     
     My "merged" file had the following fields:
     - setname      - E.g. test, train
     - id           
     - subject      - 1 to 30 (number representing users who participated in this exercise)
     - activity     - 1 to 6 (Walking, Standing etc. )
     - v1, v2 .... etc. (These are the various measures/observations)
     
     
### 2. Extract only the measurements on the mean and standard deviation observations.

     Measure names are available in the "features" file.
     I used this to isolate the measures that have 
     either a "std"" or "mean" in its column name.
     
     I then trimmed the merged dataset to these specific columns.
     
     Couple of subtasks here:
     - Substitute activity# with activity name 
       Details were obtained from "activity_labels.txt"
       This is handled in section #3 of my R script
       
     - Rename the measure columns in the trimmed-down file to a meaningful name.
       Details were obtained from the "features" file          
       This is handled in section #4 of my R script
     

### 3. Create a tidy, summarized dataset

     I used the dplyr package to 
     - group the dataset by subject & activity
     - summarize all the std/mean measures. (mean function) 
     
     The result was written into a text file.



## TIDY, SUMMARIZED DATASET - tidydata_summary.txt

This file provides average of each observation, for each subject and activity cobination.
It contains 180 observations (30 subjects x 6 activities).
There are 81 columns in this file - subject, activity & 79 measures.


1    subject:

     type integer
     Each row identifies the subject who performed the activity for each window sample. 
     It ranges from 1 to 30. 

2    activity:

     Activity performed by the subject.
     Values include: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING


3 - 81

     type number
     Below is the list of all the other fields in the file.
     These are the average of each of the observations for each subject and activities.
     
     
     <<< below note is from the project feature document explaining the experiment readings >>>

     The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
     
     Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
     
     These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

 
                            
tBodyAcc.mean...X               
tBodyAcc.mean...Y              
tBodyAcc.mean...Z               
tBodyAcc.std...X                
tBodyAcc.std...Y                
tBodyAcc.std...Z               
tGravityAcc.mean...X            
tGravityAcc.mean...Y            
tGravityAcc.mean...Z            
tGravityAcc.std...X            
tGravityAcc.std...Y        
tBodyAccJerk.mean...X           
tBodyAccJerk.mean...Y          
tBodyAccJerk.mean...Z      
tBodyAccJerk.std...Y            
tBodyAccJerk.std...Z           
tBodyGyro.mean...X         
tBodyGyro.mean...Z              
tBodyGyro.std...X              
tBodyGyro.std...Y               
tBodyGyro.std...Z               
tBodyGyroJerk.mean...X          
tBodyGyroJerk.mean...Y         
tBodyGyroJerk.mean...Z          
tBodyGyroJerk.std...X           
tBodyGyroJerk.std...Y           
tBodyGyroJerk.std...Z          
tBodyAccMag.mean..              
tBodyAccMag.std..               
tGravityAccMag.mean..           
tGravityAccMag.std..           
tBodyAccJerkMag.mean..         
tBodyAccJerkMag.std..           
tBodyGyroMag.mean..             
tBodyGyroMag.std..             
tBodyGyroJerkMag.mean..         
tBodyGyroJerkMag.std..          
fBodyAcc.mean...X               
fBodyAcc.mean...Y              
fBodyAcc.mean...Z               
fBodyAcc.std...X                
fBodyAcc.std...Y                
fBodyAcc.std...Z               
fBodyAcc.meanFreq...X           
fBodyAcc.meanFreq...Y           
fBodyAcc.meanFreq...Z           
fBodyAccJerk.mean...X          
fBodyAccJerk.mean...Y           
fBodyAccJerk.mean...Z           
fBodyAccJerk.std...X            
fBodyAccJerk.std...Y           
fBodyAccJerk.std...Z            
fBodyAccJerk.meanFreq...X       
fBodyAccJerk.meanFreq...Y       
fBodyAccJerk.meanFreq...Z      
fBodyGyro.mean...X              
fBodyGyro.mean...Y              
fBodyGyro.mean...Z              
fBodyGyro.std...X              
fBodyGyro.std...Y               
fBodyGyro.std...Z               
fBodyGyro.meanFreq...X          
fBodyGyro.meanFreq...Y         
fBodyGyro.meanFreq...Z          
fBodyAccMag.mean..              
fBodyAccMag.std..               
fBodyAccMag.meanFreq..         
fBodyBodyAccJerkMag.std..       
fBodyBodyAccJerkMag.meanFreq..  
fBodyBodyGyroMag.mean..        
fBodyBodyGyroMag.std..          
fBodyBodyGyroMag.meanFreq..     
fBodyBodyGyroJerkMag.mean..     
fBodyBodyGyroJerkMag.std..     
fBodyBodyGyroJerkMag.meanFreq..
