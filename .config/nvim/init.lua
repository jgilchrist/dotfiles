require 'jg.plugins'
require 'jg.disable_builtins'

local opt = vim.opt
local augroup = require'jg.config'.augroup
local haslocalconfig,localconfig = pcall(require, 'jg.local')

-- Settings {{{

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Don't show the intro message when starting Vim
opt.shortmess:append('I')

-- Appearance
opt.number = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 3
opt.sidescrolloff = 3

opt.listchars:append('tab:| ')
opt.listchars:append('trail:∙')
opt.listchars:append('extends:>')
opt.listchars:append('precedes:<')
opt.listchars:append('nbsp:‡')

opt.showbreak = '↪ '
opt.breakindentopt = 'shift:2'

opt.wildmode='list:longest,full'

-- Indentation
opt.expandtab = true
opt.shiftround = true

-- Set these only globally so they do not override buffer-specific
-- settings when configuration is reloaded
vim.go.tabstop = 4
vim.go.softtabstop = 4
vim.go.shiftwidth = 4

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

-- Flash matching braces for 200ms
opt.showmatch = true
opt.matchtime = 2

opt.undofile = true

-- Redrawing
opt.lazyredraw = true

opt.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic'

-- Allow the cursor to move anywhere in visual block mode
opt.virtualedit = 'block'

-- Open splits to the right and to the bottom
opt.splitbelow = true
opt.splitright = true

augroup('resize_splits', function(autocmd)
  autocmd('VimResized', { command = ':wincmd =' })
end)

augroup('highlight_yank', function(autocmd)
  autocmd('TextYankPost', { callback = function() vim.highlight.on_yank { higroup='DiffAdd', timeout=130 } end })
end)

augroup('cwindow_after_grep', function(autocmd)
  autocmd('QuickFixCmdPost', { pattern = '[^l]*', command = 'cwindow'})
end)

augroup('cursorline_follows_focus', function(autocmd)
  autocmd({'WinEnter', 'FocusGained'}, { command = 'set cursorline' })
  autocmd({'WinLeave', 'FocusLost'}, { command = 'set nocursorline' })
end)

-- Use ripgrep for vim's :grep command
if vim.fn.executable('rg') then
  opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

-- }}}

-- Mappings {{{

-- Sanity {{{
-- These mappings improve consistency in Vim's commands

-- Saner line handling
vim.keymap.set({'n', 'x'}, 'j', 'gj')
vim.keymap.set({'n', 'x'}, 'k', 'gk')
vim.keymap.set({'n', 'x'}, 'gj', 'gj')
vim.keymap.set({'n', 'x'}, 'gk', 'gk')

-- :W and :Q still work
vim.api.nvim_create_user_command('W', 'write', { bang = true })
vim.api.nvim_create_user_command('Q', 'quit', { bang = true })
vim.cmd [[cabbrev <silent> X :x]]

-- Delete and paste without overwriting the paste register
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('x', 'p', '"_dp')

-- When joining lines, keep the cursor in place
vim.keymap.set('n', 'J', 'mzJ`z')

-- }}}

-- Edit/source configuration
vim.keymap.set('n', '<leader>ec', ':edit $MYVIMRC<CR>', { silent = true })
vim.keymap.set('n', '<leader>sc', require'jg.config'.reload_config, { silent = true })

-- Remap H and L to start and end of the line
vim.keymap.set({'n', 'x'}, 'H', '^')
vim.keymap.set({'n', 'x'}, 'L', 'g_')

-- Easy split navigation
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-l>', '<c-w>l')

-- gp selects the last pasted text
vim.keymap.set('n', 'gp', '`[v`')

-- <leader> shortcuts for copying/pasting to/from system clipboard
vim.keymap.set({'n', 'x'}, '<leader>y', '"+y')
vim.keymap.set({'n', 'x'}, '<leader>p', '"+p')

-- Shift-Q repeats the q macro
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('x', 'Q', ':normal! @q<CR>')

-- Quickly edit the Q macro
vim.keymap.set('n', '<leader>eq', [[:<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left>]])

-- Go back to the last buffer
vim.keymap.set('n', '<backspace>', '<C-^>', { silent = true })

-- Use the arrow keys to resize viewports
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>')
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>')

-- }}}

-- Load jg/local.lua if it exists
if haslocalconfig then
  localconfig.setup()
end

-- vim: set fdm=marker:
