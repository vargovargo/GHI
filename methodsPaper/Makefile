manuscript.pdf: manuscript.tex ../tex/ITHIM.bib ./tex/abstract.tex ./tex/conclusion.tex ./tex/discussion.tex ./tex/introduction.tex ./tex/materialsAndMethods.tex ./tex/results.tex ./tex/supportingInformation.tex
	pdflatex manuscript.tex
	bibtex manuscript.aux
	pdflatex manuscript.tex
	pdflatex manuscript.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
