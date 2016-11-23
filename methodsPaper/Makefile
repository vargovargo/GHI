methodsPaper.pdf: ./methodsPaper.Rnw ../tex/ITHIM.bib ./lib/materialsAndMethods.Rnw ./lib/abstract.Rnw ./lib/introduction.Rnw
	R -e 'library("knitr"); setwd("~/GHI/methodsPaper"); knit("~/GHI/methodsPaper/methodsPaper.Rnw")'
	pdflatex methodsPaper.tex
	bibtex methodsPaper.aux
	pdflatex methodsPaper.tex
	pdflatex methodsPaper.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
