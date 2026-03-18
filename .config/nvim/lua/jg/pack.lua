local M = {}

local util = require'jg.util'
local augroup = util.augroup

function M.setup(plugins)
  local pack_defs = {}

  for _, plugin in ipairs(plugins) do
    local pack_def = { src = plugin.src }

    if not plugin.name then
      local parts = vim.split(plugin.src, '/')
      pack_def.name = parts[#parts]
    else
      pack_def.name = plugin.name
    end

    if plugin.version then
      pack_def.version = plugin.version
    end

    table.insert(pack_defs, pack_def)
  end

  vim.pack.add(pack_defs)

  for _, plugin in ipairs(plugins) do
    if plugin.config then
      plugin.config()
    end
  end

  augroup('pack_changed', function(autocmd)
    autocmd('PackChanged', { callback = function(args)
      local spec = args.data.spec
      if not spec then return end

      local kind = args.data.kind
      if kind ~= 'update' then return end

      local plugin_name = spec.name

      for _, plugin in ipairs(pack_defs) do
        if plugin.name == plugin_name then
          if plugin.install then
            vim.schedule(plugin.install)
          end

          return
        end
      end

      vim.notify('Plugin ' .. plugin_name .. ' was updated but not found in plugin list', vim.log.levels.ERROR)
    end })
  end)

end

return M
