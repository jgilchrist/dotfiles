vim.cmd [[let g:dirvish_mode = ':sort | sort ,^.*/,']]

-- Disable Dirvish's C-p and C-n mappings
vim.api.nvim_create_augroup('dirvish_unmap', { clear = true })
  vim.api.nvim_create_autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-p>', group = 'dirvish_unmap' })
  vim.api.nvim_create_autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-n>', group = 'dirvish_unmap' })
