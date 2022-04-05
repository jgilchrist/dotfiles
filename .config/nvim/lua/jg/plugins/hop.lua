require'hop'.setup()

vim.cmd[[nnoremap s <nop>]]

vim.cmd[[nnoremap sw :HopWord<cr>]]
vim.cmd[[onoremap sw :HopWord<cr>]]

vim.cmd[[nnoremap sl :HopLineStart<cr>]]
vim.cmd[[onoremap sl :HopLineStart<cr>]]

vim.cmd[[nnoremap sc :HopChar1<cr>]]
vim.cmd[[onoremap sc :HopChar1<cr>]]

vim.cmd[[nnoremap ss :HopChar2<cr>]]
vim.cmd[[onoremap ss :HopChar2<cr>]]
