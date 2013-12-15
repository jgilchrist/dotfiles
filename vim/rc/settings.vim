" Enables Vim specific settings
set nocompatible
" Don't show the intro message when starting Vim
set shortmess=I
" Keep 1000 lines of history
set history=1000

" Turn on language specific syntax, plugins and indents
syntax on
filetype plugin indent on
set encoding=utf-8

" Show line numbers on the left hand side for coding
set number
" Auto-indent code
set autoindent
" Don't wrap lines
set nowrap
" When entering closing braces, flash the opening brace
set showmatch
" Highlight the current line
set cursorline
" Don't redraw during macros
set lazyredraw
" Improve redrawing
set ttyfast

" Expand tabs into spaces
set expandtab
" Expand tabs into 4 spaces
set tabstop=4
" Use 4 spaces for indentation
set shiftwidth=4
" Round up to the closest shift-width when inserting tabs
set shiftround
" Allow backspace to act correctly for 4 spaces
set softtabstop=4
" Allow backspace to delete over lines
set backspace=indent,eol,start

" Make the status bar two lines
set laststatus=2
" Make vim scroll when the cursor reaches the 3rd line from the end
set scrolloff=3
" Show the currently entered command on the statusline
set showcmd
" Show the current cursor position on the status bar
set ruler
" Show a column for the 100th character on the line
set colorcolumn=81
" Open splits to the right and to the bottom
set splitbelow
set splitright

" Search incrementally
set incsearch
" Highlight matched text
set hlsearch
" Ignore case when searching, unless the search includes case
set ignorecase smartcase

" Don't keep swap files or backups (use version control instead!)
set noswapfile
set nobackup

" Allows a completion menu for command line completion
set wildmenu
set wildmode=list:longest,full
" Ignore the following types of files:
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png

set t_Co=256
colorscheme Tomorrow-Night
