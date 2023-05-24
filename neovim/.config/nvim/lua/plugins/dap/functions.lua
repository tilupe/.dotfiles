local M = {}

M.run = function(path)
  if path then
    if vim.bo.filetype == "cs" then
      require("neotest").run.run({
        path,
        strategy = require("neotest-dotnet.strategies.netcoredbg"),
        is_custom_dotnet_debug = true,
      })
    else
      require("neotest").run.run({ path, strategy = "dap" })
    end
  else
    if vim.bo.filetype == "cs" then
      require("neotest").run.run({
        strategy = require("neotest-dotnet.strategies.netcoredbg"),
        is_custom_dotnet_debug = true,
      })
    else
      require("neotest").run.run({ strategy = "dap" })
    end
  end
end

return M
