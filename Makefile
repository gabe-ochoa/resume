# suffix is not defined unless generating mutliple resumes a day
renderDate=$(shell date +%Y-%m-%d)$(suffix)
mdFile?=Readme.md

all: render

.PHONY: render

render: markdown pdf-letter
	mv $(renderDate).pdf archive/resume-$(renderDate)-$(shell md5 -q $(renderDate).pdf | cut -c 25-33).pdf && \
	rm $(renderDate).html 

preview: markdown

markdown:
	cp $(mdFile) Resume.md
	grip Resume.md --wide --export $(renderDate).html
	rm Resume.md

pdf-chrome:
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --headless  --disable-gpu --print-to-pdf=$(renderDate).pdf $(renderDate).html

pdf-firefox:
	/Applications/Firefox.app/Contents/MacOS/firefox -print $(renderDate).html -printmode pdf -printfile $(renderDate).pdf

pdf-letter:
	wkhtmltopdf --page-size Letter $(renderDate).html $(renderDate).pdf