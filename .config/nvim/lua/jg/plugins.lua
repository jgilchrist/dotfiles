local util = require'jg.util'

local augroup = util.augroup

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add({
  gh('nvim-treesitter/nvim-treesitter'),

  -- Extensions to vim's language
  gh('tpope/vim-repeat'),

  gh('echasnovski/mini.extra'), -- Dependency of mini.ai
  gh('echasnovski/mini.ai'),

  { src = gh('kylechui/nvim-surround'), version = vim.version.range("3.x.x") },
  gh('ggandor/leap.nvim'),

  gh('tommcdo/vim-exchange'),

  -- File management
  gh('justinmk/vim-dirvish'),

  gh('junegunn/fzf'),
  gh('ibhagwan/fzf-lua'),

  gh('tpope/vim-eunuch'),

  gh('tpope/vim-fugitive'),

  -- Appearance
  gh('projekt0n/github-nvim-theme'),
  gh('nvim-lualine/lualine.nvim'),

  -- Support for extra filetypes
  gh('lifepillar/pgsql.vim'),

  -- Experiments
  gh('hrsh7th/nvim-cmp'),
  gh('hrsh7th/cmp-buffer'),
  gh('hrsh7th/cmp-path'),
  gh('hrsh7th/cmp-cmdline'),
  gh('hrsh7th/cmp-nvim-lua'),
})

augroup('jg_PackChanged', function(autocmd)
  autocmd('PackChanged', { callback = function(args)
    vim.notify(vim.inspect(args))

    local spec = args.data.spec
    if not spec then return end

    local kind = args.data.kind
    if kind ~= 'update' then return end

    local plugin = spec.name

    local pack_changed_fn = nil

    if plugin == 'fzf' then
      pack_changed_fn = function()
        vim.cmd(':call fzf#install()')
      end
    end

    if plugin == 'nvim-treesitter' then
      pack_changed_fn = function()
        vim.cmd(':TSUpdate')
      end
    end

    if fn then
      vim.schedule(pack_changed_fn)
    end
  end })
end)

function configure_nvimsurround()
  require'nvim-surround'.setup()
end
configure_nvimsurround()

function configure_treesitter()
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
end
configure_treesitter()

function configure_dirvish()
  vim.g.dirvish_mode = ':sort | sort ,^.*/,'

  -- Disable Dirvish's C-p and C-n mappings
  augroup('dirvish_unmap', function(autocmd)
    autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-p>' })
    autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-n>' })
  end)
end
configure_dirvish()

function configure_miniai()
  require('mini.extra').setup()

  local ai = require('mini.ai')

  ai.setup({
    mappings = {
      around_last = '',
      inside_last = '',
    },

    custom_textobjects = {
      l = MiniExtra.gen_ai_spec.line(),
      e = MiniExtra.gen_ai_spec.buffer(),
    },
  })
end
configure_miniai()

function configure_leap()
  local leap = require'leap'
  leap.add_default_mappings()
end
configure_leap()

function configure_fzflua()
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
end
configure_fzflua()

function configure_colorscheme()
  require('github-theme').setup({
    options = {
      styles = {
        comments = 'italic'
      }
    }
  })

  vim.cmd('colorscheme github_dark_high_contrast')
end
configure_colorscheme()

function configure_lualine()
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
end
configure_lualine()

function configure_cmp()
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
        { name = 'buffer', keyword_length = 4 },
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
end
configure_cmp()
