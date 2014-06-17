## Load the necessary libraries ===============================================
library(stringr)
library(plyr)

## Read in the datasets and description files =================================
trn_set = read.table("./UCI HAR Dataset/train/X_train.txt", sep="")
trn_act = read.table("./UCI HAR Dataset/train/y_train.txt", sep="")
trn_sub = read.table("./UCI HAR Dataset/train/subject_train.txt", sep="")
trn_set = mutate(trn_set, activity=trn_act[,1], subject=trn_sub[,1])

tst_set = read.table("./UCI HAR Dataset/test/X_test.txt", sep="")
tst_act = read.table("./UCI HAR Dataset/test/y_test.txt", sep="")
tst_sub = read.table("./UCI HAR Dataset/test/subject_test.txt", sep="")
tst_set = mutate(tst_set, activity=tst_act[,1], subject=tst_sub[,1])

clabels = read.table("./UCI HAR Dataset/features.txt", sep="", as.is=2)[, 2]
activities = read.table("./UCI HAR Dataset/activity_labels.txt")
names(activities) = c("activity_code", "activity")

## Merge the training and the test sets to create one data set ================
cmb_set = rbind(trn_set, tst_set)

## Label the data set with descriptive variable names =========================
names(cmb_set) = c(clabels, "activity_code", "subject")

## Use descriptive activity names to name the activities in the data set ======
cmb_set = join(cmb_set, activities)
cmb_set = cmb_set[, c(563, 562, 564, 1:561)] # reorder the columns

## Extract only the measurements on the mean and standard deviation ===========
## for each measurement. 
to_keep = c(rep(TRUE, 3), str_detect(clabels, "mean|std"))
cmb_set = cmb_set[, to_keep]

## Create a second, independent tidy data set =================================
## with the average of each variable for each activity and each subject.
avg_set = ddply(cmb_set[, -3], c("activity_code", "subject"), colwise(mean))
avg_set = join(activities, avg_set) # get the discarded activity labels back

## Create (arguably) more readable column labels for the summary dataset ======
lookup = c("f"      ="FrequencyDomain", 
           "t"      ="TimeDomain",
           "Body"   ="Body",
           "Gravity"="Gravity",
           "Gyro"   ="Gyro",
           "Jerk"   ="Jerk",
           "Acc"    ="Acceleration",
           "Mag"    ="Magnitude",
           "mean"   ="Mean",
           "std"    ="StdDev",
           "meanFreq"="FrequencyWeightedAverage",
           "X"      ="Xdirection",
           "Y"      ="Ydirection",
           "Z"      ="Zdirection")

pattern = paste("^(f|t)(Body|Gravity)(?:Body)?(Acc|Gyro)(Jerk)?[-]?(Mag)?[-]?",
                "(mean(?:Freq)?|std)[(][)][-]?([XYZ])?", sep="")

replacements = sapply(
    str_match_all(names(avg_set[-(1:3)]), pattern), function(sm) {
    paste(sapply(sm[-1], function(i) {
        ifelse(i=="", "", lookup[i])}),
        collapse="")})

names(avg_set)[-(1:3)]  <- paste("AverageOf", replacements, sep="")
## Write the summary dataset to csv format ====================================
write.csv(avg_set, "summary.csv")