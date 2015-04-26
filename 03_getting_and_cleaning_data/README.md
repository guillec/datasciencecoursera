# Getting and Cleaning Data Course Project

### Instructions
You should create one R script called run_analysis.R that does the following:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### Merges the training and the test sets to create one data set:
The merged file can be found here: 

https://github.com/guillec/datasciencecoursera/blob/master/03_getting_and_cleaning_data/merged_datat.txt

This merged file contains all the data in the train and test directories of the data set. It is ordered by activityid and subject. The feature label and activity labels were edited to read easier.

#### Extracts only the measurements on the mean and standard deviation for each measurement.
This extraction occurs in the run_analysis.R script found here:

https://github.com/guillec/datasciencecoursera/blob/master/03_getting_and_cleaning_data/run_analysis.R

Look for the `Extract means and std measurements` section.

#### Uses descriptive activity names to name the activities in the data set
Results can be found in the exported txt files.

#### Appropriately labels the data set with descriptive variable names.
Results can be found in the exported txt files.

#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The tidy data can be found here:

https://github.com/guillec/datasciencecoursera/blob/master/03_getting_and_cleaning_data/mean_of_each_variable.txt
