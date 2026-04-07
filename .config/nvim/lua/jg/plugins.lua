local M = {}

local util = require'jg.util'
local lang = require'jg.lang'
local pack = require'jg.pack'
local augroup = util.augroup

local function gh(repo)
  return 'https://github.com/' .. repo
end

local plugins = {
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main',
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
  { src = gh 'nvim-mini/mini.extra' }, -- Dependency of mini.ai
  { src = gh 'nvim-mini/mini.ai',
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

  { src = gh 'nvim-mini/mini.surround',
    config = function()
      require('mini.surround').setup()
    end
  },

  { src = 'https://codeberg.org/andyg/leap.nvim',
    config = function()
      local leap = require'leap'

      vim.keymap.set({'n', 'x'}, 's', '<Plug>(leap)')
      vim.keymap.set({'o'}, 'gs', '<Plug>(leap)')
      vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

      leap.opts.safe_labels = ''
    end
  },

  { src = gh 'tommcdo/vim-exchange' },

  -- File management
  { src = gh 'justinmk/vim-dirvish',
    config = function()
      vim.g.dirvish_mode = ':sort | sort ,^.*/,'

      -- Disable Dirvish's C-p and C-n mappings
      augroup('dirvish_unmap', function(autocmd)
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-p>' })
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-n>' })
      end)
    end
  },

  { src = gh 'nvim-mini/mini.pick',
    config = function()
      require('mini.pick').setup()

      vim.keymap.set("n", "<C-P>", "<cmd>lua require('mini.pick').builtin.files({ tool = 'git' })<CR>", { silent = true })
      vim.keymap.set("n", "<C-G>", "<cmd>lua require('mini.pick').builtin.grep_live()<CR>", { silent = true })
      vim.keymap.set("n", "<C-B>", "<cmd>lua require('mini.pick').builtin.buffers()<CR>", { silent = true })
    end
  },

  -- Appearance
  { src = gh 'projekt0n/github-nvim-theme',
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

  { src = gh 'nvim-mini/mini.statusline',
    config = function ()
      local MiniStatusline = require'mini.statusline'

      MiniStatusline.setup({
        content = {
          active = function ()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })

            local function section_macro()
              local reg = vim.fn.reg_recording()
              if reg == "" then return "" end
              return "● REC @" .. reg
            end

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                     strings = { mode } },
              { hl = 'MiniStatuslineDevinfo',     strings = { diagnostics } },
              { hl = 'MiniStatuslineFilename',    strings = { filename } },
              { hl = 'DiffDelete',                strings = { section_macro() } },
              { hl = 'MiniStatuslineFilename',    strings = { '%<' } }, -- Mark general truncate point
              '%=', -- End left alignment
              { hl = mode_hl,                     strings = { '%l:%v' } },
            })
          end
        },

        use_icons = true
      })
    end
  },

  { src = gh 'saghen/blink.cmp',
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
  },

  -- LSP
  { src = gh 'neovim/nvim-lspconfig' },
  { src = gh 'mason-org/mason.nvim',
    config = function ()
      require'mason'.setup()
    end
  },
  { src = gh 'mason-org/mason-lspconfig.nvim',
    config = function ()
      local capabilities = require('blink.cmp').get_lsp_capabilities({})

      require'mason-lspconfig'.setup({
        ensure_installed = { 'lua_ls', 'rust_analyzer' },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({
              capabilities = capabilities,
            })
          end,
        }
      })
    end
  }
}

function M.setup()
  pack.setup(plugins)
end

return M
