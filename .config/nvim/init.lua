vim.cmd [[let mapleader=',']]
vim.cmd [[let maplocalleader=',']]

require 'jg.plugins'
require 'jg.disable_builtins'

-- Settings {{{

vim.cmd [[filetype plugin indent on]]

vim.cmd [[set encoding=utf-8]]
vim.cmd [[set fileencoding=utf-8]]

-- i - [noeol] instead of [Incomplete last line]
-- x - [unix] instead of [unix format]
-- t - Truncate file message at start if it is too long to fit on the command line
-- I - Don't show the intro message when starting Vim
vim.cmd [[set shortmess=ixtI]]

-- F - don't print filenames
vim.cmd [[if &diff
  set shortmess+=F
endif]]


-- Appearance
vim.cmd [[if !exists('g:syntax_on')
  syntax enable
endif]]

vim.cmd [[set hidden]]

vim.cmd [[set number]]
vim.cmd [[set ruler]]
vim.cmd [[set showcmd]]
vim.cmd [[set cursorline]]
vim.cmd [[set nowrap]]
vim.cmd [[set laststatus=2]]
vim.cmd [[set scrolloff=3]]
vim.cmd [[set sidescrolloff=3]]
vim.cmd [[set synmaxcol=300]]
vim.cmd [[set listchars=tab:\|\ ,trail:∙,extends:>,precedes:<,nbsp:‡]]
vim.cmd [[set showbreak=>\ ]]
vim.cmd [[set breakindentopt=shift:2]]

vim.cmd [[set wildmenu]]
vim.cmd [[set wildmode=list:longest,full]]

-- Indentation
vim.cmd [[set autoindent]]
vim.cmd [[set expandtab]]
vim.cmd [[set tabstop=4]]
vim.cmd [[set softtabstop=4]]
vim.cmd [[set shiftwidth=4]]
vim.cmd [[set shiftround]]
vim.cmd [[set backspace=indent,eol,start]]

-- Search
vim.cmd [[set incsearch]]
vim.cmd [[set ignorecase]]
vim.cmd [[set smartcase]]
vim.cmd [[set infercase]]

-- Redrawing
vim.cmd [[set lazyredraw]]
vim.cmd [[set ttyfast]]
vim.cmd [[set ttimeout]]
vim.cmd [[set ttimeoutlen=50]]

vim.cmd [[
if has('nvim') || has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif
]]

-- Disable all bells (audio, flash)
vim.cmd [[if exists("&belloff")
  set belloff=all
endif]]

-- Allow the cursor to move anywhere in visual block mode
vim.cmd [[set virtualedit=block]]

-- Automatically read the file if it changed outside vim
vim.cmd [[set autoread]]
vim.cmd [[set modeline]]
vim.cmd [[set modelines=1]]

-- Open splits to the right and to the bottom
vim.cmd [[set splitbelow]]
vim.cmd [[set splitright]]

-- Resize splits when vim itself is resized
vim.cmd [[augroup ResizeSplits
  au!
  au VimResized * :wincmd =
augroup END]]

-- Highlight yanked text briefly after it is yanked
vim.cmd [[augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=130 }
augroup END]]

-- Use a nice vertical separator for splits
vim.cmd [[set fillchars+=vert:│]]

-- Flash matching braces for 200ms
vim.cmd [[set showmatch]]
vim.cmd [[set matchtime=2]]

-- Don't search through includes for completion as this can be slow
vim.cmd [[set complete-=i]]

vim.cmd [[set nrformats-=octal]]

-- When joining lines, delete comment characters if appropriate
vim.cmd [[set formatoptions+=j]]
vim.cmd [[set nojoinspaces]]

-- Use ripgrep for vim's :grep command
vim.cmd [[if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif]]

vim.cmd [[augroup cwindow_after_grep
  autocmd!
  au QuickFixCmdPost [^l]* cwindow
augroup END]]

-- Only display the cursorline on windows that are in focus
vim.cmd [[augroup cursorline_follows_focus
  autocmd!
  au WinEnter * set cursorline
  au WinLeave * set nocursorline
  au FocusGained * set cursorline
  au FocusLost * set nocursorline
augroup END]]

vim.cmd [[function! s:disable_cursorline_follows_focus()
  if exists('#cursorline_follows_focus#WinEnter')
    augroup cursorline_follows_focus
      autocmd!
    augroup END
  endif
endfunction]]

-- Backups/Swapfiles/Undofiles {{{

-- Keep backups, swapfiles and undofiles if we're not root
vim.cmd [[if exists('$SUDO_USER')
  set viminfo=
  set nobackup
  set nowritebackup
  set noswapfile
  set noundofile
else
  if !has("nvim")
    set viminfo+=n~/.vim/tmp/viminfo
    set backupdir=~/.vim/tmp/backup
    set directory=~/.vim/tmp/swap
    set undodir=~/.vim/tmp/undo
  endif

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
