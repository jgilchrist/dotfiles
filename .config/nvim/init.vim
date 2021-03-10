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
EOF
