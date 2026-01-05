local util = require'jg.util'

local augroup = util.augroup

local function gh(repo)
  return 'https://github.com/' .. repo
end

local plugins = {
  { name = 'nvim-treesitter', src = gh('nvim-treesitter/nvim-treesitter'),
    install = function()
      vim.cmd(':TSUpdate')
    end,
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
          'html',
          'http',
          'java',
          'javascript',
          'jsdoc',
          'json',
          'json5',
          'jsonc',
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
  },

  -- Extensions to vim's language
  { name = 'vim-repeat', src = gh('tpope/vim-repeat') },

  { name = 'mini.extra', src = gh('echasnovski/mini.extra') }, -- Dependency of mini.a
  { name = 'mini.ai', src = gh('echasnovski/mini.ai'),
    config = function()
      require('mini.extra').setup()
      local ai = require('mini.ai')

      ai.setup({
        mappings = { around_last = '', inside_last = '', },

        custom_textobjects = {
          l = MiniExtra.gen_ai_spec.line(),
          e = MiniExtra.gen_ai_spec.buffer(),
        },
      })
    end
  },

  { name = 'nvim-surround', src = gh('kylechui/nvim-surround'), version = vim.version.range("3.x.x"),
    config = function()
      require'nvim-surround'.setup()
    end
  },
  { name = 'leap.nvim', src = 'https://codeberg.org/andyg/leap.nvim',
    config = function()
      local leap = require'leap'

      vim.keymap.set({'n', 'x'}, 's', '<Plug>(leap)')
      vim.keymap.set({'o'}, 'gs', '<Plug>(leap)')
      vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

      leap.opts.safe_labels = ''
    end
  },

  { name = 'vim-exchange', src = gh('tommcdo/vim-exchange') },

  -- File management
  { name = 'vim-dirvish', src = gh('justinmk/vim-dirvish'),
    config = function()
      vim.g.dirvish_mode = ':sort | sort ,^.*/,'

      -- Disable Dirvish's C-p and C-n mappings
      augroup('dirvish_unmap', function(autocmd)
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-p>' })
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-n>' })
      end)
    end
  },

  { name = 'fzf', src = gh('junegunn/fzf'),
    install = function()
      vim.cmd(':call fzf#install()')
    end
  },
  { name = 'fzf-lua', src = gh('ibhagwan/fzf-lua'),
    config = function()
      local fzflua = require'fzf-lua'

      fzflua.setup({
        files = {
          git_icons = false
        }
      })

      fzflua.register_ui_select()

      vim.keymap.set("n", "<C-P>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
      vim.keymap.set("n", "<C-G>", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
      vim.keymap.set("n", "<C-B>", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
    end
  },

  { name = 'vim-eunuch', src = gh('tpope/vim-eunuch') },

  { name = 'vim-fugitive', src = gh('tpope/vim-fugitive') },

  -- Appearance
  { name = 'github-nvim-theme', src = gh('projekt0n/github-nvim-theme'),
    config = function()
      require('github-theme').setup({
        options = {
          styles = {
            comments = 'italic'
          }
        }
      })

      vim.cmd('colorscheme github_dark_high_contrast')
    end
  },
  { name = 'lualine.nvim', src = gh('nvim-lualine/lualine.nvim'),
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
    end
  },

  -- Support for extra filetypes
  { name = 'pgsql.vim', src = gh('lifepillar/pgsql.vim') },

  -- Experiments
  { name = 'nvim-cmp', src = gh('hrsh7th/nvim-cmp'),
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
  },
  { name = 'cmp-buffer', src = gh('hrsh7th/cmp-buffer') },
  { name = 'cmp-path', src = gh('hrsh7th/cmp-path') },
  { name = 'cmp-cmdline', src = gh('hrsh7th/cmp-cmdline') },
  { name = 'cmp-nvim-lua', src = gh('hrsh7th/cmp-nvim-lua') },
  { name = 'cmp-nvim-lsp', src = gh('hrsh7th/cmp-nvim-lsp') },
}

for _, plugin in ipairs(plugins) do
  local plugin_def = { name = plugin.name, src = plugin.src }

  if plugin.version then
    plugin_def.version = plugin.version
  end

  vim.pack.add({ plugin_def })
end

for _, plugin in ipairs(plugins) do
  if plugin.config then
    plugin.config()
  end
end

augroup('jg_PackChanged', function(autocmd)
  autocmd('PackChanged', { callback = function(args)
    local spec = args.data.spec
    if not spec then return end

    local kind = args.data.kind
    if kind ~= 'update' then return end

    local plugin_name = spec.name

    for _, plugin in ipairs(plugins) do
      if plugin.name == plugin_name then
        if plugin.install then
          vim.schedule(plugin.install)
        end

        return
      end
    end

    vim.notify('Plugin ' .. plugin_name .. ' was updated but not found in plugin list', vim.log.levels.ERROR)
  end })
end)
