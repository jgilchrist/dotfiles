local luasnip = require'luasnip'
local luasnip_snipmate_loader = require'luasnip.loaders.from_snipmate'
local augroup = require'jg.config'.augroup

luasnip_snipmate_loader.lazy_load()

function leave_snippet()
  if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
    and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
    and not luasnip.session.jump_active
  then
    luasnip.unlink_current()
  end
end

-- Always stop snippets when leaving normal mode
augroup('cancel_luasnip_on_normal_mode', function(autocmd)
  autocmd('ModeChanged', { callback = function() leave_snippet() end })
end)
