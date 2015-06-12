# Use XeLaTeX
# 'syntex' - generate files which allow PDF readers to jump to most recent edits
$pdflatex = "xelatex -synctex=1 --shell-escape %O %S";

# Always generate PDFs
$pdf_mode = 1;

# Remove .bbl files (latexmk doesn't be default since .bib files might not be available)
$bibtex_use = 2;

# Clean these additional files with latexmk -C
$clean_ext = "run.xml";
