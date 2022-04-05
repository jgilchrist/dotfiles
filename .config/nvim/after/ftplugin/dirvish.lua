-- gh hides dotfiles
vim.keymap.set('n', 'gh', ':g:\\v/\\.[^\\/]+/?$:d<cr>:noh<cr>', { buffer = true })
