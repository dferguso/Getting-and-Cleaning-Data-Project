# Prior to executing the script, define the working directory.
# The working directory should contain the script ("run_analysis.R") and the 
# folder containing the dataset ("UCI HAR Dataset").
# For Example: "./WorkingDirectory/UCI HAR Dataset"
#
# Confirm the working directory contains the necessary Samsung data to perform the analysis.
# List the files/folders in the working directory
HARFiles <- list.files("UCI HAR Dataset")
#
# This is a list of the files/folders required in the working directory as per the script below.
reqFilesA<-c("features.txt", "activity_labels.txt" , "test", "train")
#
# If the required files/folders are not present stop the script and warn the user.
if (!all(reqFilesA %in% HARFiles)){
    stop("Confirm working directory contains the appropriate files")
}
# Remove uneeded variables
rm(HARFiles, reqFilesA)

# 
# Obtain a list of Activities
# Specify column names to be used in the activity_labels.txt file - 2 columns
colNames_Act<-c("Act_ID", "ACTIVITY")
#
# Read in the activity_labels files with 6 activities and rename the columns
activity_Labels<-read.table("UCI HAR Dataset/activity_labels.txt",col.names=colNames_Act)
#
# Specify the descriptive Activity to later replace the activity code
newFactors<-factor(activity_Labels[,2])
#
# Remove uneeded variables
rm(colNames_Act)
#

# List of all of the features in the dataset.  This list will later be used for variable names
Features<-read.table("UCI HAR Dataset/features.txt")
Features<-gsub("\\()-","_",as.character(Features[,2]))
Features<-gsub("-","_",Features)
#
# List of files required in each "Test" and "Train" folders - partial names with remaining provided below.
reqFilesB<-c("subject_", "X_", "y_")
# Specify two types of data: test or train
fType=c("test","train")
#
# intialize a data.frame to be used to fill in later
df<-data.frame(stringsAsFactors = FALSE)
#
# Loop through each Type of data: test or train
for (ft in fType){
    chkFilesA<-list.files(paste("UCI HAR Dataset/",ft,sep="")) # build list of files in the current directory - Type dependent
    chkFilesB<-paste(reqFilesB,ft,".txt",sep="") # build list of required files
    if (!all(chkFilesB %in% chkFilesA)){  # Confirm required files are present or stop
        stop("Confirm working directory contains the appropriate files")
    }
    #
    # Read in the subject list for the type of data - Test or train
    subject<-read.table(paste("UCI HAR Dataset/",ft,"/subject_",ft,".txt",sep=""))
    # Read in the X_data for the type of data - Test or train
    Xdata<-read.table(paste("UCI HAR Dataset/",ft,"/X_",ft,".txt",sep=""))
    # Read in the y_data for the type of data - Test or train
    Ydata<-read.table(paste("UCI HAR Dataset/",ft,"/y_",ft,".txt",sep=""))
    # 3. Uses descriptive activity names to name the activities in the data set
    Ydata$Activity<-newFactors[match(Ydata$V1,activity_Labels[,1])]
    # Rename the columns in the X Data
    colnames(Xdata)<-Features
    # Add columns for Type (test/Train), Subject, Activity to the X Data
    Xdata<-cbind(Type=ft, Subject = subject[,1], Ydata[,2],Xdata )
    # 1. Merges the training and the test sets to create one data set.
    df<-rbind(df,Xdata)
}
# Rename column 3 in data frame using descriptive name
names(df)[3] <- "Activity"

#
# Generate a list of column names that have "std". This will be used to extract 
# Standard Deviations for each measurement
stdNames<-subset(Features,grepl("std",Features))
# Generate a list of column names that have "mean". This will be used to extract 
# Means for each measurement
meanNames<-subset(Features,grepl("mean",Features))
#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
meanStd_Data<-cbind(df[,1:3],df[,meanNames],df[,stdNames])
# Remove uneeded variables
rm(chkFilesA, chkFilesB, fType, ft, newFactors, reqFilesB)
rm(Features, Xdata, Ydata, subject, activity_Labels)
rm(meanNames, stdNames)

# 4. Appropriately labels the data set with descriptive variable names.
# Create a tidy data set of the "Test" data calculating Average for each Subject and Activity 
AvgTest_Data<-aggregate(df[,4:ncol(df)], by=list(df$Type=="test", df$Subject, df$Activity),FUN = mean)
indx<-AvgTest_Data$Group.1==TRUE
AvgTest_Data<-AvgTest_Data[indx,]
#
# Create a tidy data set of the "Train" data calculating Average for each Subject and Activity
AvgTrain_Data<-aggregate(df[,4:ncol(df)], by=list(df$Type=="train", df$Subject, df$Activity),FUN = mean)
indx<-AvgTrain_Data$Group.1==TRUE
AvgTrain_Data<-AvgTrain_Data[indx,]
#
# 5. Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
AvgAll_TidyData<-aggregate(df[,4:ncol(df)], by=list(df$Type, df$Subject, df$Activity),FUN = mean)
# Write table to file
write.table(AvgAll_TidyData,"ActivitySubject_Avg.txt", row.names = FALSE)
   

