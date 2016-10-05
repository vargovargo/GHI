all : clean data report manuscript.pdf

report: R/ITHIM.Rmd R/ITHIM.R
	cd R; R --vanilla -e 'source("ITHIM.R")'

manuscript.pdf: manuscript/manuscript.tex manuscript/ITHIM.bib manuscript/figures/fig2.pdf manuscript/figures/fig3.pdf
	cd manuscript; make manuscript.pdf

data:
	wget http://nhts.ornl.gov/2009/download/Ascii.zip
	mkdir -p ./data/NHTS
	unzip Ascii.zip -d ./data/NHTS/
	mv -v Ascii.zip ./data/NHTS/

clean:
	rm -rf ./data/*
	rm -rf ./R/figure/*
	rm -rf ./R/data/*

.PHONY: data

.PHONY2: clean

# webpage: html/index.txt html/tableau/tableau.txt
# 	perl ~/lib/Markdown_1.0.1/Markdown.pl ./html/index.txt > ./html/index.html
# 	perl ~/lib/Markdown_1.0.1/Markdown.pl ./html/tableau/tableau.txt > ./html/tableau/tableau.html
