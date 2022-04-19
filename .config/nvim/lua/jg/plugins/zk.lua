local zk = require'zk'
local jg_lsp = require'jg.plugins.lsp'

zk.setup({
  lsp = {
    config = {
      on_attach = jg_lsp.on_attach,
    },
  },
})

vim.keymap.set('n', '<leader>zz', ':ZkNotes <CR>')

vim.keymap.set("n", "<leader>zn", function()
  vim.ui.input({ prompt = 'Title' }, function(title)
    require'zk.commands'.get('ZkNew')({ title = title })
  end)
end)
