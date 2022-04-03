vim.cmd [[
augroup vimade_focus
  autocmd!
  autocmd FocusLost * VimadeFadeActive
  autocmd FocusGained * VimadeUnfadeActive
augroup END
]]
