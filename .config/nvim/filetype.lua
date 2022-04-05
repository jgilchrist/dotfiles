vim.g.do_filetype_lua = 1

vim.filetype.add({
  filename = {
    ['Directory.Build.props'] = 'xml',
    ['Directory.Build.targets'] = 'xml',
    ['Justfile'] = 'make',
  },
})
