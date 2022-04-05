vim.cmd [[function! OnMergetoolSetLayout(split)
  setlocal nocursorline
  call s:disable_cursorline_follows_focus()

  nnoremap <leader>mt :MergetoolToggle<cr>

  " When base is horizontal split at the bottom
  " Turn off diff mode, and show syntax highlighting
  " Also let it take less height
  if (a:split["layout"] ==# 'mr,b' || a:split["layout"] ==# 'ml,b') && a:split["split"] ==# 'b'
    setlocal nodiff
    setlocal syntax=off
    resize 15
  endif
endfunction]]

vim.cmd [[let g:mergetool_layout = 'ml,b']]
vim.cmd [[let g:mergetool_prefer_revision = 'remote']]
vim.cmd [[let g:MergetoolSetLayoutCallback = function('OnMergetoolSetLayout')]]
