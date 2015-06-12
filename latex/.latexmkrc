# Use XeLaTeX
# 'nonstopmode' - don't halt on errors
# 'halt-on-error' - halt as soon as the first error is reached
# 'syntex' - generate files which allow PDF readers to jump to most recent edits
$pdflatex = "xelatex -interaction=nonstopmode -halt-on-error -synctex=1 --shell-escape %O %S";

# Always generate PDFs
$pdf_mode = 1;

# Put all generated files in build/
$out_dir = "build";

# Remove .bbl files (latexmk doesn't be default since .bib files might not be available)
$bibtex_use = 2;

# Clean these additional files with latexmk -C
$clean_ext = "run.xml";
