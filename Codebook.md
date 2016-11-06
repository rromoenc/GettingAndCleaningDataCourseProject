**Ricardo Romo Encino**
Getting & Cleanning Data
Data Science Specialization
Coursera - Johns Hopkins University

# Getting and Cleaning Data Course Project

## Original data files

The original data files contain information about the features selected for that database. The authors are Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. You can find more information in [www.smartlab.ws](www.smartlab.ws).

The features come from the accelerometer and gyroscope 3-axial raw signals timeAccelerometer-XYZ and timeGyroscope-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAccelerometer-XYZ and timeGravityAccelerometer-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccelerometerJerk-XYZ and timeBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccelerometerMag, timeGravityAccMag, timeBodyAccelerometerJerkMag, timeBodyGyroscopeMag, timeBodyGyroscopeJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequencyBodyAcc-XYZ, frequencyBodyAccJerk-XYZ, frequencyBodyGyroscope-XYZ, frequencyBodyAccelrometerJerkMag, frequencyBodyGyrosopeMag, frequencyBodyGyroscopeJerkMag. 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

timeBodyAccelerometer-XYZ
timeGravityAccelerometer-XYZ
timeBodyAccelerometerJerk-XYZ
timeBodyGyroscope-XYZ
timeBodyGyroscopeJerk-XYZ
timeBodyAccelerometerMag
timeGravityAccelerometerMag
timeBodyAccelerometerJerkMag
timeBodyGyroscopeMag
timeBodyGyroscopeJerkMag
frequencyBodyAccelerometer-XYZ
frequencyBodyAccelerometerJerk-XYZ
frequencyBodyGyroscope-XYZ
frequencyBodyAccelerometerMag
frequencyBodyAccelerometerJerkMag
frequencyBodyGyroscopeMag
frequencyBodyGyroscopeJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

## Project Directions

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This script is supposed to be saved in a folder "UCI HAR Dataset" downloaded from the project's directions webpage and that also contains the test and train folders.

## Steps

### Creating the detailed main tidy data set 

0. Load the required libraries. The next are the required libraries:

* library(Hmisc)
* library(dplyr)
* library(plyr)

1. Read the column names (features) for the data sets from the features.txt file and store the info in the colNames data frame object

2. Reading the activities performed from the activity_labels.txt file and store the information in the activityNames data frame object

3. Modify the Activity names. Remove the "_" character and convert to lowercase the text. After capitalize it.

4. Read the vector with the ActivityIDs for the test and training data set. These vectors have the information to connect each data row with the corresponding performed activity. This vectors are loaded into the testLabels and trainingLabels objects

5. Read the data from the x_test.txt and x_train.txt files into the x_test and x_traing data frames. Use the colNames data frame as a parameter to assign the column names to the data frames.

6. Bind the testLabels to the x_test data frame and trainingLabels to the x_train data frame in order to have the Activity ID column in both x_test and x_train data sets.

7. Read the subject information. Read the subject id information into the subject_test and subject_train data frames. Set the only one column's name as "subjectId" for both subject data frames.

8. Bind the subject_test to the x_test data frame and the subject_train to the x_train data frame in order to have the Subjects IDs in both x_test and x_train data frames.

9. Bind both x_test and x_train data frame and store them in the new x_data data frame

10. Get rid of some columns keeping only the idm mean and std related columns. Use the grep function with the "Id|mean|std" pattern. Store the data frame in the same x_data object

11. Rename the columns. In the class they suggested naming the columns in lower case. However I believed is clearer to use a capital letter when a new word start in the middle of the column (variable) name. This style is known as Camel case. In order to accomplish this do the next:

* Get the x_data data frame column names and store the info in the filteredColNames data frame
* Replace the "t" with "time using filteredColNames$name <- sub("t", "time", filteredColNames$name)
* Replace the "f" with "frequency" using filteredColNames$name <- sub("f", "frequency", filteredColNames$name)
* Replace "Acc" with "Accelerometer" using filteredColNames$name <- sub("Acc", "Accelerometer", filteredColNames$name)
* Replace "Gyro" with "Gyroscope" using filteredColNames$name <- sub("Gyro", "Gyroscope", filteredColNames$name)
* Replace "mean" with "Mean" using filteredColNames$name <- sub("mean", "Mean", filteredColNames$name)
* Replace "std" with "Std" using filteredColNames$name <- sub("std", "Std", filteredColNames$name)
* Remove the periods "." using filteredColNames$name <- gsub("\\.", "", filteredColNames$name)
* Assign the name "subjectId" to the first element using filteredColNames$name[1] <- "subjectId"
* Assign the name "activityId" to the second element using Replace filteredColNames$name[2] <- "activityId"
* Finally assign the filteredColNames information to the x_data data frame column names using colnames(x_data) <- filteredColNames$name

We have here the tidy data with descriptive variable names

### Creating the summarized data

1. Merge the activity names (in the activityNames data frame) to the summarized data (in the x_data data frame) using the activityId variable as a joining field and store it in the new meansGroupedByActivityAndSubject data frame

2. Get rid of the activityId column in the meansGroupedByActivityAndSubject

3. Set the "Group by" field using activity and subjectId columns and store this in the same meansGroupedByActivityAndSubject data frame

4. Use the ddply function with the colwise(mean) parameter to calculate the average (with the mean()) function of all the columns but activity and subjectId. Store this information in the same meansGroupedByActivityAndSubject.

5. Here we have the summarized data frame.

### Writing the x_data and meansGroupedByActivityAndSubject data frames into text files

1. Use the write.table() function to store the data frame into text files

