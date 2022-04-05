vim.g.mergetool_layout = 'ml,b'
vim.g.mergetool_prefer_revision = 'remote'

function on_mergetool_set_layout(split)
  vim.wo.cursorline = false
  require'jg.config'.disable_cursorline_follows_focus()
  vim.keymap.set('n', '<leader>mt', ':MergetoolToggle<cr>')

  -- When base is horizontal split at the bottom
  -- Turn off diff mode, and show syntax highlighting
  -- Also let it take less height
  vim.pretty_print(split)
  if (split['layout'] == 'mr,b' or split['layout'] == 'ml,b') and split['split'] == 'b' then
    vim.wo.diff = false
    vim.bo.syntax = 'OFF'
    vim.cmd [[resize 15]]
  end
end

vim.g.MergetoolSetLayoutCallback = on_mergetool_set_layout
