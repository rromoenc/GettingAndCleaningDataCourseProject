**Ricardo Romo Encino**
Getting & Cleanning Data
Data Science Specialization
Coursera - Johns Hopkins University

# Getting and Cleaning Data Course Project

This project takes the "Human Activity Recognition Using Smartphones Dataset" originally from an experiment conducted by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto from the Smartlab - Non Linear Complex Systems Laboratory.

More information in [www.smartlab.ws](www.smartlab.ws).

## The dataset includes the following files:

* ReadMe.md
* Codebook.md: Steps followed to transform the data from the original data set to the new tidy data set
* activity_labels.txt: Performed activities in a tab separated file.
* activity_labels.csv: Performed activities in a comma separated csv file.
* x_data.txt: Accelerometer and Gyroscope information for each activity and each subject in a tab separated text file.
* x_data.csv: Accelerometer and Gyroscope information for each activity and each subject in a comma separated csv file.
* meansGroupedByActivityAndSubject.txt: Accelerometer and Gyroscope information grouped by activity and subject and summarized with the Average (arithmetic mean) in a tab separated text file.
* meansGroupedByActivityAndSubject.csv: Accelerometer and Gyroscope information grouped by activity and subject and summarized with the Average (arithmetic mean) in a comma separated csv file.
* run_analysis.R: R script with the steps to transform the original data sets into the tidy data required for the course project.

## For each record in the x_data files it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. Mean and Std
* Triaxial Angular velocity from the gyroscope. Mean and Std.
* A 79-feature vector with time and frequency domain variables. 
* Its activity id. 
* An identifier of the subject who carried out the experiment.

## For each record in the meansGroupedByActivityAndSubject files it is provided:

* The same columns than the previous file but summarized using the average (arithmetic mean) grouped by Activity and Subject ID

### Notes of the original data set: 

* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the text file.

For more information about the original dataset contact: activityrecognition@smartlab.ws

### References:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
