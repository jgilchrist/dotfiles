local M = {}

function M.setup()
  M.install_lsp_plugins()
  M.configure()

  vim.diagnostic.config {
    underline = false,
    virtual_text = {
      prefix = "",
      severity = nil,
      source = "if_many",
      format = nil,
    },
    signs = true,
    severity_sort = true,
    update_in_insert = false,
  }
end

function M.install_lsp_plugins()
  vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })
end

function M.configure()
  vim.lsp.enable({ "lua_ls" })
end

return M
