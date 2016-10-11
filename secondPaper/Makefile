secondPaper.pdf: secondPaper.tex ../tex/ITHIM.bib ./tex/abstract.tex ./tex/discussion.tex ./tex/introduction.tex ./tex/methods.tex ./tex/publicHealthImplications.tex ./tex/results.tex
	pdflatex secondPaper.tex
	bibtex secondPaper.aux
	pdflatex secondPaper.tex
	pdflatex secondPaper.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
