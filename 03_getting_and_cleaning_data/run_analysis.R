library(dplyr)

# run_analysis.R
#
# Instructions:
# 1. Set your working directory correctly. 
#   - To run this script your working directory should be the same as the path to this script.
# 2. Make sure you have dyplr library installed.

# Read activity_labels.txt file
# Each row of this file contains an id and activity labels 
# that describes a certain activity (for example walking).
#
# Example of data in the file: 
# 1 Walking
activity_labels <- read.table('./Dataset/activity_labels.txt')

# Read features.txt
# Contains full id and labels of features
features <- read.table('./Dataset/features.txt')

####################################
# TRAIN GROUP FILES
####################################

# Read in subject_train.txt file
# Each row identifies the subject who performed the activity 
# for each window sample.
train_subjects <- read.table('./Dataset/train/subject_train.txt')

# Read in X_train.txt file
# Contains the full test set for the train group.
train_data <- read.table('./Dataset/train/X_train.txt')
# Change column names to feature names
colnames(train_data) <- features$V2

# Read in y_train.txt file
# Each row is an id that links to an activity_label
train_labels <- read.table('./Dataset/train/y_train.txt')

# Add train labels to train_data
train_data["activityid"] <- train_labels

# Add train subjects to train_data
train_data["subject"] <- train_subjects

####################################
# TEST GROUP FILES
####################################

# Read in subject_test.txt file
# Each row identifies the subject who performed the activity 
# for each window sample.
test_subjects <- read.table('./Dataset/test/subject_test.txt')

# Read in X_test.txt file
# Contains the full test set for the test group.
test_data <- read.table('./Dataset/test/X_test.txt')
# Change column names to feature names
colnames(test_data) <- features$V2

# Read in y_test.txt file
# Each row is an id that links to an activity_label
test_labels <- read.table('./Dataset/test/y_test.txt')

# Add test labels to test_data
test_data["activityid"] <- test_labels

# Add test subjexts to test_data
test_data["subject"] <- test_subjects

####################################
# Merging and Manipulating Files
####################################

# Append test_data to train_data
all_data <- rbind(test_data, train_data)

# Combine and order the data by subject and activity label
combined_data_set <- all_data[with(all_data, order(all_data$activityid, all_data$subject)), ]

# Rename activity id to the actual label
labeled_activities <- activity_labels$V2[combined_data_set$activity]

combined_data_set["activitylabel"] <- labeled_activities

####################################
# Clean up feature label names
####################################

better_features <- gsub("_", "", colnames(combined_data_set))
better_features <- gsub("fBody", "frequencyBody", better_features)
better_features <- gsub("frequencyBodyBody", "frequencyBody", better_features)
better_features <- gsub("tBody", "timeBody", better_features)
better_features <- gsub("tGravity", "timeGravity", better_features)
better_features <- gsub("Acc", "Accelerometer", better_features)
better_features <- gsub("Gyro", "Gyroscope", better_features)
better_features <- gsub("Mag", "Magnitude", better_features)
better_features <- gsub("Freq", "Frequency", better_features)
better_features <- gsub("mean", "Mean", better_features)
better_features <- gsub("std", "Std", better_features)
better_features <- gsub("\\(", "", better_features)
better_features <- gsub("\\)", "", better_features)
better_features <- gsub("-", "", better_features)
better_features <- gsub("angle", "averageSignalBetween", better_features)
better_features <- gsub(",", "And", better_features)
better_features <- gsub("gravity", "Gravity", better_features)

# Rename colnames with better labels
names(combined_data_set) <- better_features

# Export table to txt without rownames
write.table(combined_data_set, './merged_datat.txt', row.names=FALSE)

####################################
# Extract means and std measurements
####################################

# Extracts only the measurements on the mean and standard deviation for each measurement.
mean_and_std <- combined_data_set[,grepl(".*([Mm]ean|[Ss]td|[Aa]ctivitylabel|[Ss]ubject).*", names(combined_data_set))]

# Table with the mean of each table column
mean_of_columns <- mean_and_std %>% group_by(subject, activitylabel) %>% summarise_each(funs(mean))