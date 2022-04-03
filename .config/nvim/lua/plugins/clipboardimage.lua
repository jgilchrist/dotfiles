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
