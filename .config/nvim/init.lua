require 'jg.plugins'
require 'jg.disable_builtins'

local opt = vim.opt
local autocmds = require'jg.autocmds'

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

opt.listchars:append('tab:| ')
opt.listchars:append('trail:∙')
opt.listchars:append('extends:>')
opt.listchars:append('precedes:<')
opt.listchars:append('nbsp:‡')

opt.showbreak = '↪ '
opt.breakindentopt = 'shift:2'

-- Indentation
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

opt.undofile = true

-- Redrawing
opt.lazyredraw = true

opt.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic'

-- Allow the cursor to move anywhere in visual block mode
opt.virtualedit = 'block'

-- Open splits to the right and to the bottom
opt.splitbelow = true
opt.splitright = true

autocmds.augroup('resize_splits', function(autocmd)
  autocmd('VimResized', { command = ':wincmd =' })
end)

autocmds.augroup('highlight_yank', function(autocmd)
  autocmd('TextYankPost', { callback = function() vim.highlight.on_yank { higroup='DiffAdd', timeout=130 } end })
end)

autocmds.augroup('cwindow_after_grep', function(autocmd)
  autocmd('QuickFixCmdPost', { pattern = '[^l]*', command = 'cwindow'})
end)

autocmds.augroup('cursorline_follows_focus', function(autocmd)
  autocmd({'WinEnter', 'FocusGained'}, { command = 'set cursorline' })
  autocmd({'WinLeave', 'FocusLost'}, { command = 'set nocursorline' })
end)

function disable_cursorline_follows_focus()
  autocmds.augroup('cursorline_follows_focus', function() end)
end

-- Flash matching braces for 200ms
opt.showmatch = true
opt.matchtime = 2

-- Use ripgrep for vim's :grep command
vim.cmd [[if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif]]

vim.cmd [[if has('gui_running')
  " Remove scrollbars and menus from the GUI
  set guioptions=c
endif]]

-- }}}

-- Mappings {{{

-- Sanity {{{
-- These mappings improve consistency in Vim's commands

-- Saner line handling
vim.cmd [[nnoremap j gj]]
vim.cmd [[nnoremap k gk]]
vim.cmd [[nnoremap gj j]]
vim.cmd [[nnoremap gk k]]
vim.cmd [[xnoremap j gj]]
vim.cmd [[xnoremap k gk]]
vim.cmd [[xnoremap gj j]]
vim.cmd [[xnoremap gk k]]

-- :W and :Q still work
vim.cmd [[command! W write]]
vim.cmd [[command! Q quit]]
vim.cmd [[cabbrev <silent> X :x]]

-- Delete and paste without overwriting the paste register
vim.cmd [[nnoremap x "_x]]
vim.cmd [[xnoremap p "_dp]]

-- When joining lines, keep the cursor in place
vim.cmd [[nnoremap J mzJ`z]]

-- }}}

-- Edit/source configuration
vim.cmd [[nnoremap <silent> <leader>ec :edit $MYVIMRC<CR>]]
vim.cmd [[nnoremap <silent> <leader>sc :lua require'jg.config'.reload_config()<CR>]]

-- Remap H and L to start and end of the line
vim.cmd [[nnoremap H ^]]
vim.cmd [[nnoremap L g_]]
vim.cmd [[xnoremap H ^]]
vim.cmd [[xnoremap L g_]]

-- Easy split navigation
vim.cmd [[nnoremap <c-j> <c-w>j]]
vim.cmd [[nnoremap <c-k> <c-w>k]]
vim.cmd [[nnoremap <c-h> <c-w>h]]
vim.cmd [[nnoremap <c-l> <c-w>l]]

-- <leader>a selects the whole buffer
vim.cmd [[nnoremap <leader>a ggVG]]

-- gp selects the last pasted text
vim.cmd "nnoremap gp `[v`]"

-- <leader> shortcuts for copying/pasting to/from system clipboard
vim.cmd [[nnoremap <leader>y "+y]]
vim.cmd [[xnoremap <leader>y "+y]]
vim.cmd [[nnoremap <leader>p "+p]]
vim.cmd [[xnoremap <leader>p "+p]]

-- Shift-Q repeats the q macro
vim.cmd [[nnoremap Q @q]]
vim.cmd [[xnoremap Q :normal! @q<CR>]]

-- Quickly edit the Q macro
vim.cmd [[nnoremap <leader>eq :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left>]]

-- Go back to the last buffer
vim.cmd [[nnoremap <silent> <backspace> <C-^>]]

-- Use the arrow keys to resize viewports
vim.cmd [[nnoremap <Right> :vertical resize +2<CR>]]
vim.cmd [[nnoremap <Left> :vertical resize -2<CR>]]

-- }}}

-- Load jg/local.lua if it exists
pcall(require, "jg.local")

-- vim: set fdm=marker:
