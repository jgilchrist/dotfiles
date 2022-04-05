vim.cmd [[
if exists('g:use_wiki')

  let g:wiki_link_extension = '.md'
  let g:wiki_link_target_type = 'md'
  let g:wiki_filetypes = ['md']
  let g:wiki_tags_format_pattern = '\v%(^|\s)#\zs[^# ]+'

  let g:wiki_map_create_page = 'WikiMapCreatePage'
  function! WikiMapCreatePage(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
  endfunction

  let g:wiki_map_link_create = 'WikiMapLinkCreate'
  function! WikiMapLinkCreate(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
  endfunction

  nnoremap <leader>ww :WikiFzfPages<CR>

  if !exists('g:wiki_root')
    echoerr 'g:wiki_root is not defined'
  endif

endif
]]
