return {
  {
    'Issafalcon/neotest-dotnet',
  },
  { 'nvim-neotest/neotest-python' },
  { 'nvim-neotest/neotest-plenary' },
  {
    'nvim-neotest/neotest',
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-dotnet' {
            discovery_root = 'solution', -- Default
          },
        },
      }
    end,
    keys = {

      { '<leader>tF', "<cmd>lua require('plugins.dap.functions').run(vim.fn.expand('%'))<cr>", { desc = 'Debug File' } },
      { '<leader>tL', "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>", { desc = 'Debug Last' } },
      { '<leader>ta', "<cmd>lua require('neotest').run.attach()<cr>", { desc = 'Attach' } },
      { '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = 'File' } },
      { '<leader>tl', "<cmd>lua require('neotest').run.run_last()<cr>", { desc = 'Last' } },
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        { desc = 'Nearest' },
      },

      {
        '<leader>tN',
        function()
          local path = vim.fn.expand '%'
          if path then
            if vim.bo.filetype == 'cs' then
              require('neotest').run.run {
                path,
                strategy = require 'neotest-dotnet.strategies.netcoredbg',
                is_custom_dotnet_debug = true,
              }
            else
              require('neotest').run.run { path, strategy = 'dap' }
            end
          else
            if vim.bo.filetype == 'cs' then
              require('neotest').run.run {
                strategy = require 'neotest-dotnet.strategies.netcoredbg',
                is_custom_dotnet_debug = true,
              }
            else
              require('neotest').run.run { strategy = 'dap' }
            end
          end
        end,
        { desc = 'Debug Nearest' },
      },
      { '<leader>to', "<cmd>lua require('neotest').output.open({ enter = true })<cr>", { desc = 'Output' } },
      { '<leader>ts', "<cmd>lua require('neotest').run.stop()<cr>", { desc = 'Stop' } },
      { '<leader>tS', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = 'Summary' } },
    },
  },
}
