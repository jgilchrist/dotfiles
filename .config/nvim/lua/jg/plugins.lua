local M = {}

local util = require'jg.util'
local lang = require'jg.lang'

local augroup = util.augroup

local function gh(repo)
  return 'https://github.com/' .. repo
end

local plugins = {
  { name = 'nvim-treesitter', src = gh 'nvim-treesitter/nvim-treesitter', version = 'main',
    install = function()
      local treesitter = require'nvim-treesitter'
      treesitter.setup()
      treesitter.install(lang.treesitter_parsers)
    end,
    config = function()
      local treesitter = require'nvim-treesitter'
      treesitter.setup()

      augroup('treesitter_highlighting_enable', function(autocmd)
        autocmd('FileType', {
          pattern = lang.treesitter_filetypes,
          callback = function()
            vim.treesitter.start()
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end,
        })
      end)
    end
  },

  -- Extensions to vim's language
  { name = 'mini.extra', src = gh 'echasnovski/mini.extra' }, -- Dependency of mini.a
  { name = 'mini.ai', src = gh 'echasnovski/mini.ai',
    config = function()
      local MiniExtra = require('mini.extra')
      MiniExtra.setup()
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

  { name = 'nvim-surround', src = gh 'kylechui/nvim-surround', version = vim.version.range("4.x.x"),
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

  { name = 'vim-exchange', src = gh 'tommcdo/vim-exchange' },

  -- File management
  { name = 'vim-dirvish', src = gh 'justinmk/vim-dirvish',
    config = function()
      vim.g.dirvish_mode = ':sort | sort ,^.*/,'

      -- Disable Dirvish's C-p and C-n mappings
      augroup('dirvish_unmap', function(autocmd)
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-p>' })
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-n>' })
      end)
    end
  },

  { name = 'fzf', src = gh 'junegunn/fzf',
    install = function()
      vim.cmd(':call fzf#install()')
    end
  },
  { name = 'fzf-lua', src = gh 'ibhagwan/fzf-lua',
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

  { name = 'vim-eunuch', src = gh 'tpope/vim-eunuch' },

  { name = 'vim-fugitive', src = gh 'tpope/vim-fugitive' },

  -- Appearance
  { name = 'github-nvim-theme', src = gh 'projekt0n/github-nvim-theme',
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
  { name = 'lualine.nvim', src = gh 'nvim-lualine/lualine.nvim',
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

  { name = 'saghen/blink.cmp', src = gh 'saghen/blink.cmp',
    version = vim.version.range("v1.x.x"),
    install = function()
      vim.cmd(':BlinkCmp build')
    end,
    config = function()
      require'blink.cmp'.setup({
        keymap = { preset = 'super-tab' },

        completion = {
          documentation = { auto_show = true },
          ghost_text = { enabled = true },
        },

        cmdline = {
          keymap = { preset = 'inherit' },
          completion = {
            menu = { auto_show = true },
          },
        },

        sources = {
          providers = {
            buffer = {
              min_keyword_length = 4
            },

            lsp = {
              -- Don't include keywords in autocomplete
              transform_items = function(_, items)
                return vim.tbl_filter(function(item)
                  return item.kind ~= require('blink.cmp.types').CompletionItemKind.Keyword
                end, items)
              end,
            },
          }
        }
      })
    end
  }
}

function M.setup()
  local plugin_defs = {}

  for _, plugin in ipairs(plugins) do
    local plugin_def = { name = plugin.name, src = plugin.src }

    if plugin.version then
      plugin_def.version = plugin.version
    end


    table.insert(plugin_defs, plugin_def)
  end

  vim.pack.add(plugin_defs)

  for _, plugin in ipairs(plugins) do
    if plugin.config then
      plugin.config()
    end
  end

  augroup('pack_changed', function(autocmd)
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
end

return M
