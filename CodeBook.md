Data Set Information
----------------------

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


Transformations or work that performed to clean up the data
------------------------------------------------------------------
#Download zip file from given link fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')

#unzip it to designated folder
unzip("UCI HAR Dataset.zip", exdir = getwd())

#Read features and convert it into a single data frame
feat <- as.character(feat[,2])
datax <- read.table('./UCI HAR Dataset/train/X_train.txt')
activitydata <- read.csv(./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
activitydata <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
subjectdata <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')
datat <- data.frame(subjectdata,activitydata,datax)
names(datat) <- c(c('subject', 'activity'), feat))
names(datat) <- c(c('subject', 'activity'), feat)
testdata <- read.table('./UCI HAR Dataset/test/X_test.txt')
testactivity <-read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
testsubject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')
datatest <- data.frame
datatest <- data.frame(testsubject,testactivity,testdata)
names(datatest) <- c(c('subject', 'activity'), feat)

#Merges all data into one dataset
alldata <- rbind(datat,datatest)

#Extraction of Mean and standard deviation for each measurement.
mean_std <- grep('mean|std', feat)
datas <- alldata[,c(1,2,mean_std + 2)]

#Name the activities in the data set
labelactivity <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
labelactivity <- as.character(labelactivity[,2])
data.sub$activity <- labelactivity[data.sub$activity]
datas$activity <- labelactivity[datas$activity]

#labeling the data set with descriptive variable names
name.new <- names(datas)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(datas) <- name.new

#independent tidy data set with the average of each variable for each activity and each subject.
tidydata <-  aggregate(datas[,3:81], by = list(activity = datas$activity, subject = datas$subject),FUN = mean)
write.table(x = tidydata, file = "tidydata.txt", row.names = FALSE)


### Variable Descriptions


| Variable | Description
-----------|-------------
| activities | The activity performed
| subject | Subject ID
| tbodyacc-mean-x | Mean time for acceleration of body for X direction
| tbodyacc-mean-y | Mean time for acceleration of body for Y direction
| tbodyacc-mean-z | Mean time for acceleration of body for Z direction
| tbodyacc-std-x | Standard deviation of time for acceleration of body for X direction
| tbodyacc-std-y | Standard deviation of time for acceleration of body for Y direction
| tbodyacc-std-z | Standard deviation of time for acceleration of body for Z direction
| tgravityacc-mean-x | Mean time of acceleration of gravity for X direction
| tgravityacc-mean-y | Mean time of acceleration of gravity for Y direction
| tgravityacc-mean-z | Mean time of acceleration of gravity for Z direction
| tgravityacc-std-x | Standard deviation of time of acceleration of gravity for X direction
| tgravityacc-std-y | Standard deviation of time of acceleration of gravity for Y direction
| tgravityacc-std-z | Standard deviation of time of acceleration of gravity for Z direction
| tbodyaccjerk-mean-x | Mean time of body acceleration jerk for X direction
| tbodyaccjerk-mean-y | Mean time of body acceleration jerk for Y direction
| tbodyaccjerk-mean-z | Mean time of body acceleration jerk for Z direction
| tbodyaccjerk-std-x | Standard deviation of time of body acceleration jerk for X direction
| tbodyaccjerk-std-y | Standard deviation of time of body acceleration jerk for Y direction
| tbodyaccjerk-std-z | Standard deviation of time of body acceleration jerk for Z direction
| tbodygyro-mean-x | Mean body gyroscope measurement for X direction
| tbodygyro-mean-y | Mean body gyroscope measurement for Y direction
| tbodygyro-mean-z | Mean body gyroscope measurement for Z direction
| tbodygyro-std-x | Standard deviation of body gyroscope measurement for X direction
| tbodygyro-std-y | Standard deviation of body gyroscope measurement for Y direction
| tbodygyro-std-z | Standard deviation of body gyroscope measurement for Z direction
| tbodygyrojerk-mean-x | Mean jerk signal of body for X direction
| tbodygyrojerk-mean-y | Mean jerk signal of body for Y direction
| tbodygyrojerk-mean-z | Mean jerk signal of body for Z direction
| tbodygyrojerk-std-x | Standard deviation of jerk signal of body for X direction
| tbodygyrojerk-std-y | Standard deviation of jerk signal of body for Y direction
| tbodygyrojerk-std-z | Standard deviation of jerk signal of body for Z direction
| tbodyaccmag-mean | Mean magnitude of body Acc
| tbodyaccmag-std | Standard deviation of magnitude of body Acc
| tgravityaccmag-mean | Mean gravity acceleration magnitude
| tgravityaccmag-std | Standard deviation of gravity acceleration magnitude
| tbodyaccjerkmag-mean | Mean magnitude of body acceleration jerk
| tbodyaccjerkmag-std | Standard deviation of magnitude of body acceleration jerk
| tbodygyromag-mean | Mean magnitude of body gyroscope measurement
| tbodygyromag-std | Standard deviation of magnitude of body gyroscope measurement
| tbodygyrojerkmag-mean | Mean magnitude of body body gyroscope jerk measurement
| tbodygyrojerkmag-std | Standard deviation of magnitude of body body gyroscope jerk measurement
| fbodyacc-mean-x | Mean frequency of body acceleration for X direction
| fbodyacc-mean-y | Mean frequency of body acceleration for Y direction
| fbodyacc-mean-z | Mean frequency of body acceleration for Z direction
| fbodyacc-std-x | Standard deviation of frequency of body acceleration for X direction
| fbodyacc-std-y | Standard deviation of frequency of body acceleration for Y direction
| fbodyacc-std-z | Standard deviation of frequency of body acceleration for Z direction
| fbodyaccjerk-mean-x | Mean frequency of body accerlation jerk for X direction
| fbodyaccjerk-mean-y | Mean frequency of body accerlation jerk for Y direction
| fbodyaccjerk-mean-z | Mean frequency of body accerlation jerk for Z direction
| fbodyaccjerk-std-x | Standard deviation frequency of body accerlation jerk for X direction
| fbodyaccjerk-std-y | Standard deviation frequency of body accerlation jerk for Y direction
| fbodyaccjerk-std-z | Standard deviation frequency of body accerlation jerk for Z direction
| fbodygyro-mean-x | Mean frequency of body gyroscope measurement for X direction
| fbodygyro-mean-y | Mean frequency of body gyroscope measurement for Y direction
| fbodygyro-mean-z | Mean frequency of body gyroscope measurement for Z direction
| fbodygyro-std-x | Standard deviation frequency of body gyroscope measurement for X direction
| fbodygyro-std-y | Standard deviation frequency of body gyroscope measurement for Y direction
| fbodygyro-std-z | Standard deviation frequency of body gyroscope measurement for Z direction
| fbodyaccmag-mean | Mean frequency of body acceleration magnitude
| fbodyaccmag-std | Standard deviation of frequency of body acceleration magnitude
| fbodybodyaccjerkmag-mean | Mean frequency of body acceleration jerk magnitude
| fbodybodyaccjerkmag-std | Standard deviation of frequency of body acceleration jerk magnitude
| fbodybodygyromag-mean | Mean frequency of magnitude of body gyroscope measurement
| fbodybodygyromag-std | Standard deviation of frequency of magnitude of body gyroscope measurement
| fbodybodygyrojerkmag-mean | Mean frequency of magnitude of body gyroscope jerk measurement
| fbodybodygyrojerkmag-std | Standard deviation frequency of magnitude of body gyroscope jerk measurement