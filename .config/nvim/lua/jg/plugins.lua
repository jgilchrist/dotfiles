function bootstrap_packer()
  local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  end
end

bootstrap_packer()

vim.api.nvim_create_augroup('packer_autocompile', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePost', { pattern = 'plugins.lua', command = 'source <afile> | PackerCompile', group = 'packer_autocompile' })

require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Extensions to vim's language
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'wellle/targets.vim'
  use {'phaazon/hop.nvim', config = function() require'jg.plugins.hop' end }
  use 'tommcdo/vim-exchange'
  use {'junegunn/vim-easy-align', config = function() require'jg.plugins.easyalign' end }

  -- File management
  use {'junegunn/fzf', run = ':call fzf#install()', config = function() require'jg.plugins.fzf' end }
  use 'junegunn/fzf.vim'

  use {'justinmk/vim-dirvish', config = function() require'jg.plugins.dirvish' end }

  use 'tpope/vim-unimpaired'
  use {'jgilchrist/vim-mergetool', config = function() require'jg.plugins.mergetool' end }

  -- Languages
  use 'rust-lang/rust.vim'
  use 'leafgarland/typescript-vim'
  use 'hashivim/vim-terraform'
  use 'PProvost/vim-ps1'

  -- Colorscheme
  use {'projekt0n/github-nvim-theme', config = function() require'jg.plugins.github' end }

  -- Extras
  use {'nvim-lualine/lualine.nvim',
    after = 'github-nvim-theme',
    config = function() require'jg.plugins.lualine' end,
  }

  use 'junegunn/goyo.vim'
  use 'editorconfig/editorconfig-vim'
  use {'lervag/wiki.vim', config = function() require'jg.plugins.wiki' end }

  -- Experiments
  use 'tpope/vim-abolish'
  use 'tpope/vim-characterize'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'dhruvasagar/vim-table-mode'
  -- use 'simrat39/rust-tools.nvim'
  -- use 'neovim/nvim-lspconfig'

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function() require'jg.plugins.treesitter' end }
  use {'ekickx/clipboard-image.nvim', config = function() require'jg.plugins.clipboardimage' end }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
