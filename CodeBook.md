Summary for SmartLab smartphone dataset
========================================================

### Description of the study
The original [dataset](archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) we used is part of the _Human Activity Recognition Using Smartphones Dataset Version 1.0_ [study](1) done by Jorge L. Reyes-Ortiz et al. at the [Non Linear Complex Systems Laboratory](www.smartlab.ws) at _Universita degli Studi di Genova_.

### Sampling information
From the codebook of the original dataset:
>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 


### Structure and details of the original dataset

The dataset contains 561 variables and a total of 10299 observations. The variables represent normalized values (bounded within [-1, 1]) of features representing a wide range of transformations of time domain signals recorded by the accelerometer and gyroscope of the smartphones.

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals `tAcc-XYZ` and `tGyro-XYZ`. These time domain signals (prefix `t` to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (`tBodyAcc-XYZ` and `tGravityAcc-XYZ`) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived [sic!] in time to obtain Jerk signals (`tBodyAccJerk-XYZ` and `tBodyGyroJerk-XYZ`). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (`tBodyAccMag`, `tGravityAccMag`, `tBodyAccJerkMag`, `tBodyGyroMag`, `tBodyGyroJerkMag`). 

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing `fBodyAcc-XYZ`, `fBodyAccJerk-XYZ`, `fBodyGyro-XYZ`, `fBodyAccJerkMag`, `fBodyGyroMag`, `fBodyGyroJerkMag`. (Note the `f` to indicate frequency domain signals).

**Anatomy of a pattern**:  

    |        |       |        |
:--:|:------:|:-----:|:------:|:----
`t` | `Body` | `Acc` | `Jerk` | `X`
1   |2       |3      |4       |5


1. time or frequency domain (t/f)
2. body acceleration or gravitational acceleration (Body/Grav)
3. linear acceleration or angular velocity (Acc/Gyro)
4. time derivative of acceleration ( /Jerk)
5. direction (X, Y, Z) or magnitude (XYZ/Mag)

**Time domain patterns**:

               |                   |                    |                 |
---------------|-------------------|--------------------|-----------------|-------------
`tBodyAcc-XYZ` | `tGravityAcc-XYZ` | `tBodyAccJerk-XYZ` | `tBodyGyro-XYZ` | `tBodyGyroJerk-XYZ`
`tBodyAccMag`  | `tGravityAccMag`  | `tBodyAccJerkMag`  | `tBodyGyroMag`  | `tBodyGyroJerkMag`

**Frequency domain patterns**:

               |                  |                  |                   |
---------------|------------------|------------------|-------------------|
`fBodyAcc-XYZ` |`fBodyAccJerk-XYZ`| `fBodyGyro-XYZ`  | 
`fBodyAccMag`  |`fBodyAccJerkMag` | `fBodyGyroMag`   | `fBodyGyroJerkMag`


For each of these signals, the following set of variables (features) were estimated:

feature         | description
:---------------|:------------------------------
`mean()`        | Mean value
`std()`         | Standard deviation
`mad()`         | Median absolute deviation 
`max()`         | Largest value in array
`min()`         | Smallest value in array
`sma()`         | Signal magnitude area
`energy()`      | Energy measure. Sum of the squares divided by the number of values. 
`iqr()`         | Interquartile range 
`entropy()`     | Signal entropy
`arCoeff()`     | Autorregresion coefficients with Burg order equal to 4
`correlation()` | correlation coefficient between two signals
`maxInds()`     | index of the frequency component with largest magnitude
`meanFreq()`    | Weighted average of the frequency components to obtain a mean frequency
`skewness()`    | skewness of the frequency domain signal 
`kurtosis()`    | kurtosis of the frequency domain signal 
`bandsEnergy()` | Energy of a frequency interval within the 64 bins of the FFT of each window.
`angle()`       | Angle between to vectors.

### Structure and details of the summary dataset

The summary dataset obtained by running the `run_analysis.R` script contains only the variables referring to the mean and standard deviation for each measurement (excluding angles between vectors of the type `angle(Z,gravityMean)`). The 180 rows represent average values for these variables, computed for each combination of activity (n=6) and subject (n=30).
The first three columns contain the activity code, activity label and subject id, and the remaining 79 columns contain the averaged values for each variable. The names of the variables have been expanded for easier human reading.
The dataset is provided in `.csv` format. 

______

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012