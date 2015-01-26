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

### 3.1 Load and merge data

The raw data files for both the test and train data set were read in with read.table and merged into a composite data set called "mergeData" with a row bind (rbind). In this step I also read in the subject and activity lists for each of the test and train data sets to be added later in the analysis. Finally, all the supporting files, with the variable and activity names, were similarly read in.

### 3.2 Extract proper columns
Next a list of the index locations (integers) of the columns to be saved was gathered using grep on the variable name list for the phrases "mean()" and "std()." These columns were then extracted from the merged data set by subsetting on the column integer list. The choice to select only the columns with "mean()" and "std()" in the variable names will not include the time averages of the directional data that are used on the "angle()" variable.

### 3.3 Use appropriate Activity labels.
The test and train activity data, i.e. acitivty numbers for each observations, were combined with a row bind similarly to the raw data set. This column of activity numbers was added to the full data set with a columb bind (cbind) as was the subject number list. Next, a list of the acitivty names for each observation was created by matching the activity numbers from the data set to the activity number and activity name data. The match() process was used to create a list of the activity data index locations corresponding to each observation row and this list was used to extract the activity names (i.e. descriptions) from the activity data. The activity numbers were then removed from the data set by extracting this column with select().

### 3.4 Rename variable names
Next some substitutions were performed on the variable names to clean them up and make them more descriptive. The following substitutions were performed:

* Remove all special characters, i.e. ()-_.
* Change "mean" and "std" to "Mean" and "StdDev."
* Change the leading "t" and "f" to "timeDomain" and "frequencyDoman."
* Remove double instances of "Body."
* Change "Acc" and "Gyro" to "AccelerationSignal" and "GyroscopeSignal."
* Change "X," "Y," and "Z" to "(XYZ)direction."
* Finally, change "Mag" to "Magnitude."

The final variable list is as follows:

* timeDomainBodyAccelerationSignalMeanXdirection
* timeDomainBodyAccelerationSignalMeanYdirection
* timeDomainBodyAccelerationSignalMeanZdirection
* timeDomainBodyAccelerationSignalStdDevXdirection
* timeDomainBodyAccelerationSignalStdDevYdirection
* timeDomainBodyAccelerationSignalStdDevZdirection
* timeDomainGravityAccelerationSignalMeanXdirection
* timeDomainGravityAccelerationSignalMeanYdirection
* timeDomainGravityAccelerationSignalMeanZdirection
* timeDomainGravityAccelerationSignalStdDevXdirection
* timeDomainGravityAccelerationSignalStdDevYdirection
* timeDomainGravityAccelerationSignalStdDevZdirection
* timeDomainBodyAccelerationSignalJerkMeanXdirection
* timeDomainBodyAccelerationSignalJerkMeanYdirection
* timeDomainBodyAccelerationSignalJerkMeanZdirection
* timeDomainBodyAccelerationSignalJerkStdDevXdirection
* timeDomainBodyAccelerationSignalJerkStdDevYdirection
* timeDomainBodyAccelerationSignalJerkStdDevZdirection
* timeDomainBodyGryoscopeSignalMeanXdirection
* timeDomainBodyGryoscopeSignalMeanYdirection
* timeDomainBodyGryoscopeSignalMeanZdirection
* timeDomainBodyGryoscopeSignalStdDevXdirection
* timeDomainBodyGryoscopeSignalStdDevYdirection
* timeDomainBodyGryoscopeSignalStdDevZdirection
* timeDomainBodyGryoscopeSignalJerkMeanXdirection
* timeDomainBodyGryoscopeSignalJerkMeanYdirection
* timeDomainBodyGryoscopeSignalJerkMeanZdirection
* timeDomainBodyGryoscopeSignalJerkStdDevXdirection
* timeDomainBodyGryoscopeSignalJerkStdDevYdirection
* timeDomainBodyGryoscopeSignalJerkStdDevZdirection
* timeDomainBodyAccelerationSignalMagnitudeMean
* timeDomainBodyAccelerationSignalMagnitudeStdDev
* timeDomainGravityAccelerationSignalMagnitudeMean
* timeDomainGravityAccelerationSignalMagnitudeStdDev
* timeDomainBodyAccelerationSignalJerkMagnitudeMean
* timeDomainBodyAccelerationSignalJerkMagnitudeStdDev
* timeDomainBodyGryoscopeSignalMagnitudeMean
* timeDomainBodyGryoscopeSignalMagnitudeStdDev
* timeDomainBodyGryoscopeSignalJerkMagnitudeMean
* timeDomainBodyGryoscopeSignalJerkMagnitudeStdDev
* frequencyDomainBodyAccelerationSignalMeanXdirection
* frequencyDomainBodyAccelerationSignalMeanYdirection
* frequencyDomainBodyAccelerationSignalMeanZdirection
* frequencyDomainBodyAccelerationSignalStdDevXdirection
* frequencyDomainBodyAccelerationSignalStdDevYdirection
* frequencyDomainBodyAccelerationSignalStdDevZdirection
* frequencyDomainBodyAccelerationSignalJerkMeanXdirection
* frequencyDomainBodyAccelerationSignalJerkMeanYdirection
* frequencyDomainBodyAccelerationSignalJerkMeanZdirection
* frequencyDomainBodyAccelerationSignalJerkStdDevXdirection
* frequencyDomainBodyAccelerationSignalJerkStdDevYdirection
* frequencyDomainBodyAccelerationSignalJerkStdDevZdirection
* frequencyDomainBodyGryoscopeSignalMeanXdirection
* frequencyDomainBodyGryoscopeSignalMeanYdirection
* frequencyDomainBodyGryoscopeSignalMeanZdirection
* frequencyDomainBodyGryoscopeSignalStdDevXdirection
* frequencyDomainBodyGryoscopeSignalStdDevYdirection
* frequencyDomainBodyGryoscopeSignalStdDevZdirection
* frequencyDomainBodyAccelerationSignalMagnitudeMean
* frequencyDomainBodyAccelerationSignalMagnitudeStdDev
* frequencyDomainBodyAccelerationSignalJerkMagnitudeMean
* frequencyDomainBodyAccelerationSignalJerkMagnitudeStdDev
* frequencyDomainBodyGryoscopeSignalMagnitudeMean
* frequencyDomainBodyGryoscopeSignalMagnitudeStdDev
* frequencyDomainBodyGryoscopeSignalJerkMagnitudeMean
* frequencyDomainBodyGryoscopeSignalJerkMagnitudeStdDev

### 3.5 Create final tidy data set
Finally, the summary data set was created by using the group\_by() and summarise\_each() functions. The data was grouped by activity name and subject number and then the average was taken on each of these groups.

## 4. Notes
The summary data set is output in the file "tidyDataSet\_GetAndCleanData-CourseProject.txt" and should be read in with the statement read.table("tidyDataSet\_GetAndCleanData-CourseProject.txt", header = TRUE). Also, the run\_analysis.R script should be in the main project data directory as it references the train and test folders specifically.