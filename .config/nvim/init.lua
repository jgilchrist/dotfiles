local localconfig = require'jg.local'
localconfig.preconfig()

require'vim._extui'.enable({})

vim.g.mapleader = ','
vim.g.maplocalleader = ','

require 'jg.plugins'
require 'jg.disable_builtins'
local util = require 'jg.util'

-- Settings {{{

local o = vim.o
local opt = vim.opt
local augroup = util.augroup

-- Don't show the intro message when starting Vim
vim.opt.shortmess:append('I')

-- Appearance
o.number = true
o.cursorline = true
o.wrap = false
o.scrolloff = 3
o.sidescrolloff = 3

opt.listchars:append('tab:| ')
opt.listchars:append('trail:∙')
opt.listchars:append('extends:>')
opt.listchars:append('precedes:<')
opt.listchars:append('nbsp:‡')

o.showbreak = '↪ '
o.breakindentopt = 'shift:2'

o.wildmode='list:longest,full'

-- Indentation
o.expandtab = true
o.shiftround = true

-- Don't set tabstop if we're reloading config, as we might ovewrite
-- buffer-local values that have been set by after/
if util.is_first_load() then
  vim.opt.tabstop = 4
end

-- Use the tabstop value
vim.opt.shiftwidth = 0

-- Use the shiftwidth value
vim.opt.softtabstop = -1

-- Search
o.ignorecase = true
o.smartcase = true
o.infercase = true

-- Flash matching braces for 200ms
o.showmatch = true
o.matchtime = 2

o.undofile = true

-- Redrawing
o.lazyredraw = true

o.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic'

-- Allow the cursor to move anywhere in visual block mode
o.virtualedit = 'block'

-- Open splits to the right and to the bottom
o.splitbelow = true
o.splitright = true

-- Use a border around floating windows
o.winborder = 'rounded'

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
  o.grepprg = 'rg --vimgrep --no-heading --smart-case'
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
vim.cmd.cabbrev('<silent> X :x')

-- Delete and paste without overwriting the paste register
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('x', 'p', '"_dp')

-- When joining lines, keep the cursor in place
vim.keymap.set('n', 'J', 'mzJ`z')

-- }}}

-- Edit/source configuration
vim.keymap.set('n', '<leader>ec', ':edit $MYVIMRC<CR>', { silent = true })
vim.keymap.set('n', '<leader>sc', util.reload_config, { silent = true })

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

-- }}}

localconfig.postconfig()

-- vim: set fdm=marker:
