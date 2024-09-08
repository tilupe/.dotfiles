local M = {}

M.CREATE_UNDO = vim.api.nvim_replace_termcodes('<c-G>u', true, true, true)
function M.create_undo()
  if vim.api.nvim_get_mode().mode == 'i' then
    vim.api.nvim_feedkeys(M.CREATE_UNDO, 'n', false)
  end
end
-- This is a better implementation of `cmp.confirm`:
--  * check if the completion menu is visible without waiting for running sources
--  * create an undo point before confirming
-- This function is both faster and more reliable.
---@param opts? {select: boolean, behavior: cmp.ConfirmBehavior}
function M.confirm(opts)
  local cmp = require 'cmp'
  opts = vim.tbl_extend('force', {
    select = true,
    behavior = cmp.ConfirmBehavior.Insert,
  }, opts or {})
  return function(fallback)
    if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
      M.create_undo()
      if cmp.confirm(opts) then
        return
      end
    end
    return fallback()
  end
end

M.Find_launch_settings = function()
  local current_path = vim.fn.expand '%:p'
  print(current_path)
  local temp_path = "/home/dev-notomoro/Development/Dg.Sales/"
  local handle = io.popen("ls") -- replace "ls" with your command
  local result = handle:read("*.lua")
  handle:close()
  print(result)
  local launchsettings = os.execute('find ' .. '"launchsettings.json"' .. temp_path)
  vim.ui.select(result)

end



---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

return M
