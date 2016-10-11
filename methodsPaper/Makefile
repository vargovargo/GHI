methodsPaper.pdf: methodsPaper.tex ../tex/ITHIM.bib ./tex/abstract.tex ./tex/conclusion.tex ./tex/discussion.tex ./tex/introduction.tex ./tex/materialsAndMethods.tex ./tex/results.tex ./tex/supportingInformation.tex
	pdflatex methodsPaper.tex
	bibtex methodsPaper.aux
	pdflatex methodsPaper.tex
	pdflatex methodsPaper.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
