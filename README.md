# README
# This REPO contains the run_analysis code that was implemented to solve the following questions:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To solve the question, I've followed this steps, as described in run_analysis function:
- I've assumed that the Samsung data is in your working directory
- Build three test files (subject_test, X_test and Y_test)
- Build three train files (subject_train, X_train and Y_train)
- With the above files I've created unique Test Dataset. Loading all dataset as column in one Test tidy dataset (called testDS)
- With the above files I've created unique train Dataset. Loading all dataset as column in one train tidy dataset (called trainDS)
- Merges the training and the test sets to create one data set (called uniqueDS)
- I've selected the second column of featuresDS to build the columnNames (line 42)
- Extracts only the measurements on the mean and standard deviation for each measurement (selectedColumns)
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (called finalDataFrame)
- rename the columns through "tolower" function and adding "average" label to make the lecture easier.
- Write the table to file finalDataFrame.txt
