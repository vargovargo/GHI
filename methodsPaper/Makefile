methodsPaper.pdf: ../tex/ITHIM.bib ./lib/materialsAndMethods.Rnw
	R -e 'library("knitr"); setwd("~/GHI/methodsPaper/lib"); knit("~/GHI/methodsPaper/lib/materialsAndMethods.Rnw"); knit("~/GHI/methodsPaper/lib/abstract.Rnw"); knit("~/GHI/methodsPaper/lib/introduction.Rnw");  knit("~/GHI/methodsPaper/lib/conclusion.Rnw"); knit("~/GHI/methodsPaper/lib/discussion.Rnw"); knit("~/GHI/methodsPaper/lib/results.Rnw"); knit("~/GHI/methodsPaper/lib/supportingInformation.Rnw");'
	pdflatex methodsPaper.tex
	bibtex methodsPaper.aux
	pdflatex methodsPaper.tex
	pdflatex methodsPaper.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
