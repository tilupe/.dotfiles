local M = {}

-- Debugger installation location
local install_dir = vim.fn.stdpath("data") .. "/mason/bin"
function M.setup()
  local dap = require("dap")
  -- Adapter configuration

  dap.adapters.netcoredbg = {
    type = "executable",
    command = install_dir .. "/netcoredbg",
    args = { "--interpreter=vscode" },
  }

  -- Configuration
  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        return vim.fn.input("Path to DLL > ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
    },
  }
end

return M
