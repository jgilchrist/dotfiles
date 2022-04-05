local M = {}

function M.reload_config()
  for name,_ in pairs(package.loaded) do
    -- Work round the fact that these modules would otherwise be loaded from the cache
    if name:match('^jg') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  require'packer'.compile()
  vim.notify('Reloaded!', vim.log.levels.INFO)
end

return M
