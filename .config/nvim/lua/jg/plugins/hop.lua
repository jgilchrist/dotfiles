require'hop'.setup()

vim.keymap.set('n', 's', '<nop>')

vim.keymap.set({'n', 'o'}, 'sw', ':HopWord<cr>')
vim.keymap.set({'n', 'o'}, 'sl', ':HopLineStart<cr>')
vim.keymap.set({'n', 'o'}, 'sc', ':HopChar1<cr>')
vim.keymap.set({'n', 'o'}, 'ss', ':HopChar2<cr>')
