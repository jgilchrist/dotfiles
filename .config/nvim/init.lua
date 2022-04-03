vim.cmd [[let mapleader=',']]
vim.cmd [[let maplocalleader=',']]

-- Plugins {{{

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Extensions to vim's language
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'wellle/targets.vim'
  use 'justinmk/vim-sneak'
  use 'tommcdo/vim-exchange'
  use 'junegunn/vim-easy-align'

  -- File management
  use {'junegunn/fzf', run = ':call fzf#install()'}
  use 'junegunn/fzf.vim'

  use 'justinmk/vim-dirvish'

  use 'tpope/vim-unimpaired'
  use 'jgilchrist/vim-mergetool'

  -- Languages
  use 'rust-lang/rust.vim'
  use 'leafgarland/typescript-vim'
  use 'hashivim/vim-terraform'
  use 'PProvost/vim-ps1'

  -- Colorscheme
  use 'w0ng/vim-hybrid'
  use 'cormacrelf/vim-colors-github'
  use 'TaDaa/vimade'

  -- Extras
  use 'itchyny/lightline.vim'
  use 'junegunn/goyo.vim'
  use 'editorconfig/editorconfig-vim'

  -- Experiments
  use 'tpope/vim-abolish'
  use 'tpope/vim-characterize'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'lervag/wiki.vim'
  use 'dhruvasagar/vim-table-mode'
  -- use 'phaazon/hop.nvim'
  -- use 'simrat39/rust-tools.nvim'
  -- use 'neovim/nvim-lspconfig'

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'ekickx/clipboard-image.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd [[runtime macros/matchit.vim]]

vim.cmd [[xmap ga <Plug>(EasyAlign)]]
vim.cmd [[nmap ga <Plug>(EasyAlign)]]

vim.cmd [[nnoremap <C-P> :Files<CR>]]
vim.cmd [[nnoremap <C-B> :Buffers<CR>]]
vim.cmd "let g:fzf_preview_window = []"

vim.cmd [[let g:dirvish_mode = ':sort | sort ,^.*/,']]
-- Disable Dirvish's C-p and C-n mappings
vim.cmd [[
augroup dirvish_config
  autocmd!
  autocmd FileType dirvish silent! unmap <buffer> <C-p>
  autocmd FileType dirvish silent! unmap <buffer> <C-n>
augroup END
]]

vim.cmd [[
augroup vimade_focus
  autocmd!
  autocmd FocusLost * VimadeFadeActive
  autocmd FocusGained * VimadeUnfadeActive
augroup END
]]

-- }}}

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
vim.cmd [[colorscheme hybrid]]
vim.cmd [[highlight Comment cterm=italic gui=italic]]
vim.cmd [[set background=dark]]

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
vim.cmd [[nnoremap <leader>ec :edit $MYVIMRC<cr>]]
vim.cmd [[nnoremap <leader>el :edit $MYVIMRC.local<cr>]]
vim.cmd [[nnoremap <leader>sc :source $MYVIMRC<cr>]]

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

-- Mergetool {{{

vim.cmd [[function! OnMergetoolSetLayout(split)
  setlocal nocursorline
  call s:disable_cursorline_follows_focus()

  nnoremap <leader>mt :MergetoolToggle<cr>

  " When base is horizontal split at the bottom
  " Turn off diff mode, and show syntax highlighting
  " Also let it take less height
  if (a:split["layout"] ==# 'mr,b' || a:split["layout"] ==# 'ml,b') && a:split["split"] ==# 'b'
    setlocal nodiff
    setlocal syntax=off
    resize 15
  endif
endfunction]]

vim.cmd [[let g:mergetool_layout = 'ml,b']]
vim.cmd [[let g:mergetool_prefer_revision = 'remote']]
vim.cmd [[let g:MergetoolSetLayoutCallback = function('OnMergetoolSetLayout')]]

-- }}}

vim.cmd [[runtime init.local.vim]]

vim.cmd [[
if exists("g:use_wiki")
" Wiki {{{
let g:wiki_link_extension = '.md'
let g:wiki_link_target_type = 'md'
let g:wiki_filetypes = ['md']
let g:wiki_tags_format_pattern = '\v%(^|\s)#\zs[^# ]+'

let g:wiki_map_create_page = 'WikiMapCreatePage'
function! WikiMapCreatePage(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

let g:wiki_map_link_create = 'WikiMapLinkCreate'
function! WikiMapLinkCreate(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

nnoremap <leader>ww :WikiFzfPages<CR>

if !exists("g:wiki_root")
    echoerr "g:wiki_root is not defined"
endif
" }}}
endif
]]

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true, },
  indent = { enable = true, },
}

require'clipboard-image'.setup {
  default = {
    img_dir = {"%:p:h", "img"},
    img_name = function()
      vim.fn.inputsave()
      local name = vim.fn.input('Name: ')
      vim.fn.inputrestore()
      return name
    end,
  }
}

-- vim: set fdm=marker:
