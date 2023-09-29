require'jg.util'.use_text_mode()

if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  vim.wo.conceallevel=2

  -- <CR> opens links in normal mode
  vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", { noremap=true, silent=false })

  -- <CR> creates a new page in select mode
  vim.api.nvim_buf_set_keymap(0, 'x', '<CR>', ':ZkNewFromTitleSelection { edit = false }<CR>', { noremap=true, silent=false })
end
