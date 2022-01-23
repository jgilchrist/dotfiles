set runtimepath^=~/.vim/after
set runtimepath^=~/.vim

let &packpath = &runtimepath

source ~/.vim/vimrc

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = { enable = true, },
  indent = { enable = true, },
}

require'clipboard-image'.setup {
  default = {
    img_dir = {"%:p:h", "img"},
    img_name = function()
      vim.fn.inputsave()
      local name = vim.fn.input('Name: ')
      vim.fn.inputrestore()
      return name
    end,
  }
}
EOF
