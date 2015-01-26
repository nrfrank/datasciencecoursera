# Getting and Cleaning Data Course Project

## 1. Project Description

The purpose of this project is to merge and clean separate data sources to create a single, tidy data set. The data consist of signals from both the accelerometer and gyroscope of smartphones worn by subjects executing various activities. Additionally the raw data signals are broken into two classes, training and test. The data tidying process consists of five steps:

1.  Merge the training and the test sets to create one data set.
2.  Extract measurements of the mean and standard deviation for each measurement.
3.  Use descriptive activity names for the activities in the data set.
4.  Appropriately label the data set with descriptive variable names.
5.  From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

## 2. Raw Data

The raw data signals are contained in the /test and /train folders inside the main project data folder (/getdata-projectfiles-UCI HAR Dataset). The raw data files are named "X\_(test/train).txt." The test data set consists of 2947 observations (rows) or 561 variables (columns) and the train data set consists of 7352 observations of 561 variables. The activity type code for each of these observations is listed in the "y\_(test/train).txt" files. The activity name corresponding to each of these numerical codes is listed in the files "activity\_labels.txt." The six activities and the corresponding numerical codes are:

1.  WALKING
2.  WALKING_UPSTAIRS
3.  WALKING_DOWNSTAIRS
4.  SITTING
5.  STANDING
6.  LAYING

Each of the 561 variables is named in the file "features.txt" and these variables are described in the file "features\_info.txt." The variables consist of filtered signals from the accelerometer and gyroscope in each of the X, Y, and Z directions as well as various measurements made on these signals. Finally, numerical codes indicating the subjects who performed each of the observations in the test and train data sets are listed in "subject\_(test/train).txt."

## 3. Data Processing

The raw data files were read in with read.table and merged into a composite data set with a row bind (rbind). Next a list of the index locations (integers) of the columns to be saved was gathered using grep on "mean()" and "std()." 