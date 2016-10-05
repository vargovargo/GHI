all : report manuscript.pdf webpage

webpage : html/index.txt html/tableau/tableau.txt
	perl ~/lib/Markdown_1.0.1/Markdown.pl ./html/index.txt > ./html/index.html
	perl ~/lib/Markdown_1.0.1/Markdown.pl ./html/tableau/tableau.txt > ./html/tableau/tableau.html

report : R/ITHIM.Rmd R/ITHIM.R
	cd R; R --vanilla -e 'source("ITHIM.R")'

manuscript.pdf : manuscript/manuscript.tex manuscript/ITHIM.bib manuscript/figures/fig2.pdf manuscript/figures/fig3.pdf
	cd manuscript; make manuscript.pdf
