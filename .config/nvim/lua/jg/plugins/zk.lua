local zk = require'zk'
local jg_lsp = require'jg.plugins.lsp'

zk.setup({
  picker = "fzf",

  lsp = {
    config = {
      on_attach = jg_lsp.on_attach,
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
