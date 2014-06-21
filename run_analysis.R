# Source of data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


# 1. Merges the training and the test sets to create one data set.

local.data.dir <- './UCI HAR Dataset/'

# Read the plain data files

## X ##
tmp1 <- read.table(paste(local.data.dir, 'train/X_train.txt', sep = ""))
tmp2 <- read.table(paste(local.data.dir, 'test/X_test.txt', sep = ""))
X <- rbind(tmp1, tmp2)

## Subject ##
tmp1 <- read.table(paste(local.data.dir, 'train/subject_train.txt', sep = ""))
tmp2 <- read.table(paste(local.data.dir, 'test/subject_test.txt', sep = ""))
S <- rbind(tmp1, tmp2) # Merge the training and test sets

## Y ##
tmp1 <- read.table(paste(local.data.dir, 'train/y_train.txt', sep = ""))
tmp2 <- read.table(paste(local.data.dir, 'test/y_test.txt', sep = ""))
Y <- rbind(tmp1, tmp2) # Merge the training and test sets


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table(paste(local.data.dir, 'features.txt', sep = ""), header = FALSE)
names(features) <- c('id', 'name')
names(X) <- features$name
X <- X[, grep('-mean\\(\\)|-std\\(\\)', features$name)] # Extract just the mean and SD features


# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table(paste(local.data.dir, 'activity_labels.txt', sep = ""), header = FALSE)
names(activity_labels) <- c('id', 'name')
names(Y) <- c('activity')
Y$activity <- activity_labels[Y$activity,]$name

# 4. Appropriately labels the data set with descriptive activity names.
names(S) <- "subject"
tidy.data.set <- cbind(S, Y, X) # Merge partial data sets together
write.table(tidy.data.set, "tidy_data_set.txt") # Dump the data set

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
tidy.avgs.data.set <- aggregate(
  tidy.data.set[, 3:dim(tidy.data.set)[2]], #Select only 3:68 columns
  by = list(tidy.data.set$subject, tidy.data.set$activity), # Define the group by
  FUN=mean # Define function mean
)
write.csv(tidy.avgs.data.set, "tidy_avgs_data_set.txt") # Dump the data set


