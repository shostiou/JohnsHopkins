# COURSERA - JOHNS HOPKINS
# MODULE 04 - Exploratory Dataanalysis
## Stephane's assignment for Week 01

### Loading the data set
#### Memory Usage estimation
The dataset has 2,075,259 rows and 9 columns. <br>
The "object_size"" function of the pryr package calculates the memory usage of a specific variable <br>
As the dataset embeds 3 types of data : date format (x1) , time format (x1) and float (x7 columns) <br>
The memory usage of the complete dataset can be estimated : <br>
MemUsage_dataset = (object_size(date_test) + object_size(time_test) + 7*object_size(float_test))*nrows_dataset <br>

Estimated Memory Usage = 1.64 GB.

Considering that I am currently executing R Studio under a virtual environment with limited RAM (1 GB), I'll have to consider
working only on a subset of the dataset.

As suggested in the instructions, only relevant data (rom the dates 2007-02-01 and 2007-02-02) will be uploaded for this project.

