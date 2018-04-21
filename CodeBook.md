### Code Book for Project Assignment - course "Getting and Cleaning Data"

From the project assignment description, it is expected that the code book contains:
* a link to the original data set,
* a description of the variables used in the script, and
* any transformations or work performed to clean up the data.

***

The original data set used and its description can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Below are listed the main variables created in the process of producing the tidy
data set. In the table, v[x] refers to a vector of length x, df[x,y] to a
dataframe of dimensions (x,y), and gdf to a "grouped_df" dataframe created with package "dplyr".


Object    | Description | Dimension | Type
--------- | ------------| ----------| -----| 
features_all  | original feature names read from file "features.txt";<br>feature names were coerced to character | v[561] |char
features | requested feature names using more readable names;<br>the requested features are those relating to means and standard deviations | v[66] | char
X_train | import from "X_train.txt"; only requested columns are read| df[7352,66] | numeric
X_test | import from "X_test.txt"; only requested columns are read| df[2947,66] | numeric
X | X_train and X_test combined, with tidy column names | df[10299,66] | numeric
labels | content is read from "activity_labels.txt", followed by type conversions;<br> first column contains activity ID, the second a textual description of the activity| df[5,2] | numeric, char
y_train|activity ID labels read from "y_train.txt"|df[7352,1]|integer
y_test|activity ID labels read from "y_test.txt"|df[2947,1]|integer
y_labelled|y_train and y_test combined, with the activity indicated as a character string |df[10299,1] | char
yX | combines data set X with its associated activities from y_labelled;<br>all columns have descriptive names|df[10299,67] | char & numeric
subj_train | IDs of persons who perfromed the tests of each observation (row) in the training dataset ; imported from "subject_train.txt" |df[7352,1]|integer
subj_test | as above; imported from "subject_test.txt" |df[2947,1]|integer
all|all information combined: on subjects, activities and the actual measurements; all columns have descriptive names |df[10299,68]| char & int & numeric
tidy_summary |means of all measurements, by subject and activity |gdf[180,68]|char & int & numeric

<br>
Some information from tidy_summary:

```{r}
head(colnames(tidy_summary), 10)       # display first 10 column names

 [1] "SubjectID"                       "Activity"                       
 [3] "time BodyAcc-X Mean"             "time BodyAcc-Y Mean"            
 [5] "time BodyAcc-Z Mean"             "time BodyAcc-X StdDev"          
 [7] "time BodyAcc-Y StdDev"           "time BodyAcc-Z StdDev"          
 [9] "time GravityAcc-X Mean"          "time GravityAcc-Y Mean"         
```

```{r}
tidy_summary[1:10,1:4]                 # display a few rows and columns

# A tibble: 10 x 4
# Groups:   SubjectID [2]
   SubjectID Activity           `time BodyAcc-X Mean` `time BodyAcc-Y Mean`
       <int> <chr>                              <dbl>                 <dbl>
 1         1 LAYING                             0.222              -0.0405 
 2         1 SITTING                            0.261              -0.00131
 3         1 STANDING                           0.279              -0.0161 
 4         1 WALKING                            0.277              -0.0174 
 5         1 WALKING_DOWNSTAIRS                 0.289              -0.00992
 6         1 WALKING_UPSTAIRS                   0.255              -0.0240 
 7         2 LAYING                             0.281              -0.0182 
 8         2 SITTING                            0.277              -0.0157 
 9         2 STANDING                           0.278              -0.0184 
10         2 WALKING                            0.276              -0.0186
```