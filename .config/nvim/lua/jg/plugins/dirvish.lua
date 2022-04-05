local augroup = require'jg.config'.augroup

vim.g.dirvish_mode = ':sort | sort ,^.*/,'

-- Disable Dirvish's C-p and C-n mappings
augroup('dirvish_unmap', function(autocmd)
  autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-p>' })
  autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-n>' })
end)
