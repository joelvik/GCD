## Script for Getting and Cleaning Data


# Download zip file from given link and unzip it to designated folder
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}

#Reads features and converts it into a single data frame
feat <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
feat <- as.character(feat[,2])
datax <- read.table('./UCI HAR Dataset/train/X_train.txt')
activitydata <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
subjectdata <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

datat <- data.frame(subjectdata,activitydata,datax)
names(datat) <- c(c('subject', 'activity'), feat)


testdata <- read.table('./UCI HAR Dataset/test/X_test.txt')
testactivity <-read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
testsubject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')



datatest <- data.frame(testsubject,testactivity,testdata)
names(datatest) <- c(c('subject', 'activity'), feat)

#Merges all data into one dataset
alldata <- rbind(datat,datatest)

##Extraction of Mean and standard deviation for each measurement.
mean_std <- grep('mean|std', feat)
datas <- alldata[,c(1,2,mean_std + 2)]

#Name the activities in the data set

labelactivity <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
labelactivity <- as.character(labelactivity[,2])
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