webpage: ./html/index.txt ./html/tableau/tableau.txt
	perl ~/lib/Markdown_1.0.1/Markdown.pl ./html/index.txt > ./html/index.html
	perl ~/lib/Markdown_1.0.1/Markdown.pl ./html/tableau/tableau.txt > ./html/tableau/tableau.html
