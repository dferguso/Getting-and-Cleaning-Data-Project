Code Book
=========

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Project Objectives:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The dataset for this project is downloaded from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

See the ReadMe.txt file for a detailed description of the data available

## Variables used in the script
* HARFiles - List the files/folders in the working directory
* reqFilesA - This is a list of the files/folders required in the working directory as per the script below.
* colNames_Act - Specify column names to be used in the activity_labels.txt file - 2 columns
* activity_Labels - Read in the activity_labels files with 6 activities and rename the columns
* newFactors - Specify the descriptive Activity to later replace the activity code
* Features - List of all of the features in the dataset.  This list will later be used for variable names
* reqFilesB - List of files required in each "Test" and "Train" folders - partial names with remaining provided below.
* fType - Specify two types of data: test or train
* df - intialize a data.frame to be used to fill in later
* chkFilesA - build list of files in the current directory - Type dependent
* chkFilesB - build list of required files
* subject - Read in the subject list for the type of data - Test or train
* Xdata - Read in the X_data for the type of data - Test or train
* Ydata - Read in the Y_data for the type of data - Test or train
* colnames - Rename the columns in the X Data
* stdNames - subset of variable names that contains the Standard Deviations for each measurement
* meanNames - subset of variable names that contains the Means for each measurement
** MeanStd_Data - Extracts only the measurements on the mean and standard deviation for each measurement
** AvgTest_Data - Create a tidy data set of the "Test" data calculating Average for each Subject and Activity
** AvgTrain_Data - Create a tidy data set of the "Train" data calculating Average for each Subject and Activity
** AvgAll_TidyData - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Example of Extract of Mean and Standard Deviation Data
  Type Subject Activity tBodyAcc_mean_X tBodyAcc_mean_Y tBodyAcc_mean_Z tBodyAcc_std_X tBodyAcc_std_Y tBodyAcc_std_Z
1 test       2 STANDING       0.2571778     -0.02328523     -0.01465376     -0.9384040     -0.9200908     -0.6676833
2 test       2 STANDING       0.2860267     -0.01316336     -0.11908252     -0.9754147     -0.9674579     -0.9449582
3 test       2 STANDING       0.2754848     -0.02605042     -0.11815167     -0.9938190     -0.9699255     -0.9627480
4 test       2 STANDING       0.2702982     -0.03261387     -0.11752018     -0.9947428     -0.9732676     -0.9670907
5 test       2 STANDING       0.2748330     -0.02784779     -0.12952716     -0.9938525     -0.9674455     -0.9782950

## Example from tidy data containing mean based on Subject and Activity (for Train Data)
Group.2 Group.3 tBodyAcc_mean_X tBodyAcc_mean_Y tBodyAcc_mean_Z tBodyAcc_energy_X tBodyAcc_energy_Y tBodyAcc_energy_Z
1        1  LAYING       0.2215982     -0.04051395     -0.11320355        -0.9835018        -0.9480965        -0.9051668
3        3  LAYING       0.2755169     -0.01895568     -0.10130048        -0.9995937        -0.9990004        -0.9970041
5        5  LAYING       0.2783343     -0.01830421     -0.10793760        -0.9970909        -0.9993656        -0.9983234
6        6  LAYING       0.2486565     -0.01025292     -0.13311957        -0.9795586        -0.9923479        -0.9871041
7        7  LAYING       0.2501767     -0.02044115     -0.10136104        -0.9889896        -0.9941764        -0.9935650
8        8  LAYING       0.2612543     -0.02122817     -0.10224537        -0.9903965        -0.9942456        -0.9829906
11      11  LAYING       0.2805930     -0.01765981     -0.10878658        -0.9994229        -0.9993131        -0.9983302
14      14  LAYING       0.2332754     -0.01134247     -0.08683333        -0.9659790        -0.9910608        -0.9521484
15      15  LAYING       0.2894757     -0.01662965     -0.11853024        -0.9980910        -0.9987910        -0.9878390

## Example from tidy data containing mean based on Subject and Activity (for Test Data)
Group.2 Group.3 tBodyAcc_mean_X tBodyAcc_mean_Y tBodyAcc_mean_Z tBodyAcc_energy_X tBodyAcc_energy_Y tBodyAcc_energy_Z
2        2  LAYING       0.2813734     -0.01815874      -0.1072456        -0.9987127        -0.9996376        -0.9993496
4        4  LAYING       0.2635592     -0.01500318      -0.1106882        -0.9917918        -0.9967508        -0.9972050
9        9  LAYING       0.2591955     -0.02052682      -0.1075497        -0.9912436        -0.9969855        -0.9957236
10      10  LAYING       0.2802306     -0.02429448      -0.1171686        -0.9965301        -0.9927086        -0.9875588
12      12  LAYING       0.2601134     -0.01752039      -0.1081601        -0.9930920        -0.9981953        -0.9942385
13      13  LAYING       0.2767164     -0.02044045      -0.1043319        -0.9979544        -0.9982406        -0.9954781
18      18  LAYING       0.2746916     -0.01739377      -0.1076989        -0.9996819        -0.9998779        -0.9997141
20      20  LAYING       0.2395079     -0.01444063      -0.1042743        -0.9888348        -0.9967323        -0.9973929
24      24  LAYING       0.2728505     -0.01735552      -0.1072362        -0.9983099        -0.9998247        -0.9985426

