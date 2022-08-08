require'jg.util'.bootstrap_packer()

local augroup = require'jg.config'.augroup
local packer = require'packer'
local haslocalconfig,localconfig = pcall(require, 'jg.local')

function plugin_config(n)
  return string.format([[require 'jg.plugins.%s']], n)
end

augroup('packer_autocompile', function(autocmd)
  autocmd('BufWritePost', { pattern = 'plugins.lua', command = 'source <afile> | PackerCompile' })
end)

packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = plugin_config('treesitter')}

  -- Extensions to vim's language
  use 'tpope/vim-repeat'
  use {'numToStr/Comment.nvim', config = plugin_config('comment')}
  use {'kylechui/nvim-surround', config = plugin_config('surround')}
  use 'wellle/targets.vim'
  use {'phaazon/hop.nvim', config = plugin_config('hop')}
  use 'tommcdo/vim-exchange'

  use 'kana/vim-textobj-user'
  use {'glts/vim-textobj-comment', after = 'vim-textobj-user' }
  use {'kana/vim-textobj-entire', after = 'vim-textobj-user' }
  use {'kana/vim-textobj-line', after = 'vim-textobj-user' }

  -- File management
  use {'junegunn/fzf', run = ':call fzf#install()' }
  use {'junegunn/fzf.vim', config = plugin_config('fzf')}

  use {'justinmk/vim-dirvish', config = plugin_config('dirvish')}
  use 'tpope/vim-eunuch'

  use 'tpope/vim-unimpaired'
  use {'tpope/vim-fugitive', cmd = {'Git'}}

  -- Colorscheme
  use {'projekt0n/github-nvim-theme', config = plugin_config('github')}

  -- Extras
  use {'nvim-lualine/lualine.nvim',
    after = 'github-nvim-theme',
    config = plugin_config('lualine')
  }

  use {'junegunn/goyo.vim', cmd = {'Goyo'}}
  use 'editorconfig/editorconfig-vim'
  use {'jgilchrist/vim-mergetool', config = plugin_config('mergetool'), cmd = { 'MergetoolStart', 'MergetoolToggle' } }

  -- Experiments
  use {'dhruvasagar/vim-table-mode', cmd = { 'TableModeToggle' }}
  use {'ekickx/clipboard-image.nvim', config = plugin_config('clipboardimage'), ft = { 'markdown' }}
  use {'L3MON4D3/LuaSnip', config = plugin_config('luasnip') }
  use {'mickael-menu/zk-nvim', config = plugin_config('zk') }
  use {'stevearc/dressing.nvim', config = plugin_config('dressing') }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = plugin_config('lsp')
  }

  use {'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
    },
    config = plugin_config('cmp')
  }

  if haslocalconfig then
    localconfig.plugins(use)
  end
end)

if packer_bootstrap then
  packer.sync()
end
