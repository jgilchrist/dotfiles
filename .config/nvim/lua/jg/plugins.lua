local util = require'jg.util'

util.bootstrap_lazynvim()

local augroup = util.augroup
local lazy = require'lazy'
local lsp = require'jg.lsp'

local plugins = {
  { 'tpope/vim-repeat' },

  { 'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          'bash',
          'c',
          'c_sharp',
          'cmake',
          'comment',
          'cpp',
          'css',
          'dockerfile',
          'go',
          'gomod',
          'graphql',
          'html',
          'http',
          'java',
          'javascript',
          'jsdoc',
          'json',
          'json5',
          'jsonc',
          'kotlin',
          'latex',
          'llvm',
          'lua',
          'make',
          'markdown',
          'markdown_inline',
          'python',
          'query',
          'regex',
          'rst',
          'rust',
          'scss',
          'toml',
          'tsx',
          'typescript',
          'vim',
          'vue',
          'yaml',
        },
        highlight = { enable = true, additional_vim_regex_highlighting = { 'markdown' } },
        indent = { enable = true, },
      }
    end,
  },

  -- Extensions to vim's language
  { 'tpope/vim-repeat' },

  { 'kylechui/nvim-surround',
    config = function()
      require'nvim-surround'.setup()
    end,
  },

  { 'wellle/targets.vim' },

  { 'ggandor/leap.nvim',
    config = function()
      local leap = require'leap'
      leap.add_default_mappings()
    end
  },

  { 'tommcdo/vim-exchange' },

  { 'kana/vim-textobj-user',
    dependencies = {
      'glts/vim-textobj-comment',
      'kana/vim-textobj-entire',
      'kana/vim-textobj-line',
    },
  },

  -- File management
  { 'junegunn/fzf',
    build = ':call fzf#install()',
  },

  { 'ibhagwan/fzf-lua',
    config = function()
      require'fzf-lua'.setup({
        files = {
          git_icons = false
        }
      })

      vim.keymap.set("n", "<C-P>",
        "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })

      vim.keymap.set("n", "<C-G>",
        "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })

      vim.keymap.set("n", "<C-B>",
        "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
    end,
  },

  { 'justinmk/vim-dirvish',
    config = function()
      vim.g.dirvish_mode = ':sort | sort ,^.*/,'

      -- Disable Dirvish's C-p and C-n mappings
      augroup('dirvish_unmap', function(autocmd)
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-p>' })
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-n>' })
      end)
    end,
  },

  { 'tpope/vim-eunuch' },

  { 'tpope/vim-unimpaired' },

  { 'tpope/vim-fugitive',
    cmd = {'Git'}
  },

  -- Colorscheme
  { 'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({
        options = {
          styles = {
            comments = 'italic'
          }
        }
      })

      vim.cmd('colorscheme github_dark_high_contrast')
    end,
  },

  { 'nvim-lualine/lualine.nvim',
    config = function()
      require'lualine'.setup({
        options = {
          theme = 'auto',
          component_separators = '',
          section_separators = '',
        },
        sections = {
          -- Remove diff/diagnostics info section
          lualine_b = {},
          -- Remove encoding and file format/type section
          lualine_x = {},
          -- Remove progress % section
          lualine_y = {''},
        },
      })
    end,
  },

  -- Support for extra filetypes
  { 'lifepillar/pgsql.vim' },

  -- Extras

  { 'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function()
      local cmp = require'cmp'
      local t = require'jg.util'.replace_termcodes

      local function check_backspace()
        local col = vim.fn.col('.') - 1

        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
          return true
        else
          return false
        end
      end

      -- Either:
      --  * Tab through a popup menu
      --  * Comfirm a cmp item
      --  * Default
      local function tab_mapping(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t('<C-n>'), 'n')
        elseif not check_backspace() then
          cmp.mapping.confirm({select = true})(fallback)
        else
          fallback()
        end
      end

      -- Either:
      --  * Untab through a popup menu
      --  * Default
      local function shift_tab_mapping(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t('<C-p>'), 'n')
        else
          fallback()
        end
      end

      cmp.setup({
        mapping = cmp.mapping.preset.insert{
          ['<Tab>'] = tab_mapping,
          ['<S-Tab>'] = shift_tab_mapping,
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        },
        sources = cmp.config.sources(
          {
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
          },
          {
            { name = 'buffer', keyword_length = 6 },
          }
        ),
        experimental = {
          ghost_text = true,
        },
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer', keyword_length = 6 }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {
            { name = 'path', keyword_length = 5 },
          },
          {
            { name = 'cmdline', keyword_length = 3 },
          }
        ),
      })
    end,
  },

}

local lazy_plugins = plugins

local haslocalconfig,localconfig = pcall(require, 'jg.local')
if haslocalconfig and localconfig.plugins ~= nil then
  vim.list_extend(lazy_plugins, localconfig.plugins)
end

lazy.setup(lazy_plugins, {
  install = {
    colorscheme = { 'github_dark_high_contrast' }
  },
})
