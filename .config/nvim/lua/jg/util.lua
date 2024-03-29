local M = {}

function M.bootstrap_lazynvim()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)
end

function M.reload_config()
  for name,_ in pairs(package.loaded) do
    -- Work round the fact that these modules would otherwise be loaded from the cache
    if name:match('^jg') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify('Reloaded!', vim.log.levels.INFO)
end

function M.augroup(name, autocmd_def_fn)
  vim.api.nvim_create_augroup(name, { clear = true })

  function define_autocmd_fn(event, opts)
    vim.api.nvim_create_autocmd(event, vim.tbl_extend('keep', opts, { group = name }))
  end

  autocmd_def_fn(define_autocmd_fn)
end

function M.use_indent(n)
  vim.bo.tabstop = n
  vim.bo.softtabstop = n
  vim.bo.shiftwidth = n
end

function M.use_text_mode()
  vim.wo.wrap = true
  vim.wo.linebreak = true
end

function M.disable_cursorline_follows_focus()
  M.augroup('cursorline_follows_focus', function() end)
end

function M.replace_termcodes(s)
  return vim.api.nvim_replace_termcodes(s, true, true, true)
end

return M
