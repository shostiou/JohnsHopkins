# COURSERA - JOHNS HOPKINS
# MODULE 04 - Exploratory Data analysis
## Stephane's assignment for Week 01

### Loading the data set
#### Memory Usage estimation
The dataset has 2,075,259 rows and 9 columns. <br>
Based on the course, Memory usage will be estimated by applying the following calculation <br>
nb_rows * nb_col * 8 bytes <br>
Estimated Memory Usage = 149 Mb <br>
Considering that I am currently executing R Studio under a virtual environment with limited RAM (1 GB), there is enough  <br>
memory available to upload the complete dataset  <br>

#### Subsetting the dataset
The analysis will be restricted to data from the dates 2007-02-01 to 2007-02-02.  <br>
A dataframe limited to this subset is built : power_DF <br>

#### Data cleaning
Performing a str() on the subset highlights that there are some inconsistent values in the dataframe <br>
values "?" are reported while numbers are expected. <br>
Those inconsistent values need to be removed <br>
power_DF contains cleaned values at the end <br>

### Plot1.R
this scripts plots a histogram of the distribution of Global Active Power & saves the plot in PNG format <br> 

### Plot2.R
this scripts plots a scatter plot of the evolution of the Global Active Power <br>
Prior plotting, date & time needs to be merged to build a proper time base <br>
At the end, it saves the plot in PNG format <br>

### Plot3.R
This script plots multiple scatter plots : evolution of the 3 the energy measured by <br>
3 different submeters. <br>
At the end, it saves the plot in PNG format <br>

### Plot4.R
This script plots 4 graphs on a single device <br>
- Evolution of the Global Active Power <br>
- Evolution of Voltage <br>
- Evolution of submeters <br> 
- Evolution of the global reactive Power <br>


