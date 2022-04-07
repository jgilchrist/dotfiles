if not vim.g.wiki_root then
  vim.notify('g:wiki_root is not defined', vim.log.levels.ERROR)
  return
end

vim.g.wiki_link_extension = '.md'
vim.g.wiki_link_target_type = 'md'
vim.g.wiki_filetypes = {'md'}
vim.g.wiki_tags_format_pattern = '\\v%(^|\\s)#\\zs[^# ]+'

function snakecase(text)
  return text:lower():gsub('%s+', '-')
end

vim.g.wiki_map_create_page = snakecase
vim.g.wiki_map_link_create = snakecase
