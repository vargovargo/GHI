manuscript.pdf: manuscript.tex ITHIM.bib ./figures/fig2.pdf ./figures/fig3.pdf
	pdflatex manuscript.tex
	bibtex manuscript.aux
	pdflatex manuscript.tex
	pdflatex manuscript.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
