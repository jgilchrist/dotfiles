local M = {}

local util = require'jg.util'
local augroup = util.augroup

M.treesitter_parsers = {
  'bash',
  'c',
  'c_sharp',
  'cmake',
  'comment',
  'cpp',
  'css',
  'dockerfile',
  'html',
  'http',
  'java',
  'javascript',
  'jjdescription',
  'jsdoc',
  'json',
  'json5',
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
}

M.treesitter_filetypes = {
  'c_sharp',
  'lua',
  'markdown',
  'python',
  'rust',
  'typescript',
  'vue',
}

M.two_space_filetypes = {
  'javascript',
  'json',
  'lua',
  'typescript',
  'vue',
  'xml',
  'yaml',
}

M.text_mode_filetypes = {
  'markdown',
}

function M.setup()
  M.setup_default_indents()
  M.setup_text_mode()
end

-- Set up two-space indentation for some files
function M.setup_default_indents()
  augroup('ft_default_indent', function(autocmd)
    autocmd('FileType', {
      pattern = M.two_space_filetypes,
      callback = function ()
        vim.bo.tabstop = 2
      end
    })
  end)
end

function M.setup_text_mode()
  augroup('ft_text_mode', function(autocmd)
    autocmd('FileType', {
      pattern = M.text_mode_filetypes,
      callback = function ()
        M.use_text_mode()
      end
    })
  end)
end

function M.use_text_mode()
  vim.wo.wrap = true
  vim.wo.linebreak = true
end

return M
