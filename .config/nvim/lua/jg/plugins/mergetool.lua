vim.g.mergetool_layout = 'ml,b'
vim.g.mergetool_prefer_revision = 'remote'

vim.g.MergetoolSetLayoutCallback = function(split)
  vim.wo.cursorline = false
  require'jg.config'.disable_cursorline_follows_focus()
  vim.keymap.set('n', '<leader>mt', ':MergetoolToggle<cr>')

  -- Don't include the bottom pane in the diff, and make it smaller
  if split['split'] == 'b' then
    vim.wo.diff = false
    vim.bo.syntax = 'OFF'
    vim.cmd [[resize 15]]
  end
end
