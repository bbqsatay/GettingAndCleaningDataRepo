run_analysis <-  function() {

	  ## Assume that this script is run in the following directory of the 
	  ## unzipped files "UCI HAR Dataset"

	  ## load libraries
	  library(dplyr)
	  library(reshape2)

	  
	  ## read in test data
	  test_data <- read.table("./test/X_test.txt", header=F)
	  test_subject <- read.table("./test/subject_test.txt",header=F)
	  test_activity <- read.table("./test/y_test.txt", header=F)

	  ## extract only the columns that has to do with mean. Find this 
	  ## column using the file "features.txt"
	  feature <- read.table("features.txt",header=F)

	  ## extract the rows where the word "mean" appears for mean values
	  featureC <- as.character(feature$V2)
	  with_mean <- grep("mean",featureC)

	  ## extract the rows where the word "std" appears for standard deviation
	  ## values
	  with_std <- grep("std",featureC)

	  ## the columns that are of interest to us, mean and standard deviation 
	  ## values
	  columns <- c(with_mean,with_std)


	  ## extract the columns of interest from "./test/X_test.txt"
	  subset_test_data <- test_data[columns]

	  ## extract description name of the columns of interest to us
	  ## in "feature.txt"
	  names <- extract_names(featureC, columns)

	  ## Use the names to label the columns so that it is easy to read
	  colnames(subset_test_data) <- names

	  ## change the column name of subject id.
	  ## Subject id is stored in "./test/subject_test.txt"

	  colnames(test_subject) <- c("subjectId")
	  
	  ## change the column name of activity id.
	  ## Subject id is stored in "./test/y_test.txt"

	  colnames(test_activity) <- c("activity")

	  ## merge test_data with subjectId, activity
	  merged_test_data <- cbind(test_subject, test_activity, subset_test_data)
	  		

	  ## read in train data
	  train_data <- read.table("./train/X_train.txt", header=F)
	  train_subject <- read.table("./train/subject_train.txt",header=F)
	  train_activity <- read.table("./train/y_train.txt", header=F)


	  ## extract the columns of interest from "./train/X_test.txt"
	  subset_train_data <- train_data[columns]

	  ## Use the names to label the columns so that it is easy to read
	  colnames(subset_train_data) <- names

	  ## change the column name of subject id.
	  ## Subject id is stored in "./train/subject_train.txt"

	  colnames(train_subject) <- c("subjectId")
	  
	  ## change the column name of activity id.
	  ## Subject id is stored in "./train/y_train.txt"

	  colnames(train_activity) <- c("activity")

	  ## merge train_data with subjectId, activity
	  merged_train_data <- cbind(train_subject, train_activity, subset_train_data)

	  ## merge the selected test data to train data
	  cleaned_data <- rbind(merged_test_data, merged_train_data)

	  ## group data by subjectId, and then activity
	  cleaned_data <- arrange(cleaned_data, subjectId, activity)

	  ## change the activity to a description name
	  cleaned_data$activity[cleaned_data$activity == 1] <- "walking"
	  cleaned_data$activity[cleaned_data$activity == 2] <- "walking_upstairs"
	  cleaned_data$activity[cleaned_data$activity == 3] <- "walking_downstairs"
	  cleaned_data$activity[cleaned_data$activity == 4] <- "sitting"
	  cleaned_data$activity[cleaned_data$activity == 5] <- "standing"
	  cleaned_data$activity[cleaned_data$activity == 6] <- "laying"

	  ## use "reshape2" library to melt the data
	  melted_data <- melt(cleaned_data, id=c("subjectId","activity"))

	  ## use dcast to get the mean of each feature
	  ## here we assume the long format
	  final_data <- dcast(melted_data, subjectId + activity ~ variable, mean)
 
	  ## write to a text file that is assumed to be created in the same directory
	  write.table(final_data, "tidyData.txt",row.name=FALSE)
} 

extract_names <- function(data,columns) {
	  
	  ## this function will extract the description name of the feature
	  ## based on the input columns that specifies the column name to be
	  ## extracted from input data

	  data2 = c(character())
	  for (i in 1:length(columns)) 
	  {
	  	data2[i] = data[columns[i]] 
	  }
	  return (data2)
}
	
