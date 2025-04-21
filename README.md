To build report, fork + clone repository and run make in the terminal. Renv should automatically update all packages. 

The /code folder contains .R script analysis files from each coder.

Code outputs are stored in the /output folder as .rds files. 

code/analysis_EE.R builds a map of relevant sites and saves it in output/analysis_out_EE.rds
code/regression_am.R runs builds boxplots and a timeplot and saves them in output as timeplot.rds and boxplot.rds
code/ descriptive_man.R generates descriptive statistics and savies it in output/descrptive_out_man.R


The report can be customized to display code/messages/warnings/errors/ or not using the "params.yaml." Changing "show [code/messages/warnings/errors] to TRUE will show them. 
