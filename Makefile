# suffix is not defined unless generating mutliple resumes a day
renderDate=$(shell date +%Y-%m-%d)$(suffix)
mdFile?=Readme.md

.PHONY: render

render: markdown pdf-chrome
	mv $(renderDate).pdf archive/resume-$(renderDate).pdf && \
	rm $(renderDate).html 

markdown:
	grip $(mdFile) --user-content --export $(renderDate).html

pdf-chrome:
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --headless  --disable-gpu --print-to-pdf=$(renderDate).pdf $(renderDate).html

pdf-firefox:
	/Applications/Firefox.app/Contents/MacOS/firefox -print $(renderDate).html -printmode pdf -printfile $(renderDate).pdf
