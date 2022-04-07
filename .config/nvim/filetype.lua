vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

vim.filetype.add({
  filename = {
    ['Directory.Build.props'] = 'xml',
    ['Directory.Build.targets'] = 'xml',
    ['Justfile'] = 'make',
  },
})
