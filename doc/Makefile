TEX2DVI = latexmk --shell-escape
DVI2PDF = dvipdfmx
TEX2HTML = latex2html -split 0
TEXFILE = main.tex
TEXFILES = $(wildcard tex/*.tex)
BIBFILES = $(wildcard *.bib)
FIGDIR = fig
SVG2PDF = DISPLAY= LC_ALL=C inkscape -z -D
SVGFILES = $(wildcard $(FIGDIR)/*.svg)
FIGFILES = $(wildcard $(FIGDIR)/*.eps) $(SVGFILES:.svg=.pdf)

PAPERSIZE = letter

.SUFFIXES: .tex .svg .dvi .pdf .html

all: pdf

.tex.dvi:
	$(TEX2DVI) $<

.dvi.pdf:
	$(DVI2PDF) -p $(PAPERSIZE) $<

.tex.html:
	$(TEX2HTML) $<

.svg.pdf:
	$(SVG2PDF) --file=$(PWD)/$< --export-pdf=$(PWD)/$@

dvi: $(TEXFILE:.tex=.dvi)
$(TEXFILE:.tex=.dvi): $(TEXFILES) $(FIGFILES) $(BIBFILES)
pdf: $(TEXFILE:.tex=.pdf)
$(TEXFILE:.tex=.pdf): $(TEXFILES) $(FIGFILES) $(BIBFILES)
html: dvi $(TEXFILE:.tex=.html)
$(TEXFILE:.tex=.html): $(TEXFILES) $(FIGFILES) $(BIBFILES)

clean:
	rm -fv *.bbl *.blg *.aux *.log *.toc *.fff *.brf *.lof
	rm -fv *.dvi
	rm -fv *.fdb_latexmk *.fls
	rm -fv $(TEXFILE:.tex=.pdf)
	rm -fv $(TEXFILE:.tex=.html)
	rm -fv $(SVGFILES:.svg=.pdf)
