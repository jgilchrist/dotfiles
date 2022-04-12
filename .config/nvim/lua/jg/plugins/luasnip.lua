local luasnip = require'luasnip'
local snipmate_loader = require'luasnip.loaders.from_snipmate'

snipmate_loader.lazy_load()

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1

  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
  return true
else
  return false
end
end

_G.tab_complete = function()
if vim.fn.pumvisible() == 1 then
  return t "<C-n>"
  elseif luasnip and luasnip.expand_or_jumpable() then
    return t("<Plug>luasnip-expand-or-jump")
elseif check_back_space() then
  return t "<Tab>"
  end
  return ""
end

_G.s_tab_complete = function()
if vim.fn.pumvisible() == 1 then
  return t "<C-p>"
  elseif luasnip and luasnip.jumpable(-1) then
    return t("<Plug>luasnip-jump-prev")
else
  return t "<S-Tab>"
  end
  return ""
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<C-E>', '<Plug>luasnip-next-choice', {})
vim.api.nvim_set_keymap('s', '<C-E>', '<Plug>luasnip-next-choice', {})