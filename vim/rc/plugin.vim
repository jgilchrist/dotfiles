" CtrlP
" ------------------------------------------------------------------------------

" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
    \ 'dir': '\.git$\|\.hg$\|\.svn$\|\.yardoc\|target\|data\|log\|tmp\|doc$',
    \ 'file': '\v\.(exe|so|dat|dll|class)$'
    \ }

" NERDTree
" ------------------------------------------------------------------------------
nnoremap <leader>nt :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\.class$']

let g:NERDSpaceDelims=1

" vim-airline
" ------------------------------------------------------------------------------
let g:airline_left_sep=''
let g:airline_right_sep=''

if !exists("g:UltiSnipsJumpForwardTrigger")
    let g:UltiSnipsJumpForwardTrigger="<tab>"
endif

" switch.vim
" ------------------------------------------------------------------------------
nnoremap s :Switch<cr>
