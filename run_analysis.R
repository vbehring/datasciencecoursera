library(dplyr)
test <- read.table("./UCI HAR Dataset/features.txt")
headerF <- test[,2]
subjects_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Subject")
testDS <- read.table("./UCI HAR Dataset/test/X_test.txt",col.names = headerF)
temp <- subjects_test[,1]
testDS$subject <- temp

subjects_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Subject")
trainDS <- read.table("./UCI HAR Dataset/train/X_train.txt",col.names = headerF)
temp <- subjects_train[,1]
trainDS$subject <- temp

mergeDS <- merge(testDS,trainDS, all=TRUE)

extract_features <- grepl("mean|std", headerF)
meanstdDS = mergeDS[,extract_features]

tidy <-meanstdDS %>% group_by(subject) %>% summarise_each(funs(mean))

write.table(tidy,"tidy.txt", row.names=FALSE)