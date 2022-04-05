require'lualine'.setup({
  options = {
    theme = 'auto',
    icons_enabled = false,
    component_separators = { left='', right='' },
    section_separators = { left='', right='' },
  },
  sections = {
    -- Remove diff/diagnostics info section
    lualine_b = {},
  },
})
