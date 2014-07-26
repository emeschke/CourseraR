Readme file

Relates to the project in:
https://class.coursera.org/getdata-005/human_grading

The attached script, project.r, is the only script necessary to parse the dataset according to the instructions.  The script is commented within the program.

The script first loads the contents of the various files into different dataframes.  The dataframes for test/train are joined such that subject, y_val, and x_values are concatenated by column.  Test is then concatenated to train by row.

Lines 18-32 take a dataframe that is the column names of the x_values.  Two additional labels are created, subject and y_val, and added to the beginning of the x_values labels.  The resulting vector is assigned to be the column names of the dataframe created above.

The grep function is then used to create a dataframe with column names that end in std() and mean().  Those dataframes are concatenated onto the end of a dataframe with the subject and y_val.  This is an intermediate dataset that contains the information for subject, y_val, and the means and stds.

The column name for the Y_var is then transformed from a numerical value to one of the six types of movement/position.

Finally, the mean is calculated for each pair of y_var and subject.  The resulting output is written to a text file that is " " delimited.