# JOHNS HOPKINS - Stephane's Getting and Cleaning Data Course Project <br>
## Readme - Scripts description - 2020/04/08 <br>

### Project Description <br>
The purpose of this project is to demonstrate  ability to collect, work with, and clean a data set <br>
he goal is to prepare tidy data that can be used for later analysis. <br>
It is required to submit: <br>
1) a tidy data set below <br>
2) a link to a Github repository with your script for performing the analysis <br>
3) a code book that describes the variables, the data, and any transformations or work performed to clean up the data called CodeBook.md <br>

### Purpose of this document <br>
This repo explains how all of the scripts work and how they are connected. <br>

### PART 1 - Merging Training and Test Sets to create one Data Set <br>
- Setting Working Directory <br>
- Preparing a directory to store data <br>
- Downloading the data files <br>
- Reading X data Files (features, test and training data) <br>
- Creating a new data frame merging test and train data <br>
- updating column names of the dataset with the features names <br>

### PART 2 - Extracts only the measurements on the mean and standard deviation for each measurement.  <br>
- Using grep command combined with metacharacters <br>
- Copying to the data_std_mean dataframe <br>

### PART 3 - Uses descriptive activity names to name the activities in the data set  <br>
- Reading y data Files (activity labels, test and training data) <br>
- Renaming col names <br>
- Assigning activity label to the y merged data set <br>

### PART 4 - Labelling the Dataset<br>
- Adding Subject information data to the data_std_mean DF <br>
- reading subject data and adding subject information to the data_std_mean <br>

### PART 5 - From the data set in step 4, creates a second, independent tidy data set with the average
### of each variable for each activity and each subject <br>
Defining a pipeline going through 2 steps :<br>
- Step 1 - grouping by activity and subject <br>
- Step 2 - calculating mean values for each variables based on groups <br>
Converting the result to data frame foramt <br>
Creating  a csv copy of the dataframe "tidy_dataset.csv"" <br>


