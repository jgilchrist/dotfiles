" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$\|\.svn$\|\.yardoc\|target\|data\|log\|tmp$',
    \ 'file': '\.exe$\|\.so$\|\.dat$'
    \ }

nnoremap <leader>nt :NERDTreeToggle<CR>

nnoremap <leader>ta :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
