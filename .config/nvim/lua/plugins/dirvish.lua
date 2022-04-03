vim.cmd [[let g:dirvish_mode = ':sort | sort ,^.*/,']]
-- Disable Dirvish's C-p and C-n mappings
vim.cmd [[
augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
  autocmd FileType dirvish silent! unmap <buffer> <C-n>
augroup END
]]
