local _, localconfig = pcall(require, 'jg.local')
if localconfig.preconfig then localconfig.preconfig() end

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Edit config - map this first so it still works if config loading fails
vim.keymap.set('n', '<leader>ec', ':edit $MYVIMRC<CR>', { silent = true })

require'jg.disable_builtins'
require'jg.plugins'.setup()
require'jg.lang'.setup()

-- Settings {{{

local util = require 'jg.util'
local augroup = util.augroup

-- UI2
vim.o.cmdheight = 0
require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
})


-- Don't show the intro message when starting Vim
vim.opt.shortmess:append('I')

-- Appearance
vim.o.number = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.scrolloff = 3
vim.o.sidescrolloff = 3

vim.opt.listchars:append('tab:| ')
vim.opt.listchars:append('trail:∙')
vim.opt.listchars:append('extends:>')
vim.opt.listchars:append('precedes:<')
vim.opt.listchars:append('nbsp:‡')

vim.o.showbreak = '↪ '
vim.o.breakindentopt = 'shift:2'

vim.o.wildmode='list:longest,full'

-- Indentation
vim.o.expandtab = true
vim.o.shiftround = true

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
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.infercase = true

-- Flash matching braces for 200ms
vim.o.showmatch = true
vim.o.matchtime = 2

vim.o.undofile = true

-- Redrawing
vim.o.lazyredraw = true

-- Switch to recommended linematch:60 diffopt and enable the histogram algorithm
vim.opt.diffopt:remove('linematch:40')
vim.opt.diffopt:append('linematch:60')
vim.opt.diffopt:append('algorithm:histogram')

-- Allow the cursor to move anywhere in visual block mode
vim.o.virtualedit = 'block'

-- Open splits to the right and to the bottom
vim.o.splitbelow = true
vim.o.splitright = true

-- Use a border around floating windows
vim.o.winborder = 'rounded'

-- Configure diagnostics
vim.diagnostic.config({
  underline = false,
  virtual_text = {
    prefix = "",
    severity = nil,
    source = "if_many",
    format = nil,
  },
  signs = true,
  severity_sort = true,
  update_in_insert = false,
})

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
  vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
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

-- Source configuration
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

if localconfig.postconfig then localconfig.postconfig() end

-- vim: set fdm=marker:
