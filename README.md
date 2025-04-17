To build report, fork + clone repository and run make in the terminal. **Report is not yet ready to build**

The /code folder contains .R script analysis files from each coder.

Code outputs are stored in the /output folder as .rds files. 

code/analysis_EE.R builds a map of relevant sites and saves it in output/analysis_out_EE.rds
code/regression_am.R runs a regression analysis and saves it in output/GGplot.rds
code/ MARY generates descriptive statistics and savies it in output/

The /report_tools folder contains the Makefile and the .yaml with report parameters. 

The report can be customized to display code or not using the "params.yaml." Changing "show code" to TRUE or FALSE, and selection can be updated in report.Rmd header.


**Messages for coders, to be deleted in final version**

The Makefile and report.Rmd overview the project flow if ur confused on where to put ur stuff. 

Please update your code to call from the csv file here!

The README.md instruction file, .gitignore, along with the final report will be stored in github, by themselves. 

The makefile and .yaml for parameters will be stored in a github file (report tools)

***Both /code and /output folders have dummy files so I could push them... ignore!***

- Please store Rscripts in /code folder

- Please use the following naming convention for your Rscripts:
        analysis_initials.R
          So, a regression model done by Amaka would be regression_am.R
          
- Please store .rds in /output folder
          
- Please use the following naming convention for your .rds files:
        analysis_out_initials.R
          So, Amaka's regression output is saved as regression_out_am.rds
