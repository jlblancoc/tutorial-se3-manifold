# From: http://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
# You want latexmk to *always* run, because make does not have all the info.
.PHONY: jlblanco2010geometry3D_techrep.pdf

# First rule should always be the default "all" rule, so both "make all" and
# "make" will invoke it.
all: jlblanco2010geometry3D_techrep.pdf

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

jlblanco2010geometry3D_techrep.pdf: jlblanco2010geometry3D_techrep.tex
	latexmk -pdf -pdflatex="pdflatex -interactive=nonstopmode" -bibtex -use-make jlblanco2010geometry3D_techrep.tex

clean:
	latexmk -CA
