Getting and Cleaning Data Course Project
===================


The **run_analysis.R** performs the following tasks to create a tidy data set from raw data:

> **Note:**

> - Installed and loaded the dplyr library
> - Loaded the training data
>  - normalized data from UCI_HAR_Dataset/train/X_train.txt
>  - activity identifiers from UCI_HAR_Dataset/train/Y_train.txt
>  - subject identifiers from UCI_HAR_Dataset/train/subject_train.txt
> - Loaded the testing data
>  - normalized data from UCI_HAR_Dataset/test/X_test.txt
>  - activity identifiers from UCI_HAR_Dataset/test/Y_test.txt
>  - subject identifiers from UCI_HAR_Dataset/test/subject_test.txt
> - Loaded the features that were collected (that is, the column names for the test and training data by loading the contents of UCI_HAR_Dataset/features.txt.
> - Loaded the activity labels (indexed by the activity identifiers from the Y_train.txt and Y_test.txt files)  from UCI_HAR_Dataset/activity_labels.txt
> - After loading the features labels, processed them to make them more readable.
> - Identified subset of features to be retained by the tidy dataset.
> - Converted activity identifiers (indices) into a human readable activity labels (names)
> - Created training data set by combining the subject identifiers table with the training activity labels table with the training results/measurements table.  All three tables have the same number of rows so logically performed a column combine (cbind).
>  - The first column is the subject identifiers
>  - The second column is activity labels
>  - The remaining 561 columns are the features measurments.
> - Created the testing data set by combining the subject identifiers table with the testing activity labels table with the testing results/measurements table.  All three tables have the same number of rows so logically performed a column combine (cbind).
>  - The first column is the subject identifiers
>   - The second column is activity labels
>   - The remaining 561 columns are the features measurments.
> - Combined the training data set and the test data set, resulting in a comprehensive data set
> - Then extracted (selected out) the desired features identified earlier.  The result was a total of 68 columns:
>  -  33 were -mean() measurements
>  -  33 were -std() measurements
>  -  1 for the subject id
>  -  1 for the activity labels
> - Next, organized the comprehensive data set first by SubjetID (ascending) then by Activity label (descending).
> Finally, performed a group_by on SubjectID and the Activity able (descending) summarizing each of the feature mesurement by computing the mean value.
> #### <i class="icon-hdd"></i> Saved the results
> - Used write.table to store the results in a file tidy_data.txt