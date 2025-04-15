.PHONY: all install clean

all: install report.html

install:
	Rscript -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv'); renv::restore()"

report.html: DATA? output/EMILIO.rds output/MARY.rds output/AMAKA.rds 
	Rscript code/build_file.R

output/map.rds: code/Map.R
	Rscript code/Map.R

output/summary_table.rds: code/Table.R
	Rscript code/Table.R

output/regressions.rds: code/Regression.R
	Rscript code/Regression.R

clean:
	rm -rf output/*.rds output/*.html