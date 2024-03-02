local M = {}

M.build = function()
  vim.fn.jobstart('dotnet build /home/dev-notomoro/Development/Dg.Sales/Dg.Sales.Host.sln', {
    on_exit = function(_, _, _)
      print 'Job finished'
    end,
    on_stdout = function(_, data, _)
      print('Job output: ' .. data)
    end,
    detach = true,
  })
end

return M
