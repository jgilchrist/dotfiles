local augroup = require'jg.config'.augroup
local packer = require'packer'

function bootstrap_packer()
  local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  end
end

bootstrap_packer()

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
  use 'tpope/vim-surround'
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

  use {'lervag/wiki.vim',
    config = plugin_config('wiki'),
    cmd = 'WikiFzfPages',
    setup = function()
      vim.keymap.set('n', '<leader>ww', ':WikiFzfPages<CR>')
    end
  }

  -- Experiments
  use {'dhruvasagar/vim-table-mode', cmd = { 'TableModeToggle' }}
  use {'ekickx/clipboard-image.nvim', config = plugin_config('clipboardimage'), ft = { 'markdown' }}
  -- use 'simrat39/rust-tools.nvim'
  -- use 'neovim/nvim-lspconfig'

end)

if packer_bootstrap then
  packer.sync()
end
