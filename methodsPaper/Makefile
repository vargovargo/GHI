manuscript.pdf: manuscript.tex ITHIM.bib
	pdflatex manuscript.tex
	bibtex manuscript.aux
	pdflatex manuscript.tex
	pdflatex manuscript.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
