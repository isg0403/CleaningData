library(dplyr)


# Step I. Identify relevant columns and assign meaningful column names ========

# Covers assignment requirement:
#   "2. Extracts only the measurements on the mean and standard deviation for each measurement."

features_all <- read.table("data/weareables/features.txt",
                            colClasses=c("NULL", "character"))[,1]

          # which of the original feature names have a sub-string std or mean()?
fselect_idx = grep("std|mean\\(\\)", features_all)

features <- features_all[fselect_idx]

mean_idx <- grep("mean", features)
features <- sub("mean\\(\\)-|-mean\\(\\)*", "", features) # remove mean() from body of string
features[mean_idx] <- paste(features[mean_idx], "Mean")   # and add a more readable version to end

std_idx <- grep("std", features)
features <- sub("std\\(\\)-|-std\\(\\)*", "", features) # sim. to above, but for std()
features[std_idx] <- paste(features[std_idx], "StdDev")

features <- sub("^t", "time ", features)   # replace t and f with more informative versions
features <- sub("^f", "freq ", features)


# Step II. Import datasets and combine ========================================

# Covers assignment requirement:
#    "1. Merges the training and the test sets to create one data set.
#     4. Appropriately labels the data set with descriptive variable names."

# Only features containing mean() and std() in name are imported

read_cols <- rep("NULL", length(features_all))
read_cols[fselect_idx] <- "numeric"

X_train <- read.table("data/weareables/train/X_train.txt",
                      colClasses = read_cols)

X_test <- read.table("data/weareables/test/X_test.txt",
                      colClasses = read_cols)

X <- bind_rows(X_train, X_test)     # perform the merge
X <- setNames(X, features)          # assign tidy column names 


# Step III. Import labels and transform =======================================

# Covers assignment requirement:
#   "3. Uses descriptive activity names to name the activities in the data set."


labels <- read.table("data/weareables/activity_labels.txt", 
                     colClasses = c("character"),
                     col.names = c("ActivityID", "Activity")) %>%
          mutate(ActivityID = as.numeric(ActivityID))


y_train <- read.table("data/weareables/train/y_train.txt", 
           colClasses = "numeric",
           col.names = "ActivityID")

y_test <- read.table("data/weareables/test/y_test.txt", 
                      colClasses = "numeric",
                      col.names = "ActivityID")

y_labelled <- bind_rows(y_train, y_test) %>%
              inner_join(y = labels, by = "ActivityID")  %>%
              select(Activity)

yX <- bind_cols(y_labelled, X)


# Step IV. Add subject and summarize ==========================================

# Covers assignment requirement:
#   "5. From the data set in step 4, creates a second, independent tidy data set 
#       with the average of each variable for each activity and each subject."

subj_train <- read.table("data/weareables/train/subject_train.txt",
                          colClasses = "integer",
                          col.names = "SubjectID")

subj_test <- read.table("data/weareables/test/subject_test.txt",
                         colClasses = "integer",
                         col.names = "SubjectID")

subj <- bind_rows(subj_train, subj_test)

all <- bind_cols(subj, yX)

tidy_summary <- all  %>%
               group_by(SubjectID, Activity) %>%
               summarise_all(mean)


# Step V. Save tidy dataset ===================================================

write.table(tidy_summary, "tidy_summary.txt", row.name = FALSE)