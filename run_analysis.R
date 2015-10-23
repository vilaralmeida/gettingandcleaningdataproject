run_analysis <- function() {
  # Assuming that the Samsung data is in your working directory
  dir <- getwd()

  #test files
  subject_test <- paste(dir,"/test/subject_test.txt",sep="")
  X_test <- paste(dir,"/test/X_test.txt",sep = "")
  Y_test <- paste(dir,"/test/y_test.txt",sep = "")
  #train files
  subject_train <- paste(dir,"/train/subject_train.txt",sep="")
  X_train <- paste(dir,"/train/X_train.txt",sep = "")
  Y_train <- paste(dir,"/train/y_train.txt",sep = "")
  
  #loading the test dataset. 
  subject_testDS <- read.table(subject_test)
  X_testDS <- read.table(X_test)
  Y_testDS <- read.table(Y_test)
  #Creating unique Test Dataset. Loading all dataset as column in one Test tidy dataset.
  testDS <- subject_testDS
  testDS  <- cbind(testDS,X_testDS)
  testDS  <- cbind(testDS,Y_testDS)

  #loading the train dataset. 
  subject_trainDS <- read.table(subject_train)
  X_trainDS <- read.table(X_train)
  Y_trainDS <- read.table(Y_train)
  #Creating unique Train Dataset. Loading all dataset as column in one Train tidy dataset.
  trainDS <- subject_trainDS
  trainDS  <- cbind(trainDS,X_trainDS)
  trainDS  <- cbind(trainDS,Y_trainDS)
  
  # Merges the training and the test sets to create one data set.
  uniqueDS <- testDS
  uniqueDS <- rbind(uniqueDS,trainDS)
  
  
  # Loading features file
  features <- paste(dir,"/features.txt",sep = "")
  featuresDS <- read.table(features)
  # selecting the second column of featuresDS 
  columnNames  <- as.character(featuresDS[,2])
  columnNames  <- c("subject",columnNames,"activities")
  
  # Appropriately labels the data set with descriptive variable names.
  colnames(uniqueDS)  <- columnNames
  
  # Extracts only the measurements on the mean and standard deviation for each measurement.
  selectedColumns <- c("1","563") # selecting subject and activities
  selectedColumns  <- c(selectedColumns,grep("std",columnNames))
  selectedColumns  <- c(selectedColumns,grep("mean",columnNames))
  
  measurementsMeanSTD <- uniqueDS[,as.integer(selectedColumns)]
  
  # Uses descriptive activity names to name the activities in the data set 
  # Loading activity_labels file
  activityLabels <- paste(dir,"/activity_labels.txt",sep = "")
  activityLabelsDS <- read.table(activityLabels)
  # setting the values in measurementsMeanSTD data.frame
  for (i in 1:length(activityLabelsDS[,2])) {
    measurementsMeanSTD$activities[measurementsMeanSTD$activities == i]  <- as.character(activityLabelsDS[i,2]) 
  }
  
 
  # From the data set in step 4, creates a second, independent tidy data set with the 
  # average of each variable for each activity and each subject.
  
  size_subject <- length(unique(measurementsMeanSTD$subject))
  size_activity <- length(unique(measurementsMeanSTD$activities))
  size_columns <- length(colnames(measurementsMeanSTD))
  finalDataFrame <- data.frame()
  for (i in 1:size_subject) {
    measurementSubject <- measurementsMeanSTD[measurementsMeanSTD$subject == i,]
    for (j in 1: size_activity) {
      measurementActivity <- measurementSubject[measurementSubject$activities == activityLabelsDS[,2][j],]
      output <- as.data.frame(i)
      output  <- cbind(output,as.data.frame(as.character(activityLabelsDS[,2][j])))
      for (m in 3:size_columns) {
        output <- cbind(output,as.data.frame(mean(measurementActivity[,m])))  
      }
      finalDataFrame <- rbind(finalDataFrame,output)
    }
  }
  colnames(finalDataFrame)[1] <- "subject"
  colnames(finalDataFrame)[2] <- "activities"
  for (k in 3:size_columns) {
    colnames(finalDataFrame)[k] <- tolower(paste("average",colnames(measurementsMeanSTD)[k],sep=""))
  }
  
  
  # writing output to a table
  outputFile <- paste(dir,"/finalDataFrame.txt",sep="")
  write.table(finalDataFrame, outputFile, row.name=FALSE)
}
