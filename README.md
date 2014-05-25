tidyDataProject
===============

"Getting and Cleaning Data" class project

The goal of this project is to create a tidy data set using data collect from wearable sensors.

The run_analysis.R script
* reads the data from the source files
* adds the subject and activity data to the test and train data frames
* merges the test and training data into one data frame
* creates the desired subset of the data
* resets the activity values to more discriptive labels
* melts the subset so that it can be cast
* casts the melted data to the desired tidy format
* writes the tidy data

