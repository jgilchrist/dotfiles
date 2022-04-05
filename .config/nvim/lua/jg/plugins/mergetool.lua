vim.g.mergetool_layout = 'ml,b'
vim.g.mergetool_prefer_revision = 'remote'

-- TODO: Find a way to pass OnMergetoolSetLayout as a lua function
vim.cmd [[
function! OnMergetoolSetLayout(split)
  lua vim.wo.cursorline = false
  lua require'jg.config'.disable_cursorline_follows_focus()
  lua vim.keymap.set('n', '<leader>mt', ':MergetoolToggle<cr>')

  " When base is horizontal split at the bottom
  " Turn off diff mode, and show syntax highlighting
  " Also let it take less height
  if (a:split['layout'] ==# 'mr,b' || a:split['layout'] ==# 'ml,b') && a:split['split'] ==# 'b'
    lua vim.wo.diff = false
    lua vim.bo.syntax = 'OFF'
    resize 15
  endif
endfunction

let g:MergetoolSetLayoutCallback = function('OnMergetoolSetLayout')
]]
