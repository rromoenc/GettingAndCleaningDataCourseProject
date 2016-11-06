# Ricardo Romo Encino
# Getting & Cleanning Data
# Data Science Specialization
# Coursera - Johns Hopkins University

################################################ Project ###############################################################################
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and 
#    each subject.
########################################################################################################################################

# This script is supposed to be saved in a folder "UCI HAR Dataset" downloaded from the project's directions  
# webpage and that also contains the test and train folders.

setwd("C:/Ric/10 Learning/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset")


# 00) Loading required libraries

library(Hmisc)
library(dplyr)
library(plyr)

# 01) Reading the column names (features) for the data sets from the features.txt file
colNames <- read.table("./features.txt", header = FALSE)

# 02) Reading the activities performed from the activity_labels.txt file
activityNames <- read.delim("./activity_labels.txt", header = FALSE, col.names = c("activityId","activity"), sep = "", dec = ".", fill = FALSE)

# 03) Modifying the Activity names
activityNames$activity <- as.factor(capitalize(tolower(sub("_", " ", activityNames$activity))))

# 04) Reading the vector of Activity IDs for the test and training data set
testLabels <- read.delim("./test/y_test.txt", header = FALSE, col.names = c("activityId"))
trainingLabels <- read.delim("./train/y_train.txt", header = FALSE, col.names = c("activityId"))

# 05) Reading the data from the x_test.txt and x_train.txt files
x_test <- read.delim("./test/X_test.txt", header = FALSE, col.names = colNames$V2, sep = "", dec = ".", fill = FALSE)
x_train <- read.delim("./train/X_train.txt", header = FALSE, col.names = colNames$V2, sep = "", dec = ".", fill = FALSE)

# 06) Binding the Activity ID column for the data sets
x_test <- cbind(testLabels, x_test)
x_train <- cbind(trainingLabels, x_train)

# 07) Reading the subject information
subject_test <- read.delim("./test/subject_test.txt", header = FALSE, col.names = c("subjectId"))
subject_train <- read.delim("./train/subject_train.txt", header = FALSE, col.names = c("subjectId"))

# 08) Binding the Subjects ID to the data sets
x_test <- cbind(subject_test, x_test)
x_train <- cbind(subject_train, x_train)

# 09) Binding both data sets
x_data <- rbind(x_test, x_train)

# 10) Keeping only the mean and std data columns
## Getting only a subset of columns
x_data <- x_data[colnames(x_data)[grep(pattern = "Id|mean|std", x = colnames(x_data))]]

# 11) Renaming the columns

# In the class they suggested naming the columns in lower case. However I believed is clearer to use
# a capital letter when a new word start in the middle of the column (variable) name. This style is
# known as Camel case

filteredColNames <- as.data.frame(colnames(x_data)[grep(pattern = "Id|mean|std", x = colnames(x_data))])
colnames(filteredColNames) <- c("name")

filteredColNames$name <- sub("t", "time", filteredColNames$name)
filteredColNames$name <- sub("f", "frequency", filteredColNames$name)
filteredColNames$name <- sub("Acc", "Accelerometer", filteredColNames$name)
filteredColNames$name <- sub("Gyro", "Gyroscope", filteredColNames$name)
filteredColNames$name <- sub("mean", "Mean", filteredColNames$name)
filteredColNames$name <- sub("std", "Std", filteredColNames$name)
filteredColNames$name <- gsub("\\.", "", filteredColNames$name)
filteredColNames$name[1] <- "subjectId"
filteredColNames$name[2] <- "activityId"

colnames(x_data) <- filteredColNames$name

# We have here the tidy data with descriptive variable names

# 12) Creating the summarized data

# Joining the activity names to the summarized data
meansGroupedByActivityAndSubject <- merge(activityNames, x_data, by = "activityId")

# Getting rid of the activityId variable
meansGroupedByActivityAndSubject <- select(meansGroupedByActivityAndSubject, -activityId)

# Setting the group by fields
meansGroupedByActivityAndSubject <- group_by(meansGroupedByActivityAndSubject, activity, subjectId)

# Applying the mean (average) function to all the columns but activity and subjectID because these two are
# the grouping by columns
meansGroupedByActivityAndSubject <- ddply(meansGroupedByActivityAndSubject, .(activity, subjectId), colwise(mean))

# 13) Writing into a file both data frames
write.table(x_data, file = "./x_data.txt", sep = "\t", eol = "\n", row.names = FALSE)
write.table(meansGroupedByActivityAndSubject, file = "./meansGroupedByActivityAndSubject.txt", sep = "\t", eol = "\n", row.names = FALSE)
write.table(activityNames, file = "./activity.txt", sep = "\t", eol = "\n", row.names = FALSE)