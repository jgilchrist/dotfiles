local cmp = require'cmp'
local luasnip = require'luasnip'
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
  elseif luasnip.jumpable() then
    vim.fn.feedkeys(t('<Plug>luasnip-expand-or-jump'), '')
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
  elseif luasnip.jumpable(-1) then
    vim.fn.feedkeys(t('<Plug>luasnip-jump-prev'), '')
  else
    fallback()
  end
end

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = tab_mapping,
    ['<S-Tab>'] = shift_tab_mapping,
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  },
  sources = cmp.config.sources(
    {
      { name = 'nvim_lsp' },
      { name = 'luasnip', option = { use_show_condition = false } },
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
  sources = {
    { name = 'buffer', keyword_length = 6 }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources(
    {
      { name = 'path', keyword_length = 5 },
    },
    {
      { name = 'cmdline', keyword_length = 3 },
    }
  ),
})
