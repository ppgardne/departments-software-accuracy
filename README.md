* This repository contains scripts and datasets associated with a study of the relationship between bioinformatic software tool accuracy and the host academic department's subject area. 

### Directory descriptions:
```
 bin/        -- contains scripts associated with the data analysis and visualisation
 data/       -- raw data collected during the project
 figures/    -- images generated during the analysis
 manuscript/ -- manuscript files
```

### Data sources and curation 

- The following tables are derived from supplementary tables shared with the paper:
Gardner PP *et al.* (2022)
Sustained software development, not number of citations or journal choice, is indicative of accurate bioinformatic software.
Genome biology. [https://doi.org/10.1186/s13059-022-02625-x] and the github repository [https://github.com/Gardner-BinfLab/speed-vs-accuracy-meta-analysis]


```
 data/table1.tsv 
 data/table2.tsv 
```

Additional columns were manually added to ```table2.tsv``` based upon corresponding author addresses. These were:
```
	20 Expertise based on department -- a classification of each author's field into one of 'Development', 'Domain' or 'Interdisciplinary' expert.
	21 General field                 -- a semi-colon separated list of the general fields of study "NSF Codes for Classifications for Research" for each specific field of study
	22 Fields (specific code)        -- a semi-colon separated list of the specific fields of study "NSF Codes for Classifications for Research"
[https://ncsesdata.nsf.gov/sere/2018/html/sere18-dt-taba001.html] that best match the listed departments
	23 Department                    -- semi-colon separated list of departments listed by corresponding author
```

### Work flow:

- Step 1: bootstrap resampling of tools and counting of the number of wins for each tool in the corresponding benchmark(s) 
```
cd data 
../bin/tsv2data.pl && cat mean-wins-cis.tsv
```

- Step 2: plot the results and generate summary statistics
```
R CMD BATCH ../bin/plotResults.R
```



### Files and descriptions:

 - [./README.md](./README.md) - this file 

 - [./LICENSE](./LICENSE) - license file 

- **"bin" directory**, the software scripts used to process and visualise the results 

 - [./bin/plotResults.R](./bin/plotResults.R) - R script for parsing data files and generating the figures presented in the manuscript. 

 - [./bin/tsv2data.pl](./bin/tsv2data.pl) - perl script for parsing data tables (TSV), and converting/joining them, and running bootstrap proceedures. Produces the required data files for R (plotResults.R). 

- **"data" directory**

 - [./data/table1.tsv](./data/table1.tsv) - a table of benchmark publications, a list of tools for each, their ranks and the sources (figures/tables) for each.  

 - [./data/table2.tsv](./data/table2.tsv) - a table of tool information. List of tools, publications, author addresses, general/specific field and expertise. Together with many other pieces of information used in aprevious publication.  

 - [./data/mean-wins-cis.tsv](./data/mean-wins-cis.tsv)  - tab-separated-values for each field:
```
     1	fieldLayer
     2	field
     3	meanWins
     4	lowCI
     5	highCI
     6	count
     7	standardDeviation
     8	N
```

 - [./data/toolsVsGeneralField.tsv](./data/toolsVsGeneralField.tsv) - tab-separated-values for each general field and the tools representing each (used for the UpSetR plot):
```
     1	tool
     2	MathematicsandStatistics
     3	Biologicalsciences
     4	Engineering
     5	Technologies
     6	Computersciences
     7	Healthsciences
```

 - [./data/toolsVsSpecificField.tsv](./data/toolsVsSpecificField.tsv) - tab-separated-values for each specific field and the tools representing each (used for the UpSetR plot):
```
     1	tool
     2	Informatics
     3	Medicalinformatics
     4	Bioinformatics
     5	Computerscience
     6	Molecularbiology
     7	Molecularmedicine
     8	Mathematics
     9	Biostatistics
    10	Statistics
    11	Genetics
    12	Biology/biologicalsciences
    13	Biochemistry
```

 - [./data/fig2-data.tsv](./data/fig2-data.tsv) - comma-separated-values of the data presented in Figure 2. For each field:
```
     1	row
     2	fieldLayer
     3	field
     4	meanWins
     5	lowCI
     6	highCI
     7	count
     8	standardDeviation
     9	N
    10	z
    11	p.vals.adj
```

- **"docs" directory**, the manuscript draft, bibliography and figures. 

 - [./docs/manuscript.tex](./docs/manuscript.tex) - a LaTeX file containing the manuscript text.  

 - [./docs/manuscript.pdf](./docs/manuscript.pdf) - the compiled manuscript PDF. 

 - [./docs/references.bib](./docs/references.bib) - references in a format used by bibtex/LaTeX. 

 - [./docs/figures/upset-plots.pdf](./docs/figures/upset-plots.pdf) - Figure 1. A combination of upset plots, with figure labels. 

 - [./docs/figures/upsetPlotSpecificFiled.pdf](./docs/figures/upsetPlotSpecificFiled.pdf) -  Figure 1A.

 - [./docs/figures/upsetPlotGeneralFiled.pdf](./docs/figures/upsetPlotGeneralFiled.pdf) - Figure 1B.

 - [./docs/figures/forest-z-Plot.pdf](./docs/figures/forest-z-Plot.pdf) - Figure 2. Figure labels added.

 - [./docs/figures/forestPlot.pdf](./docs/forestPlot.pdf) - Figure 2A&B. Unedited. 
