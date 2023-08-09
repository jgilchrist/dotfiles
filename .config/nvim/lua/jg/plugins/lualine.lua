require'lualine'.setup({
  options = {
    theme = 'auto',
    component_separators = '',
    section_separators = '',
  },
  sections = {
    -- Remove diff/diagnostics info section
    lualine_b = {},
    -- Remove encoding and file format/type section
    lualine_x = {},
    -- Remove progress % section
    lualine_y = {''},
  },
})
