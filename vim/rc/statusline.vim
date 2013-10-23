function! GetName()
    return (expand("%:t") == '') ? '<none>' : expand("%:t")
endfunction

function! GetFileType()
    return strlen(&ft) ? &ft : 'none'
endfunction

function! IsHelp()
    return (&buftype == 'help') ? '(help) ' : ''
endfunction

function! IsReadOnly()
    return &readonly ? '(read-only) ' : ''
endfunction

function! IsModified()
    return &modified ? '(modified) ' : ''
endfunction

" Filename
set statusline=%1*[%2*%{GetName()}%1*]\ %1*
" Modified?
set statusline+=%3*%{IsModified()}%1*
" Help file?
set statusline+=%4*%{IsHelp()}%1*
" Read only?
set statusline+=%3*%{IsReadOnly()}%1*
" File format
set statusline+=%1*ff:%2*%{&ff}%1*\ \ 
" File type
set statusline+=%1*ft:%2*%{GetFileType()}\ \ 
" Working directory
" set statusline+=%1*pwd:%2*%{getcwd()}\ \ 

" Seperator
set statusline+=%1*%=

" Column
set statusline+=%1*col:%2*%c\ \ 
" Line
set statusline+=%1*lin:%2*%l/%L\ 
