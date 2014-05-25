## read in the data
testData = read.table("data/UCI HAR Dataset/test/X_test.txt")
yTest = read.table("data/UCI HAR Dataset/test/y_test.txt")
subjTest = read.table("data/UCI HAR Dataset/test/subject_test.txt")
trainData = read.table("data/UCI HAR Dataset/train/X_train.txt")
yTrain = read.table("data/UCI HAR Dataset/train/y_train.txt")
subjTrain = read.table("data/UCI HAR Dataset/train/subject_train.txt")

## add the subject and activity data to the test and train data frames
testData$subject = subjTest$V1
trainData$subject = subjTrain$V1
testData$activity = yTest$V1
trainData$activity = yTrain$V1

## merge the test and training data into one data frame
data = merge(testData, trainData, all=T)

## create a subset of the data
subset = data.frame(data$subject)
colnames(subset)[1] = "subject"
subset$activity = data$activity
subset$tBodyAccMeanX = data$V1
subset$tBodyAccMeanY = data$V2
subset$tBodyAccMeanZ = data$V3
subset$tBodyAccStdX = data$V4
subset$tBodyAccStdY = data$V5
subset$tBodyAccStdZ = data$V6
subset$tGravAccMeanX = data$V41
subset$tGravAccMeanY = data$V42
subset$tGravAccMeanZ = data$V43
subset$tGravAccStdX = data$V44
subset$tGravAccStdY = data$V45
subset$tGravAccStdZ = data$V46
subset$tBodyAccJerkMeanX = data$V81
subset$tBodyAccJerkMeanY = data$V82
subset$tBodyAccJerkMeanZ = data$V83
subset$tBodyAccJerkStdX = data$V84
subset$tBodyAccJerkStdY = data$V85
subset$tBodyAccJerkStdZ = data$V86
subset$tBodyGyroMeanX = data$V121
subset$tBodyGyroMeanY = data$V122
subset$tBodyGyroMeanZ = data$V123
subset$tBodyGyroStdX = data$V124
subset$tBodyGyroStdY = data$V125
subset$tBodyGyroStdZ = data$V126
subset$tBodyGyroJerkMeanX = data$V161
subset$tBodyGyroJerkMeanY = data$V162
subset$tBodyGyroJerkMeanZ = data$V163
subset$tBodyGyroJerkStdX = data$V164
subset$tBodyGyroJerkStdY = data$V165
subset$tBodyGyroJerkStdZ = data$V166
subset$tBodyAccMagMean = data$V201
subset$tBodyAccMagStd = data$V202
subset$tGravAccMagMean = data$V214
subset$tGravAccMagStd = data$V215
subset$tBodyAccJerkMean = data$V227
subset$tBodyAccJerkStd = data$V228
subset$tBodyGyroMagMean = data$V240
subset$tBodyGyroMagStd = data$V241
subset$tBodyGyroJerkMagMean = data$V253
subset$tBodyGyroJerkMagStd = data$V254
subset$fBodyAccMeanX = data$V266
subset$fBodyAccMeanY = data$V267
subset$fBodyAccMeanZ = data$V268
subset$fBodyAccStdX = data$V269
subset$fBodyAccStdY = data$V270
subset$fBodyAccStdZ = data$V271
subset$fBodyAccMeanFreqX = data$V294
subset$fBodyAccMeanFreqY = data$V295
subset$fBodyAccMeanFreqZ = data$V296
subset$fBodyAccJerkMeanX = data$V345
subset$fBodyAccJerkMeanY = data$V346
subset$fBodyAccJerkMeanZ = data$V347
subset$fBodyAccJerkStdX = data$V348
subset$fBodyAccJerkStdY = data$V349
subset$fBodyAccJerkStdZ = data$V350
subset$fBodyAccJerkMeanFreqX = data$V373
subset$fBodyAccJerkMeanFreqY = data$V374
subset$fBodyAccJerkMeanFreqZ = data$V375
subset$fBodyGyroMeanX = data$V424
subset$fBodyGyroMeanY = data$V425
subset$fBodyGyroMeanZ = data$V426
subset$fBodyGyroStdX = data$V427
subset$fBodyGyroStdY = data$V428
subset$fBodyGyroStdZ = data$V429
subset$fBodyGyroMeanFreqX = data$V452
subset$fBodyGyroMeanFreqY = data$V453
subset$fBodyGyroMeanFreqZ = data$V454
subset$fBodyAccMagMean = data$V503
subset$fBodyAccMagStd = data$V504
subset$fBodyAccMagMeanFreq = data$V513
subset$fBodyBodyAccJerkMagMean = data$V516
subset$fBodyBodyAccJerkMagStd = data$V517
subset$fBodyBodyAccJerkMagMeanFreq = data$V526
subset$fBodyBodyGyroMagMean = data$V529
subset$fBodyBodyGyroMagMeanFreq = data$V539
subset$fBodyBodyGyroJerkMagMean = data$V542
subset$fBodyBodyGyroJerkMagMeanFreq = data$V552

## reset the activity values to more discriptive labels
subset$activity[subset$activity == 1] = "WALKING"
subset$activity[subset$activity == 2] = "WALKING_UPSTAIRS"
subset$activity[subset$activity == 3] = "WALKING_DOWNSTAIRS"
subset$activity[subset$activity == 4] = "SITTING"
subset$activity[subset$activity == 5] = "STANDING"
subset$activity[subset$activity == 6] = "LAYING"

## melt the subset
mVars = names(subset)
mVars = mVars[-2]
mVars = mVars[-1]
melted = melt(subset, id=c("subject", "activity"), measure.vars=mVars)

## cast the melted data frame
tidyData = dcast(melted, subject + activity ~ variable, fun.aggregate=mean)

## write the tidy data
write.table(tidyData, "./data/tidyData.txt")

