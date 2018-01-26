# CleansingDataProject
Repository for files related to the Cleansing Data course project

### Assignment Summary:
The goal of this assignment is to showcase my understanding of R programming language, 
with the ability to collect, work with and clean datasets.


### Challenge:
Read a number of data files, cleanse them, merge them, add additional details when
necessary and produce an summarized data to gain inference from the original datasets.


### Files:
This repository contains the following files:
- README.md              - this file
- CodeBook.md            - Code book explaining the process step-by-step, with details on the end tidy file.
- run_analysis.R         - R Script that handles this week's chanllenge
- tidydata_summary.txt   - End result with the requested tidy, summarized data


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
     