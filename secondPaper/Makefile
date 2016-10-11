manuscript.pdf: manuscript.tex ../tex/ITHIM.bib ./tex/abstract.tex ./tex/discussion.tex ./tex/introduction.tex ./tex/methods.tex ./tex/publicHealthImplications.tex ./tex/results.tex
	pdflatex manuscript.tex
	bibtex manuscript.aux
	pdflatex manuscript.tex
	pdflatex manuscript.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
