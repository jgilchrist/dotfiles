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

  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {
            'vim',
            'require'
          },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })
end

return M
