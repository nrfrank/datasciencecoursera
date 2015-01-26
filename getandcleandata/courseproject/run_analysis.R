# Load in the dplyr package.
library(dplyr)

# Move to test directory and read in the test data set ("X_test.txt"), the
# activity type for each observation in the data set ("y_test.txt"), and the
# subject who performed each observation ("subject_test.txt")
if (!exists('testActivityData')) {
  testActivityData <- read.table("test/y_test.txt", 
                                 col.names = c("activityNumber"))
}

if (!exists('testData')) {
  testData <- read.table("test/X_test.txt")
}

if (!exists('testSubjects')) {
  testSubjects <- read.table("test/subject_test.txt",
                             col.names = c("subjectNumber"))
}

# Read in the train data set, activity list, and subject list.
if (!exists('trainActivityData')) {
  trainActivityData <- read.table("train/y_train.txt", 
                                  col.names = c("activityNumber"))
}

if (!exists('trainData')) {
  trainData <- read.table("train/X_train.txt")
}

if (!exists('trainSubjects')) {
  trainSubjects <- read.table("train/subject_train.txt", 
                              col.names = c("subjectNumber"))
}

# Merge the test and train data sets together with a row bind.
if (!exists('mergeData')) {
  mergeData <- rbind(trainData,testData)
}

# Read in "features.txt" to get the variable name list.
if (!exists('variableNames')) {
  variableNames <- read.table("features.txt", 
                              col.names = c("colIndex", "colName"))
}

# Extract the columns with "mean()" and "std()" in them. This will only
# select the variables which are the mean and standard deviation estimated
# from the time and frequency domain accelerometer and gyroscope signals. This
# will not include the variables for the signals averaged within a signal
# window and used on the "angle()" variable.
meanColList <- grep("mean\\(\\)", variableNames$colName, perl = TRUE)
stdColList <- grep("std\\(\\)", variableNames$colName, perl = TRUE)

# Combine the column (intergers of column numbers) lists of variables with
# "mean()" and "std()" together to form a composite list.
fullColList <- sort(append(meanColList, stdColList))

# Create a "tidy" data set with only the columns extracted in the step above.
tidyData <- mergeData[, fullColList]

# Make some substitutions to clean up the variable names. This will make things
# easier when we apply the variable names as the column names of the data set.
# All these choices are overly verbose, but that seems a better choice than to
# have ambiguity.

# Remove special characters.
varNameList <- gsub("[(),-]", "", variableNames[fullColList, ]$colName)

# Uppercase all "mean" and change "std" to "StdDev."
varNameList <- gsub("mean", "Mean", varNameList)
varNameList <- gsub("[Ss]td(?!Dev)", "StdDev", varNameList, perl = TRUE)

# Change leading "t" and "f" to "timeDomain" "frequencyDomain," respectively.
varNameList <- gsub("^t(?!ime)", "timeDomain", varNameList, perl = TRUE)
varNameList <- gsub("^f(?!req)", "frequencyDomain", varNameList, perl = TRUE)

# remove double "Body"
varNameList <- gsub("(Body){2}", "Body", varNameList)

# Change "Acc" and "Gyro" to "AccelerationSignal" and "GyroscopeSignal."
varNameList <- gsub("Acc(?!e)", "AccelerationSignal", varNameList, perl = TRUE)
varNameList <- gsub("Gyro(?!s)", "GryoscopeSignal", varNameList, perl = TRUE)

# Change all trailing "X," "Y," and "Z" to "(XYZ)direction."
varNameList <- gsub("X$(?!d)", "Xdirection", varNameList, perl = TRUE)
varNameList <- gsub("Y$(?!d)", "Ydirection", varNameList, perl = TRUE)
varNameList <- gsub("Z$(?!d)", "Zdirection", varNameList, perl = TRUE)

# change "Mag" to "Magnitude."
varNameList <- gsub("Mag(?!n)", "Magnitude", varNameList, perl = TRUE)

# Now, add the edited variable name list as the column names of the tidyData.
names(tidyData) <- varNameList

# Read in "activity_labels.txt" with activity label names for each observation.
if (!exists('activityNames')) {
  activityNames <- read.table("activity_labels.txt", 
                              col.names = c("activityNumber", "activityName"))
}

# Add together test and train acitivity lists and append to tidy data set.
if (!exists('activityData')) {
  activityData <- rbind(trainActivityData, testActivityData)
}

if (!exists('tidyData$activityNumber')) {
  tidyData <- cbind(tidyData, activityData)
}

# Add together test and train subject lists and append to tidy data set.
if (!exists('subjectData')) {
  subjectData <- rbind(trainSubjects, testSubjects)
}

if (!exists('tidyData$subjectNumber')) {
  tidyData <- cbind(tidyData, subjectData)
}

# Add column for (descriptively named) activity type to tidy data set.
if (!exists('tidyData$activityName')) {
  tidyData$activityName <- activityNames[match(tidyData$activityNumber, 
                                               activityNames$activityNumber), 2]
}

# Remove the column for the activity number code.
tidyData <- select(tidyData, -activityNumber)

# Finally, summarize the tidy data by taking the means broken down by
# activity and subject.
summaryData <- summarise_each(group_by(tidyData, activityName, subjectNumber),
                              funs(mean))

# Now that we havbe our tidy data set we can write it out using write.table.
write.table(summaryData, "tidyDataSet_GetAndCleanData-CourseProject.txt",
            row.names = FALSE)