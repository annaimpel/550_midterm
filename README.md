To build report, fork + clone repository and run make in the terminal. Renv should automatically update all packages. 

This project analyzes CDC wastewater surveillance data to track SARS-CoV-2 RNA trends. It includes mapping, descriptive statistics, and modeling, compiled into a final HTML report.

The /code folder contains .R script analysis files from each coder.

Code outputs are stored in the /output folder as .rds files. 

raw_data get_data.R extracts wastewater data from url and saves it as a csv for local applications

code/analysis_EE.R builds a map of relevant sites and saves it in output/analysis_out_EE.rds
code/regression_am.R runs builds boxplots and a timeplot and saves them in output as timeplot.rds and boxplot.rds
code/ descriptive_man.R generates descriptive statistics and savies it in output/descrptive_out_man.R


The report can be customized to display code/messages/warnings/errors/ or not using the "params.yaml." Changing "show [code/messages/warnings/errors] to TRUE will show them. 
