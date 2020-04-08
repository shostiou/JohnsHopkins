# JOHNS HOPKINS - Stephane's Getting and Cleaning Data Course Project <br>
# Codebook - 2020/04/08 <br>

 This document describes the variables, the data, and any transformations or work that performed to clean up the data <br>

### Temporary variables <br>
A set of temporary variables was used to allow data cleaning :<br>
- features : dataframe used to upload data from features.txt (1 column - 561 rows). This DF contains features names <br>
- x_train_set : dataframe used to upload data from X_train.txt (561 columns - 7352 rows) <br>
- x_test_set : dataframe used to upload data from X_test.txt (561 columns - 2947 rows) <br>
- x_data_set : dataframe where data of x_train_set & x_test_set is merged (561 columns - 2947 rows) <br>
- data_std_mean : dataframe built from x_data_set. Contains only the measurements on the mean and standard deviation for each meas. <br>

- y_act_label : dataframe used to upload data from activity_labels.txt (2 columns - 6 rows). Provide explicit description of activity <br>
- y_train_set : dataframe used to upload data from y_train.txt (1 column - 7352 rows) - activity number  <br>
- y_test_set : dataframe used to upload data from y_test.txt (1 columns - 2947 rows) - activity number <br>
- y_data_set : dataframe where data of y_train_set & xytest_set is merged (1 column - 2947 rows) <br>
