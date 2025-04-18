.PHONY: all install clean

all: install report.html

install:
	Rscript -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv'); renv::restore()"

report.html: DATA? output/analysis_out_EE.rds output/MARY.rds output/GGplot.rds
	Rscript code/build_file.R

output/analysis_out_EE.rds: analysis_EE.R
	Rscript code/analysis_EE.R

output/summary_table.rds: code/Table.R
	Rscript code/Table.R

output/GGplot.rds: code/regression_am.R
	Rscript code/regression_am.R

clean:
	rm -rf output/*.rds output/*.html