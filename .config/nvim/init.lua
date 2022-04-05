vim.cmd [[let mapleader=',']]
vim.cmd [[let maplocalleader=',']]

require 'jg.plugins'
require 'jg.disable_builtins'

-- Settings {{{

-- Don't show the intro message when starting Vim
vim.cmd [[set shortmess+=I]]

-- Appearance
vim.cmd [[set number]]
vim.cmd [[set cursorline]]
vim.cmd [[set nowrap]]
vim.cmd [[set scrolloff=3]]
vim.cmd [[set listchars=tab:\|\ ,trail:∙,extends:>,precedes:<,nbsp:‡]]
vim.cmd [[set showbreak=>\ ]]
vim.cmd [[set breakindentopt=shift:2]]

-- Indentation
vim.cmd [[set expandtab]]
vim.cmd [[set tabstop=4]]
vim.cmd [[set softtabstop=4]]
vim.cmd [[set shiftwidth=4]]
vim.cmd [[set shiftround]]

-- Search
vim.cmd [[set ignorecase]]
vim.cmd [[set smartcase]]
vim.cmd [[set infercase]]

-- Redrawing
vim.cmd [[set lazyredraw]]

vim.cmd [[set diffopt=filler,internal,algorithm:histogram,indent-heuristic]]

-- Allow the cursor to move anywhere in visual block mode
vim.cmd [[set virtualedit=block]]

-- Open splits to the right and to the bottom
vim.cmd [[set splitbelow]]
vim.cmd [[set splitright]]

vim.api.nvim_create_augroup('resize_splits', { clear = true })
  vim.api.nvim_create_autocmd('VimResized', { command = ':wincmd =', group = 'resize_splits' })

vim.api.nvim_create_augroup('highlight_yank', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', { callback = function() vim.highlight.on_yank { higroup='DiffAdd', timeout=130 } end, group = 'highlight_yank' })

vim.api.nvim_create_augroup('cwindow_after_grep', { clear = true })
  vim.api.nvim_create_autocmd('QuickFixCmdPost', { pattern = '[^l]*', command = 'cwindow', group = 'cwindow_after_grep' })

vim.api.nvim_create_augroup('cursorline_follows_focus', { clear = true })
  vim.api.nvim_create_autocmd('WinEnter', { command = 'set cursorline', group='cursorline_follows_focus' })
  vim.api.nvim_create_autocmd('WinLeave', { command = 'set nocursorline', group='cursorline_follows_focus' })
  vim.api.nvim_create_autocmd('FocusGained', { command = 'set cursorline', group='cursorline_follows_focus' })
  vim.api.nvim_create_autocmd('FocusLost', { command = 'set nocursorline', group='cursorline_follows_focus' })

-- Flash matching braces for 200ms
vim.cmd [[set showmatch]]
vim.cmd [[set matchtime=2]]

-- Use ripgrep for vim's :grep command
vim.cmd [[if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif]]

function disable_cursorline_follows_focus()
  vim.api.nvim_create_augroup('CursorlineFollowsFocus', { clear = true })
end

-- Backups/Swapfiles/Undofiles {{{

-- Keep backups, swapfiles and undofiles if we're not root
vim.cmd [[if exists('$SUDO_USER')
  set viminfo=
  set nobackup
  set nowritebackup
  set noswapfile
  set noundofile
else
  set undofile
endif]]

-- }}}

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
function reload_config()
  for name,_ in pairs(package.loaded) do
    -- Work round the fact that these modules would otherwise be loaded from the cache
    if name:match('^jg') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  require'packer'.compile()
  vim.notify('Reloaded!', vim.log.levels.INFO)
end

vim.cmd [[nnoremap <silent> <leader>ec :edit $MYVIMRC<CR>]]
vim.cmd [[nnoremap <silent> <leader>sc :lua reload_config()<CR>]]

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

vim.cmd [[runtime init.local.vim]]

-- vim: set fdm=marker:
