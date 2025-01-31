let mapleader=','
let maplocalleader=','

" Settings {{{

filetype plugin indent on
set encoding=utf-8

" Appearance
syntax enable
colorscheme slate

set hidden
set number
set ruler
set showcmd
set cursorline
set nowrap
set laststatus=2
set synmaxcol=300

set wildmenu
set wildmode=list:longest,full

" Indentation
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set backspace=indent,eol,start

" Search
set incsearch
set ignorecase
set smartcase
set infercase

" Redrawing
set lazyredraw
set ttyfast
set ttimeout
set ttimeoutlen=50

" Disable all bells (audio, flash)
if exists("&belloff")
  set belloff=all
endif

" Allow the cursor to move anywhere in visual block mode
set virtualedit=block

" Automatically read the file if it changed outside vim
set autoread
set modeline
set modelines=1

" Open splits to the right and to the bottom
set splitbelow
set splitright

" Flash matching braces for 200ms
set showmatch
set matchtime=2

" Don't search through includes for completion as this can be slow
set complete-=i

set nrformats-=octal

" When joining lines, delete comment characters if appropriate
set formatoptions+=j
set nojoinspaces

set nobackup
set noundofile

if has('gui_running')
  " Remove scrollbars and menus from the GUI
  set guioptions=c
endif

" }}}

" Mappings {{{

" Sanity {{{
" These mappings improve consistency in Vim's commands

" Saner line handling
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
xnoremap j gj
xnoremap k gk
xnoremap gj j
xnoremap gk k

" :W and :Q still work
command! W write
command! Q quit
cabbrev <silent> X :x

" Delete and paste without overwriting the paste register
nnoremap x "_x
xnoremap p "_dp

" When joining lines, keep the cursor in place
nnoremap J mzJ`z

" }}}

" Edit/source configuration
nnoremap <leader>ec :edit $MYVIMRC<cr>
nnoremap <leader>el :edit $MYVIMRC.local<cr>
nnoremap <leader>sc :source $MYVIMRC<cr>

" Easy split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" <leader>a selects the whole buffer
nnoremap <leader>a ggVG

" gp selects the last pasted text
nnoremap gp `[v`]

" <leader> shortcuts for copying/pasting to/from system clipboard
nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap <leader>p "+p
xnoremap <leader>p "+p

" Shift-Q repeats the q macro
nnoremap Q @q
xnoremap Q :normal! @q<CR>

" Quickly edit the Q macro
nnoremap <leader>eq :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left>

" Go back to the last buffer
nnoremap <silent> <backspace> <C-^>

" Use the arrow keys to resize viewports
nnoremap <Right> :vertical resize +2<CR>
nnoremap <Left> :vertical resize -2<CR>

" }}}

" vim: set fdm=marker:
