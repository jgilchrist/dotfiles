" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$\|\.svn$\|\.yardoc\|target\|data\|log\|tmp$',
    \ 'file': '\v\.(exe|so|dat|dll|class)$'
    \ }

nnoremap <leader>nt :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\.class$']

let g:NERDSpaceDelims=1
