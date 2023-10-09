local M = {}
local icons = require 'utils.icons'

M.lsp_client = {
  function(msg)
    msg = msg or ''
    local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }

    if next(buf_clients) == nil then
      if type(msg) == 'boolean' or #msg == 0 then
        return ''
      end
      return msg
    end

    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= 'null-ls' then
        table.insert(buf_client_names, client.name)
      end
    end

    local hash = {}
    local client_names = {}
    for _, v in ipairs(buf_client_names) do
      if not hash[v] then
        client_names[#client_names + 1] = v
        hash[v] = true
      end
    end
    table.sort(client_names)
    return icons.ui.Code .. ' ' .. table.concat(client_names, ', ') .. ' ' .. icons.ui.Code
  end,
  colored = true,
  on_click = function()
    vim.cmd [[LspInfo]]
  end,
}

return M
