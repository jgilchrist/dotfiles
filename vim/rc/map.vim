" Disable the arrow keys
" ------------------------------------------------------------------------------
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

" Leader key as ,
" ------------------------------------------------------------------------------
let mapleader=","
noremap \ ,

" Easy split navigation
" ------------------------------------------------------------------------------
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" :W and :Q still work
" ------------------------------------------------------------------------------
command! W write
command! Q quit

" Underline with a mapping
" ------------------------------------------------------------------------------
nnoremap <leader>- yypVr-A--<esc>
inoremap <leader>- <esc>yypVr-A--

" Delete and paste without overwriting the paste register
" ------------------------------------------------------------------------------
nnoremap x "_x
vnoremap p "_c<Esc>p

" Make Y behave like other capitals
" ------------------------------------------------------------------------------
nnoremap Y y$

" Enter removes search highlighting
" ------------------------------------------------------------------------------
nnoremap <CR> :nohlsearch<CR>

" Close the current buffer with <leader>q
" ------------------------------------------------------------------------------
nnoremap <leader>q :bd<CR>
