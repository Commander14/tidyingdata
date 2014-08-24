analyzeData <- function() {
    # Load all of the applicable files
    base <- "UCI HAR Dataset"
    trainX <- read.table(paste(base, "/train/X_train.txt", sep=""))
    testX <- read.table(paste(base, "/test/X_test.txt", sep=""))
    features <- read.table(paste(base, "/features.txt", sep=""))
    activities <- read.table(paste(base, "/activity_labels.txt", sep=""))
    testY <- read.table(paste(base, "/test/y_test.txt", sep=""))
    trainY <- read.table(paste(base, "/train/y_train.txt", sep=""))
    subjectsTest <- read.table(paste(base, "/test/subject_test.txt", sep=""))
    subjectsTrain <- read.table(paste(base, "/train/subject_train.txt", sep=""))

    # pull out the features to make the column names proper
    # this is the raw data for the standard deviations and the medians
    cnames <- features[,2]
    colnames(testX) <- cnames
    colnames(trainX) <- cnames

    # insert the activities into a column in the raw data for both datasets
    testX <- cbind(testY, testX)
    trainX <- cbind(trainY, trainX)
    colnames(testX)[1] <- colnames(trainX)[1] <- "Activity"

    # insert the subjects into a column in the raw data for both data sets
    testX <- cbind(subjectsTest, testX)
    trainX <- cbind(subjectsTrain, trainX)
    colnames(testX)[1] <- colnames(trainX)[1] <- "Subjects"

    # replace the numbers (1-6) with strings describing the activities (eg: WALKING)
    trainX[,2] <- factor(as.vector(trainX[[2]]), levels=c(1, 2, 3, 4, 5, 6), labels=as.vector(activities[[2]]))
    testX[,2] <- factor(as.vector(testX[[2]]), levels=c(1, 2, 3, 4, 5, 6), labels=as.vector(activities[[2]]))

    # reduce down to just the columns we need by grepping out anything that has mean() or std() in it
    # also keep the subjects and activity columns
    trainX <- trainX[c(grep("mean\\(\\)|std\\(\\)|Subjects|Activity", colnames(trainX)))]
    testX <- testX[c(grep("mean\\(\\)|std\\(\\)|Subjects|Activity", colnames(testX)))]
    
    # combine the two tables into one by appending rows onto trainX
    data <- rbind(trainX, testX)
    
    # make the tidy data, grouping by each subject and their activity and averaging the columns for those
    # eg Subject 1 WALKING happens X times, so Subject 1 WALKING will be in this once will the value in each column
    # being the average for all activity of that subject for that activity
    tidyData <- aggregate(data, by=list(data[,1], data[,2]), FUN=mean, na.rm=TRUE, simplify=TRUE)

    # remove the duplicate columns that resulted from the aggregate call
    tidyData$activity <- NULL
    tidyData$subjects <- NULL

    # rename the columns to be accurate
    colnames(tidyData)[1] <- "Subject"
    colnames(tidyData)[2] <- "Activity"
    
    # write out the final tidy output to the TTY
    write.table(tidyData,row.name=FALSE)
}
