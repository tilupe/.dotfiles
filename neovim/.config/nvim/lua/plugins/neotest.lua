return {
  {
    'Issafalcon/neotest-dotnet',
  },
  { 'nvim-neotest/neotest-python' },
  { 'nvim-neotest/neotest-plenary' },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    version = '*',
    event = 'VeryLazy',
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
          },
          require 'neotest-plenary',
          require 'neotest-dotnet' {
            discovery_root = 'solution', -- Default
          },
        },
      }
      vim.keymap.set('n', '<Leader>tn', function()
        require('neotest').run.run()
      end, { desc = 'Nearest' })

      vim.keymap.set('n', '<leader>tF', "<cmd>lua require('plugins.dap.functions').run(vim.fn.expand('%'))<cr>", { desc = 'File Debug' })
      vim.keymap.set('n', '<leader>tL', "<cmd>lua require('plugins.dap.functions').run_last()<cr>", { desc = 'Last Debug' })
      vim.keymap.set('n', '<leader>ta', "<cmd>lua require('neotest').run.attach()<cr>", { desc = 'Attach' })
      vim.keymap.set('n', '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = 'File' })
      vim.keymap.set('n', '<leader>tl', "<cmd>lua require('neotest').run.run_last()<cr>", { desc = 'Last' })

      vim.keymap.set('n', '<leader>tn', function()
        require('neotest').run.run()
      end, { desc = 'Nearest' })

      vim.keymap.set('n', '<leader>tN', function()
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
      end, { desc = 'Debug Nearest' })
      vim.keymap.set('n', '<leader>to', "<cmd>lua require('neotest').output.open({ enter = true })<cr>", { desc = 'Output' })
      vim.keymap.set('n', '<leader>tS', "<cmd>lua require('neotest').run.stop()<cr>", { desc = 'Stop' })
      vim.keymap.set('n', '<leader>ts', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = 'Summary' })
    end,

    keys = {},
  },
}
