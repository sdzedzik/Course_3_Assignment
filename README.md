# Course_3_Assignment
Peer-graded Assignment: Getting and Cleaning Data Course Project
===============
This script transforms the initial data given into the table of average values calculated for the combination of Subject ID and Type of Activity

This script highly relies on dplyr package, which you can install typing *install.packages("dplyr")* into the R console.

The script does the following tasks:
1. Creates working directory and downloads the file there
2. Loads all the tables necessary for further data manipulation
3. Merges the training and the test sets to create one data set, all while deleting obsolete tables from the environment
4. Cleans the data, appropriately labeling the data set with descriptive variable names and modifying the names (deleting parentheses, renaming duplicates etc). More on that is in the *CodeBook.md* file.
5. Changes factor activity names into descriptive ones
6. Extracts only the measurements on the mean and standard deviation for each measurement.
7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
