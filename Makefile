.SUFFIXES: .tex .dvi .pdf

TARGET :=
SRC = *.tex
TEX = uplatex -kanji=utf8 -sjis-terminal
# MENDEX = upmendex -r -c -g -s line.ist -p any $(TARGET).idx
DVIPDF = dvipdfmx

CNT := 2

.PHONY: all clean open

all: $(TARGET).pdf

clean:
	$(RM) *.aux *.log *.dvi *.idx *.toc *.out

open:
ifeq ($(OS),Windows_NT)
	start $(TARGET).pdf
else
	shell_name = $(shell uname)
ifeq ($(shell_name),Darwin)
		open $(TARGET).pdf
endif
endif


%.pdf : %.dvi
	$(DVIPDF) $<

%.dvi : %.tex $(wildcard *.tex)
	for i in `seq $(CNT)`; do $(TEX) $< ; done

$(TARGET).dvi : $(TARGET).tex
