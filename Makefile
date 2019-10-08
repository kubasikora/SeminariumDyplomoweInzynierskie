BUILD_DIR = build
PDF_DIR = pdfs

LATEXMK = latexmk 
MKFLAGS = -bibtex -pdf -f

PDFLATEX = pdflatex
LUALATEX = lualatex
XELATEX = xelatex
TEXFLAGS = -synctex=1 --interaction=nonstopmode 

all: pdf

clean:
	$(RM) *.fdb_latexmk *.fls *.gz
	$(RM) *.lof *.log *.out *.status
	$(RM) *.toc *.xml *-blx.bib *.pdf
	$(RM) -r $(BUILD_DIR)/*
	$(RM) -r $(PDF_DIR)/*
	$(RM) -r $(BUILD_DIR)
	$(RM) -r $(PDF_DIR)

lua: *.tex ./tex/*
	$(MAKE) base CTEX=$(LUALATEX) OUT=$(BUILD_DIR)/$(LUALATEX)

pdf: *.tex ./tex/*
	$(MAKE) base CTEX=$(PDFLATEX) OUT=$(BUILD_DIR)/$(PDFLATEX)

base: 
	$(LATEXMK) $(MKFLAGS) \
		-output-directory=$(OUT) \
		-pdflatex="$(CTEX) $(TEXFLAGS)" $<
		mkdir -p $(PDF_DIR)
		cp ./$(OUT)/main.pdf ./$(PDF_DIR)/$(CTEX).pdf