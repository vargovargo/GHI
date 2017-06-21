ITHIM-manuscript.pdf: ./ITHIM-manuscript.Rnw ../tex/ITHIM.bib ./lib/materialsAndMethods.Rnw ./lib/abstract.Rnw ./lib/introduction.Rnw ./lib/results.Rnw ./lib/ITHIM.bib
	R -e 'library("knitr"); setwd("~/GHI/ITHIM-manuscript"); knit("~/GHI/ITHIM-manuscript/ITHIM-manuscript.Rnw")'
	pdflatex ITHIM-manuscript.tex
	bibtex ITHIM-manuscript.aux
	pdflatex ITHIM-manuscript.tex
	pdflatex ITHIM-manuscript.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
