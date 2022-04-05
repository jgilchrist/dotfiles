local M = {}

function M.augroup(name, autocmd_def_fn)
  vim.api.nvim_create_augroup(name, { clear = true })

  function define_autocmd_fn(event, opts)
    vim.api.nvim_create_autocmd(event, vim.tbl_extend('keep', opts, { group = name }))
  end

  autocmd_def_fn(define_autocmd_fn)
end

return M
