# suffix is not defined unless generating mutliple resumes a day
renderDate=$(shell date +%Y-%m-%d)$(suffix)
mdFile?=Readme.md

all: render

.PHONY: render


render: markdown
	mv $(renderDate).pdf archive/resume-$(renderDate)-$(shell md5 -q $(renderDate).pdf | cut -c 25-33).pdf

preview: markdown

markdown:
	pandoc Readme.md -V geometry:margin=1in --pdf-engine=/Library/TeX/texbin/pdflatex -o $(renderDate).pdf

install:
	brew install pandoc basictex