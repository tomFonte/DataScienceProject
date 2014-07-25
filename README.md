DataScienceProject
==================
 The Script in this repo is to be used for the course Project of Getting and Cleaning Data for the Data Science Coursera Specialization. 
 The datasets involved wher eprovided by the course, for studying the wearability of Samsung portable phones.  
 To construct a workable dataset, I followed the following steps:  
 * rbind train and test data sets, the matrix with 561, label matrix and subject matrix 
 * Obtain the columns of interest (those of mean and standard deviation, including mean Frequencies) by subsetting the matrix with 561 columns using the function grepl 
 * Factorized the label matrix to obtain the labels instead of the code. 
 * Decode the label matrix. 
 * cbind subject and label to dataset. 
 * named the variables in the resulting dataset. 
 * Used aggregate function to create Tidy data set (I dropped subject and label variables, as were duplicated by this function using Tidy[,-c(3,4)]) 
 * renamed the variables.
 * Write the Tidy table in the working directory naming it "TidyData.txt"
