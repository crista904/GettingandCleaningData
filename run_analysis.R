### 1. Merges the training and the test sets to create one data set. 

#Set working directory

setwd("filepathhere")

#Import all data and label columns
#Note: Column names must match for rbind later

activity_labels <- read.table("./activity_labels.txt",header=FALSE)
colnames(activity_labels)<-c("ActivityID","Activity")

features <- read.table("./features.txt",header=FALSE)

subject_test <- read.table("./test/subject_test.txt",header=FALSE)
colnames(subject_test) <- "Id"

X_test <- read.table("./test/X_test.txt",header=FALSE)
colnames(X_test) <- features[,2]

y_test <- read.table("./test/y_test.txt",header=FALSE)
colnames(y_test) <- "ActivityID"

subject_train <- read.table("./train/subject_train.txt",header=FALSE)
colnames(subject_train) <- "Id"

X_train <- read.table("./train/X_train.txt",header=FALSE)
colnames(X_train) <- features[,2]

y_train <- read.table("./train/y_train.txt",header=FALSE)
colnames(y_train) <- "ActivityID"

#bind all data together to create one big matrix

test_data <- cbind(y_test, subject_test, X_test)
train_data <- cbind(y_train, subject_train, X_train)

merged_data <- rbind(train_data, test_data)

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

#create a vector of all column names then extract only the mean and std

column_names <- colnames(merged_data)

data_mean_std <-merged_data[,grepl("mean|std|subject|ActivityID|Id",colnames(merged_data))]

### 3. Uses descriptive activity names to name the activities in the data set

data_mean_std$ActivityID <- activity_labels[data_mean_std$ActivityID,2]

### 4. Step 4: Appropriately labels the data set with descriptive variable names.

names(data_mean_std)[2] = "activity"
names(data_mean_std)<-gsub("Acc", "Accelerometer", names(data_mean_std))
names(data_mean_std)<-gsub("Gyro", "Gyroscope", names(data_mean_std))
names(data_mean_std)<-gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std)<-gsub("Mag", "Magnitude", names(data_mean_std))
names(data_mean_std)<-gsub("^t", "Time", names(data_mean_std))
names(data_mean_std)<-gsub("^f", "Frequency", names(data_mean_std))
names(data_mean_std)<-gsub("tBody", "TimeBody", names(data_mean_std))
names(data_mean_std)<-gsub("-mean()", "Mean", names(data_mean_std), ignore.case = TRUE)
names(data_mean_std)<-gsub("-std()", "STD", names(data_mean_std), ignore.case = TRUE)
names(data_mean_std)<-gsub("-freq()", "Frequency", names(data_mean_std), ignore.case = TRUE)
names(data_mean_std)<-gsub("angle", "Angle", names(data_mean_std))
names(data_mean_std)<-gsub("gravity", "Gravity", names(data_mean_std))

### 5. Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Final_Data <- data_mean_std %>%
  group_by(ActivityID, activity) %>%
  summarise_all(list(mean))

### Write final data to text file for viewing

write.table(Final_Data, "Final_Data.txt", row.name=FALSE)
