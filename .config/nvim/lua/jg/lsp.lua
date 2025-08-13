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
  vim.pack.add({
    { name = 'nvim-lspconfig', src = 'https://github.com/neovim/nvim-lspconfig' },
    { name = 'mason', src = 'https://github.com/mason-org/mason.nvim' },
    { name = 'mason-lspconfig', src = 'https://github.com/mason-org/mason-lspconfig.nvim' }
  })
end

function M.configure()
  require'mason'.setup()
  require'mason-lspconfig'.setup({
    ensure_installed = { 'lua_ls', 'rust_analyzer' },
    handlers = {
      function(server_name)
        require('lspconfig')[server_name].setup({})
      end,
    }
  })
end

return M
