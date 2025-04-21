.PHONY: all install clean

all: install report.html

install:
	Rscript -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv'); renv::restore()"

raw_data/wastewater.csv: raw_data/get_data.R
	Rscript raw_data/get_data.R

output/analysis_out_EE.rds: code/analysis_EE.R raw_data/wastewater.csv
	Rscript code/analysis_EE.R

output/descriptive_out_man.rds: code/descriptive_man.R raw_data/wastewater.csv
	Rscript code/descriptive_man.R

output/timeplot.rds: code/regression_am.R raw_data/wastewater.csv
	Rscript code/regression_am.R
	
output/boxplot.rds: code/regression_am.R raw_data/wastewater.csv
	Rscript code/regression_am.R
	
report.html: report.Rmd raw_data/wastewater.csv output/analysis_out_EE.rds output/descriptive_out_man.rds output/timeplot.rds output/boxplot.rds
	Rscript code/build_file.R

clean:
	rm -rf output/*.rds output/*.html