# README file for course project Getting and Cleaning Data Course Project
# https://class.coursera.org/getdata-033/human_grading/view/courses/975117/assessments/3/submissions

## Assumptions

1. The dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
is unzipped into a directory using the default settings.

2. The script, run_analysis.R, is run in the directory, 'UCI HAR Dataset'

## The following steps were carried out in the run_analysis.R script.

### Process Test Data

1. Read in the test data that is found in "UCI HAR Dataset/test/X_test.txt". This contains the 
test set (i.e the measurements of each subject and each activity)

2. Read in the data that is found in "UCI HAR Dataset/test/subject_test.txt". Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

3. Read in the data that is found in "UCI HAR Dataset/test/y_test.txt". This contains the Test labels, indicating the type of activity for each measurement in the test set.

4. We are interested in only measurements on the mean and standard deviation for each measurement.
 
	a. To find this, we make use of the information in "features.txt".

	b, I read in the data, converted the feature name to a character string, before choosing the 
	columns which contains "mean" and "std". (Note: I have assumed that all mean and std deviations
	have the word "mean" and "std" in the naming. I decided at this point to keep the names AS IS so 
	that it is easy to match back to the description in "features.txt". (I could have chosen to 
	simplify the names by removing the '-','_' and '()', but chose not to).
	

5. Using information obtained in (4), I extracted only the required columns from the test data in (1).

6. As the test data from (1) has no column names, I then rename the columns with the descriptive name extracted from "features.txt".

7. Taking the subject name data from (2), I added the column name of "activity". (Note: data has 1 column)

8. Taking the activity data from (3), I added the column name of "subjectId". (Note: data has 1 column)

9. I merged the three set of data using cbind. (subject data, activity data and test data in this sequence)


### Process Train Data

I repeated the above process with the Train Data. The train data are stored in:
- "UCI HAR Dataset/test/X_train.txt" - stores train data
- "UCI HAR Dataset/test/subject_train.txt" - stores related subject data
- "UCI HAR Dataset/test/y_train.txt" - stores related activity data


## Merge the test data with the train data

I then merge both set of data using rbind.


## Group and rename the activity

1. I first arrange the data by subjectId, and then activity

2. I then rename the activity column with the descriptive names taken from "activity_labels.txt".
This naming is hardcoded in the script.


## From the merged test & train data, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. Use "reshape2" library

2. First, use melt to organize the data by 'subjectId' and 'activity'

3. Then use dcast to find the mean of each feature. I used the long format.


## Finally create a text file containing the tidy data set after analysis.

1. File called "tidyData.txt" is created in the same working directory "UCI HAR Dataset". This is created using write.table.


## Helper function

There is a helper function called "extract_names". This function will extract the description name of 
the feature based on the input columns that specifies the column name to be extracted from input data.



Thank you for reading this !

 