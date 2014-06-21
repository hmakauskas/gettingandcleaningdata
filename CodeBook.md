## Peer Assessments - CodeBook

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

full description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script attached called run_analysis.R does the following: 

#### 1. Merges the training and the test sets to create one data set.

The script reads (read.table) and then merge (rbind) the data using some temp variables.

* 'train/X_train.txt': Training set.
* 'test/X_test.txt': Test set.

* 'train/y_train.txt': Training labels.
* 'test/y_test.txt': Test labels.

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

By the end of this step the script will have three variables:

* X - Merged data of X
* Y - Merged data of Y
* S - Merged data of subjects

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

* 1. The script reads the features ('features.txt': List of all features).
* 2. Set the header of X data 
* 3. Using the function GREP it extract just the mean and SD features

#### 3. Uses descriptive activity names to name the activities in the data set

* 1. The script reads the activities ('activity_labels.txt': Links the class labels with their activity name).
* 2. Convert activity labels (Y data set) to meaningful names 

#### 4.Appropriately labels the data set with descriptive variable names. 

* 1. Merge partial data sets together (X, Y and S)
* 2. Dump the data set -> "tidy_data_set.txt" (write.table)

#### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

* 1. Using the function aggregate 
    + Data: Select only 3:68 columns
    + Define the group by (activity and subject)
    + Define function mean
* 2. Dump the data set -> "tidy_avgs_data_set.txt" (write.table)