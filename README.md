This is a high level description of the steps to be performed to obtain the summary dataset which represents the goal of the project. Low level details of the implementation are provided as comments around the relevant pieces of code in the script file `run_analysis.R`

1. Read in the dataset contained in `./train/X_train.txt` which contains 70% of the values for each of the 561 features described in `CodeBook.md`; Add the information contained in the files `./train/subject_train.txt` (subject id's for each observation) and `./train/y_train.txt` (activity code for each observation) to the dataset.
2. Read in the dataset contained in `./test/X_test.txt` which contains the remaining 30% of the values for each of the features; Add to this new dataset the information contained in the files `./test/subject_test.txt` (subject id's for each observation) and `./test/y_test.txt` (activity code for each observation).
3. Create a new dataset which combines (stacks vertically) the two datasets described above.
4. Add the correct labels to this dataset by using the information provided in the file `./UCI HAR Dataset/features.txt`.
5. Extract from this dataset only the columns containing the measurements on the mean and standard deviation for each measurement, by keeping only the variables containing the strings "mean" or "std" in their name.
6. Split this restricted dataset by activity code and subject, compute the average for each variable and combine these results to obtain the summary dataset.

Notes:
The analysis uses base `R` and Hadley Wickham's [`stringr`](https://github.com/hadley/stringr) and [`plyr`](http://plyr.had.co.nz/) packages.