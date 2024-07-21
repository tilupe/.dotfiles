return {
  name = 'dotnet_build',
  builder = function()
    local cwDir = vim.fn.getcwd()
    local sln_files = vim.split(vim.fn.glob(cwDir .. '/*'), '\n', { trimempty = true })

    local sln_file = ""
    vim.ui.select(sln_files, {
      prompt = 'Select a solution file to build: ',
    }, function (choice)
        sln_file = choice
    end)
    print('Building ' .. sln_file)

    return {
      cmd = { 'dotnet', 'build' },
      args = { sln_file },
      components = { 'default' },
    }
  end,
  condition = {
    filetype = { 'cs' },
  },
}
