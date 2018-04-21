## Repo for Project assignment of Coursera course "Getting and Cleaning Data"

The goal of this project is to test the student's ability to collect, work with, and clean a data set, which can be used for later analysis.



This repository contains, besides the README, the following files:

* run_analysis.R: script which converts the original dataset to the requested tidy one
* CodeBook.md: a description of the main variables used during above-mentioned transformation

The original data set represents data collected from the accelerometers from the Samsung Galaxy S smartphone. Several people where measured while performing one of six activities, such as walking and sitting. It can be found at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script:
1. determines first which features (columns) are required (i.e. those containing means and standard deviations), and changes these feature names to more descriptive versions;
2. reads in the measurement data sets; only the required columns are imported, to minimize non-value adding activity;
3. reads in the activity performed, and the person who performed it from two separate files;
4. combines all this information into one dataframe;
5. summarizes the mean of all included measurements, per person and activity;
6. writes the dataframe from 5 to a text file.

