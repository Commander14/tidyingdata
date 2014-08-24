Description of what the run_analysis.R script does and assumptions made
=======================================================================

The run_analysis.R script makes the following assumptions:

    - The script sits in a directory that contains a directory called "UCI HAR Dataset" which is a directory tree of the raw activity data files provided in the file getdata-projectfiles-UCI HAR Dataset.zip which was pulled from
    
        - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
        
    - Load it into R via source("run_analysis.R)
    
    - Analyze by calling the function analyzeData()
    

The run_analysis.R script does the following:

    - Reads in the training and test data sets from the raw data
    
    - The script only keeps data that has the following in the original features column names:
    
        - mean() - the "mean" of the data presented
        
        - std() - the standard deviations of the data presented
        
    - Merges then tidys up the data and then presents it in table for sorted for each activity and each subject
    
        - Each cell entry is an average of all of the values for that feature grouped by all instances of that subject doing that activity and then average.
            
            - eg: For all WALKING values found for subject 1, average tBodyAcc-mean()-X and place the mean in the column titles tBodyAcc-mean()-X and a row with a Subject value of 1 and an Activity value of WALKING
    
        - The data is presented in a "wide" format as discussed in the following thread with the community TA helping this analysis
        
        - https://class.coursera.org/getdata-006/forum/thread?thread_id=236 
        
    - The raw inertial data (in the "Intertial Signals" directory is not included in this analysis
    

Notes
=====

- All features are normalized and bounded between [-1,1]  

Codebook for the tidy data
==========================

Included in the same directory as this README is a file named codebook.txt that describes the data represented in the tidy data.


Original Raw Data Set Information:
==================================

This information is taken from the raw data sets description and is presented here for reference

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Check the README.txt file for further details about this dataset.


Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.



