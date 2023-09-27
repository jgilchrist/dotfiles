local util = require'jg.util'

util.bootstrap_lazynvim()

local augroup = require'jg.config'.augroup
local lazy = require'lazy'
local lsp = require'jg.lsp'

local plugins = {
  'tpope/vim-repeat',

  {
    'nvim-treesitter/nvim-treesitter',
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
  'tpope/vim-repeat',

  {
    'numToStr/Comment.nvim',
    config = function()
      require'Comment'.setup()
    end,
  },

  {
    'kylechui/nvim-surround',
    config = function()
      require'nvim-surround'.setup()
    end,
  },

  'wellle/targets.vim',

  'tommcdo/vim-exchange',

  {
    'kana/vim-textobj-user',
    dependencies = {
      'glts/vim-textobj-comment',
      'kana/vim-textobj-entire',
      'kana/vim-textobj-line',
    },
  },

  -- File management
  {
    'junegunn/fzf',
    build = ':call fzf#install()',
  },

  {
    'junegunn/fzf.vim',
    config = function()
      vim.g.fzf_preview_window = {}

      vim.keymap.set('n', '<C-P>', ':Files<CR>')
      vim.keymap.set('n', '<C-G>', ':Rg<CR>')
      vim.keymap.set('n', '<C-B>', ':Buffers<CR>')
    end,
  },

  {
    'justinmk/vim-dirvish',
    config = function()
      vim.g.dirvish_mode = ':sort | sort ,^.*/,'

      -- Disable Dirvish's C-p and C-n mappings
      augroup('dirvish_unmap', function(autocmd)
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-p>' })
        autocmd('FileType', { pattern = 'dirvish', command = 'silent! unmap <buffer> <C-n>' })
      end)
    end,
  },

  'tpope/vim-eunuch',

  'tpope/vim-unimpaired',
  { 'tpope/vim-fugitive', cmd = {'Git'} },

  -- Colorscheme
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup()
      vim.cmd('colorscheme github_dark_high_contrast')
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
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

  -- Extras

  {
    'jgilchrist/vim-mergetool',
    config = function()
      vim.g.mergetool_layout = 'ml,b'
      vim.g.mergetool_prefer_revision = 'remote'

      vim.g.MergetoolSetLayoutCallback = function(split)
        vim.wo.cursorline = false
        require'jg.config'.disable_cursorline_follows_focus()
        vim.keymap.set('n', '<leader>mt', ':MergetoolToggle<cr>')

        -- Don't include the bottom pane in the diff, and make it smaller
        if split['split'] == 'b' then
          vim.wo.diff = false
          vim.cmd.resize('15')
        end
      end
    end,
    cmd = { 'MergetoolStart', 'MergetoolToggle' },
  },
}

local experimental_plugins = {
  {
    'mickael-menu/zk-nvim',
    dependencies = {
      'neovim/nvim-lspconfig'
    },
    config = function()
      local zk = require'zk'

      zk.setup({
        picker = "fzf",

        lsp = {
          config = {
            on_attach = lsp.on_attach,
          },
        },
      })

      local opts = { noremap=true, silent=false }

      -- Add the key mappings only for Markdown files in a zk notebook.
      if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
        local function map(...) vim.api.nvim_buf_set_keymap(0, ...) end

        -- Open the link under the caret.
        map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

        -- Create a new note after asking for its title.
        -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
        map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)

        -- Open notes linking to the current buffer.
        map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
        -- Alternative for backlinks using pure LSP and showing the source context.
        --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        -- Open notes linked by the current buffer.
        map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)

        -- Preview a linked note.
        map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
        -- Open the code actions for a visual selection.
        map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.code_action()<CR>", opts)
      end


      -- Open notes.
      vim.api.nvim_set_keymap("n", "<leader>zz", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)

      -- Open notes associated with the selected tags.
      vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)

      vim.keymap.set("n", "<leader>zn", function()
        vim.ui.input({ prompt = 'Title' }, function(title)
          if title ~= nil then
            require'zk.commands'.get('ZkNew')({ title = title })
          end
        end)
      end)

      vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)

      vim.keymap.set("n", "<leader>zf", function()
        vim.ui.input({ prompt = 'Search' }, function(query)
          print(query)
          if query ~= nil then
            require'zk.commands'.get('ZkNotes')({ sort = { 'modified' }, match = { query } })
          end
        end)
      end)

      -- Search for the notes matching the current visual selection.
      vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
    end
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function()
      local cmp = require'cmp'
      local t = require'jg.config'.replace_termcodes

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
      --  * Jump through slots in a snippet
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
      --  * Jump back through slots in a snippet
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

if vim.g.jg_load_experiments then
  vim.list_extend(lazy_plugins, experimental_plugins)
end

local haslocalconfig,localconfig = pcall(require, 'jg.local')
if haslocalconfig and localconfig.plugins ~= nil then
  vim.list_extend(lazy_plugins, localconfig.plugins)
end

lazy.setup(lazy_plugins, {
  install = {
    colorscheme = { 'github_dark_high_contrast' }
  },
})
