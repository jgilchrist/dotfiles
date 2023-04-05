local M = {}

local mason = require'mason'
local mason_lspconfig = require'mason-lspconfig'
local nvim_lsp = require'lspconfig'
local cmp_nvim_lsp = require'cmp_nvim_lsp'

local lsp_capabilities = cmp_nvim_lsp.default_capabilities()

mason.setup();
mason_lspconfig.setup {
  ensure_installed = { 'lua_ls', 'rust_analyzer' }
}

function M.on_attach(_, bufnr)
  local keybind_opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', keybind_opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', keybind_opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', keybind_opts)
  vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', keybind_opts)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keybind_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', keybind_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', keybind_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', keybind_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', keybind_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', keybind_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', keybind_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<space>ca', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", keybind_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', keybind_opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', keybind_opts)
end


nvim_lsp.lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = lsp_capabilities,
  settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'},
          disable = {'lowercase-global'}
        },
      },
    }
}

nvim_lsp.rust_analyzer.setup {
  on_attach = M.on_attach,
  capabilities = lsp_capabilities,
  settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          enable = true,
          command = "check",
          extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" },
        },
      }
    }
}

return M
