require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash',
    'c',
    'c_sharp',
    'cmake',
    'comment',
    'cpp',
    'css',
    'dockerfile',
    'go',
    'gomod',
    'graphql',
    'help',
    'html',
    'http',
    'java',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'kotlin',
    'lalrpop',
    'latex',
    'llvm',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'regex',
    'rst',
    'rust',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
  },
  highlight = { enable = true, additional_vim_regex_highlighting = { 'markdown' } },
  indent = { enable = true, },
}
