methodsPaper.pdf: methodsPaper.tex ../tex/ITHIM.bib ./tex/abstract.tex ./tex/conclusion.tex ./tex/discussion.tex ./tex/introduction.tex ./tex/materialsAndMethods.tex ./tex/results.tex ./tex/supportingInformation.tex figures/fig1.pdf figures/fig2.pdf figures/fig3.pdf
	pdflatex methodsPaper.tex
	bibtex methodsPaper.aux
	pdflatex methodsPaper.tex
	pdflatex methodsPaper.tex

clean:
	rm -rf ./*.aux
	rm -rf ./*.bbl
	rm -rf ./*.blg
	rm -rf ./*.log
