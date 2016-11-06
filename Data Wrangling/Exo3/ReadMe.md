    Data Wrangling Exercise 3: Human Activity Recognition (Optional)


Note: This data wrangling project is known to be a bit challenging, hence we've marked it as optional. However, we recommend you at least try it out when you're more comfortable with R later in the curriculum, since it's a good example of a messy, real-world data set that you'd encounter in a data science job.



The goal of this project is to get you some practice in processing real world datasets using the tools and techniques you learned above. Using your Capstone dataset here will get you one step closer to the finish line. If for some reason (e.g. the chosen dataset is already tidy) your Capstone dataset is unsuitable, you can use the Samsung Galaxy S Smartphone dataset, available via UCI. A full description of that data is available here and also in the README file included with the data.


We give submission guidelines below assuming the UCI smartphone data set. This data set is organized in a way that makes it hard to use at first. You will need to use several data transformation techniques to put it into a usable, tidy state. Here's a great post in the workshop community which gives several handy tips on how to approach this. Discuss with your mentor if needed!

You should create one R script called run_analysis.R that does the following: 

1) Merges the training and the test sets to create one data set.
2) Extracts columns containing mean and standard deviation for each measurement (Hint: Since some feature/column names are repeated, you may need to use the make.names() function in R)
3) Creates variables called ActivityLabel and ActivityName that label all observations with the corresponding activity labels and names respectively
4) From the data set in step 3, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
