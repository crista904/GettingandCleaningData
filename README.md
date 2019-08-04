# GettingandCleaningData
Week 4 Assignment


I have created an R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
  - Input data into R (read.table()) and name all columns (colnames())
  - Bind test data and train data columns separtately using cbind()
  - Bind all test and train data rows using rbind()
2. Extracts only the measurements on the mean and standard deviation for each measurement.
  - Create a list of all column names
  - Extract all columns that contain mean and std using grepl()
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
  - Use gsub() to change names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  - Use groupby(), summarize_all() and mean() functions
