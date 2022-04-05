if not vim.g.wiki_root then
  vim.notify('g:wiki_root is not defined', vim.log.levels.ERROR)
  return
end

vim.g.wiki_link_extension = '.md'
vim.g.wiki_link_target_type = 'md'
vim.g.wiki_filetypes = {'md'}
vim.g.wiki_tags_format_pattern = '\\v%(^|\\s)#\\zs[^# ]+'

-- TODO: Find a way to pass WikiMapCreatePage and WikiMapLinkCreate as lua functions
vim.cmd[[
function! WikiMapCreatePage(text) abort
  return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

let g:wiki_map_create_page = 'WikiMapCreatePage'
]]

vim.cmd[[
function! WikiMapLinkCreate(text) abort
  return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

let g:wiki_map_link_create = 'WikiMapLinkCreate'
]]

vim.keymap.set('n', '<leader>ww', ':WikiFzfPages<CR>')
