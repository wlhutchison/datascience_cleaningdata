##
##          run_analysis.R
##  
##  Process a set of raw data into a set of tidy data
##
##  Load raw data and organizes it into a tidy data for further analysis and processing
##
## Load supporting libraries
install.packages("dplyr")
library(dplyr)

##
## Load training data
##
train_X <- read.table('UCI_HAR_Dataset/train/X_train.txt', header=F, fill=T)
train_Y <- read.table('UCI_HAR_Dataset/train/Y_train.txt', header=F, fill=T)
##
## Load test data
##
test_X <- read.table('UCI_HAR_Dataset/test/X_test.txt', header=F, fill=T)
test_Y <- read.table('UCI_HAR_Dataset/test/Y_test.txt', header=F, fill=T)
##
## Load features tables
##
features <- read.table('UCI_HAR_Dataset/features.txt', header=F, fill=T)
##
## Load activities
##
activities <- read.table('UCI_HAR_Dataset/activity_labels.txt', header=F, fill=T)
##
## Load subject identifiers
##
train_subjects <- read.table('UCI_HAR_Dataset/train/subject_train.txt', header=F, fill=T)
test_subjects <- read.table('UCI_HAR_Dataset/test/subject_test.txt', header=F, fill=T)

##
## Replace abbreviated variable names with more readable ones
##
features[,"V2"] <- gsub("(BodyBody)", "Body", features[,"V2"] )
features[,"V2"] <- gsub("(Acc)", "Accelerometer", features[,"V2"] )
features[,"V2"] <- gsub("(Gyro)", "Gyroscope", features[,"V2"] )
features[,"V2"] <- gsub("(Mag)", "Magnitude", features[,"V2"] )
features[,"V2"] <- gsub("(-mad\\(\\))", "MedianDeviation", features[,"V2"] )
features[,"V2"] <- gsub("(-sma\\(\\))", "SignalMagnitude", features[,"V2"] )
features[,"V2"] <- gsub("(-max\\(\\))", "Maximum", features[,"V2"] )
features[,"V2"] <- gsub("(-min\\(\\))", "Minimum", features[,"V2"] )
features[,"V2"] <- gsub("(-iqr\\(\\))", "InterquartileRange", features[,"V2"] )
features[,"V2"] <- gsub("(-arCoeff\\(\\))", "AutoRegressionCoeffient", features[,"V2"] )
features[,"V2"] <- gsub("(-maxInds\\(\\))", "FrequencyIndex", features[,"V2"] )
features[,"V2"] <- gsub("(-meanFreq\\(\\))", "MeanFrequency", features[,"V2"] )
features[,"V2"] <- gsub("(-bandsEnergy\\(\\))", "EnergyBands", features[,"V2"] )
features[,"V2"] <- gsub("(-skewness\\(\\))", "FrequencySkewness", features[,"V2"] )
features[,"V2"] <- gsub("(-kurtosis\\(\\))", "FrequencyKurtosis", features[,"V2"] )
features[,"V2"] <- gsub("(-energy\\(\\))", "Energy", features[,"V2"] )
features[,"V2"] <- gsub("(-entropy\\(\\))", "Entropy", features[,"V2"] )
features[,"V2"] <- gsub("(-correlation\\(\\))", "Correlation", features[,"V2"] )
features[,"V2"] <- gsub("(-angle\\(\\))", "Angle", features[,"V2"] )
features[,"V2"] <- gsub("^t", "Time", features[,"V2"])
features[,"V2"] <- gsub("^f", "Frequency", features[,"V2"])
features[,"V2"] <- gsub("\\(t", "\\(Time", features[,"V2"])
features[,"V2"] <- gsub("\\(f", "\\(Frequency", features[,"V2"])
features[,"V2"] <- gsub("-X", "X", features[,"V2"])
features[,"V2"] <- gsub("-Y", "Y", features[,"V2"])
features[,"V2"] <- gsub("-Z", "Z", features[,"V2"])

##
## Isolate the features to include in the tidy data set
##
mean_subset <- features[grep("-mean\\(\\)", features[,"V2"]),"V2"]
std_subset <- features[grep("-std\\(\\)", features[,"V2"]),"V2"]
subset <- c("SubjectID", "Activity", as.vector(mean_subset), as.vector(std_subset))

##
## Final touch-up for the variable names by replacing -mean() and -std()
##
features[,"V2"] <- gsub("(-mean\\(\\))", "Mean", features[,"V2"] )
features[,"V2"] <- gsub("(-std\\(\\))", "StandardDeviation", features[,"V2"] )
features[,"V2"] <- gsub("\\(\\)", "", features[,"V2"])

##
## Need to touch-up the subset too since we used -mean() and -std() to isolate
## the variables we wanted
##
subset <- gsub("(-mean\\(\\))", "Mean", subset )
subset <- gsub("(-std\\(\\))", "StandardDeviation", subset )
subset <- gsub("\\(\\)", "", subset)

##
## Replace the activity values in the test and training data with their
## equivalent activity names
##
test_Y[,1] = factor(test_Y[,1], activities[,1], activities[,2])
train_Y[,1] = factor(train_Y[,1], activities[,1], activities[,2])

##
## Set the column names for the training data, training activty table, and the subjects
##
names(train_X) <- features[,"V2"]
names(train_Y) <- "Activity"
names(train_subjects) <- "SubjectID"

##
## Set the column names for the test data, test activity table, and the subjects
##
names(test_X) <- features[,"V2"]
names(test_Y) <- "Activity"
names(test_subjects) <- "SubjectID"

##
## Construct the training data table by combining the subject IDs with the activities
## and then combining with the results table
##
results <- cbind(train_subjects, train_Y)
train_results <- cbind(results, train_X)

##
## Construct the test data table by combining the subject IDs with the activities
## and then combining with the results table
##
results <- cbind(test_subjects, test_Y)
test_results <- cbind(results, test_X)

##
## Combine the test results data table with the training results data table
##
complete_results <- rbind(train_results, test_results)

##
## Retrieve the column indices for the columns we want to include in the tidy data
##
subset_colIndex <- match(subset, names(complete_results))

##
##  Extract (select) out the desired columns
##
tidy_data <- complete_results[,subset]

##
## Organize the tidy data by SubjectID and then by Activity (desending alphabetically)
##
tidy_data_sorted <- arrange(tidy_data, SubjectID, desc(Activity))

##
##  Compute means for each variable grouped by subjectID and activity
##
tidy_data_by_subject_activity <- group_by(tidy_data_sorted, SubjectID, Activity) %>%
  summarise_each(funs(mean))
View(tidy_data_by_subject_activity)

##
## Save the results
##
write.table(tidy_data_by_subject_activity, file = "tidy_data.txt", sep ="|",
            row.names= FALSE, col.names= TRUE)

