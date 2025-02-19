local M = {}

M.setup = function()
  local dap = require 'dap'

  dap.adapters.coreclr = {
    type = 'executable',
    command = '/run/current-system/sw/bin/netcoredbg',
    args = { '--interpreter=vscode' },
  }

  dap.configurations.cs = {
    {
      type = 'coreclr',
      name = 'launch - netcoredbg',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end,
    },
  }
end

return M
