
#Read in the data for features and x,y data from train and test sets.
features <- read.table('C:/Users/E/Desktop/RCoursera/Project_DataCleaning/UCI_HAR_Dataset/features.txt')
trainData <- read.table('C:/Users/E/Desktop/RCoursera/Project_DataCleaning/UCI_HAR_Dataset/train/X_train.txt')
trainLabels <- read.table('C:/Users/E/Desktop/RCoursera/Project_DataCleaning/UCI_HAR_Dataset/train/y_train.txt')
testData <- read.table('C:/Users/E/Desktop/RCoursera/Project_DataCleaning/UCI_HAR_Dataset/test/X_test.txt')
testLabels <- read.table('C:/Users/E/Desktop/RCoursera/Project_DataCleaning/UCI_HAR_Dataset/test/y_test.txt')
trainSubjects <- read.table('C:/Users/E/Desktop/RCoursera/Project_DataCleaning/UCI_HAR_Dataset/train/subject_train.txt')
testSubjects <- read.table('C:/Users/E/Desktop/RCoursera/Project_DataCleaning/UCI_HAR_Dataset/test/subject_test.txt')

#Combine the subject, y-label and x-data for test and train sets columnarly.
testSet <- cbind(testSubjects, testLabels, testData)
trainSet <- cbind(trainSubjects, trainLabels, trainData)

#Combine the test and train sets row-wise to create the full set
fullSet <- rbind(trainSet, testSet)

#Get the subset of the labels (the second column)
labels <- subset(features, select="V2")

#Set create data frames for the subject and y labels.
y_label <- data.frame("Y_var")
subject_label <- data.frame("subject")

#Rename the columns (necessary to use rbind with the labels dataframe)
colnames(y_label) <- c("V2")
colnames(subject_label) <- c("V2")

#Bind together all the labels.
labels <- rbind(subject_label, y_label, labels)

#Assign the column names to the data set.
colnames(fullSet) <- labels$V2

#Grep out the columns that contain means and stdevs
stdevs <- fullSet[, grep("std()", names(fullSet), value=TRUE, fixed=TRUE)]
means <- fullSet[, grep("mean()", names(fullSet), value=TRUE, fixed=TRUE)]

#Use cbind to put together the first two columns with the mean and stdevs
filteredData <- cbind(fullSet[, c(1,2)], means, stdevs)

#Assign correct names to the column of activity labels.
filteredData$Y_var[filteredData$Y_var == "1"] <- "WALKING"
filteredData$Y_var[filteredData$Y_var == "2"] <- "WALKING_UPSTAIRS"
filteredData$Y_var[filteredData$Y_var == "3"] <- "WALKING_DOWNSTAIRS"
filteredData$Y_var[filteredData$Y_var == "4"] <- "SITTING"
filteredData$Y_var[filteredData$Y_var == "5"] <- "STANDING"
filteredData$Y_var[filteredData$Y_var == "6"] <- "LAYING"

#Use the aggregate function on the data set.
#Aggregate by subject and filter, on the columns for mean and std.
finalData <- aggregate(filteredData[,3:ncol(filteredData)], by=list(subject = filteredData$subject, 
                                    label = filteredData$Y_var), FUN=mean)

#Write the ouput to a file in the directory where the script is stored.
#This is written with the default spacing in the file of " "
write.table(finalData, file = 'C:/Users/E/Desktop/RCoursera/Project_DataCleaning/output.txt')
