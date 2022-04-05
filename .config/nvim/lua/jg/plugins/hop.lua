require'hop'.setup()

vim.keymap.set('n', 's', '<nop>')

vim.keymap.set({'n', 'o'}, 'gt', ':HopChar1<CR>')
vim.keymap.set({'n', 'o'}, 'ga', ':HopAnywhereMW<CR>')
vim.keymap.set({'n', 'o'}, 'gw', ':HopWord<CR>')
