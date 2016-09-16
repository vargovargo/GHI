manuscript.pdf: manuscript.tex ITHIM.bib ./figures/fig2.png ./figures/HHSmap.pdf
	pdflatex manuscript.tex
	bibtex manuscript.aux
	pdflatex manuscript.tex
	pdflatex manuscript.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
