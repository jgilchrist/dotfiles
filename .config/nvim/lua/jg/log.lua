local M = {}

function M.info(t)
  vim.notify(t, vim.log.levels.INFO)
end

function M.warn(t)
  vim.notify(t, vim.log.levels.WARN)
end

function M.error(t)
  vim.notify(t, vim.log.levels.ERROR)
end

return M
