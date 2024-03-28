return {
  {
    'vim-test/vim-test',
    keys = require('config.keymaps').vim_test,
    config = function()
      vim.g['test#strategy'] = 'neovim'
      vim.g['test#neovim#term_position'] = 'belowright'
      vim.g['test#neovim#preserve_screen'] = 1
      vim.g['test#python#runner'] = 'pyunit' -- pytest
      vim.g['test#csharp#runner'] = 'dotnet test' -- dotnet test
    end,
  },
  {
    'nvim-neotest/neotest',
    keys = require('config.keymaps').neotest,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'stevearc/overseer.nvim',
      --- language test adapters
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-vim-test',
      'rouge8/neotest-rust',
      'Issafalcon/neotest-dotnet',
    },
    config = function()
      local opts = {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            runner = 'unittest',
          },
          require 'neotest-plenary',
          require 'neotest-rust',
          require 'neotest-dotnet',
        },
        icons = {
          expanded = '',
          child_prefix = '',
          child_indent = '',
          final_child_prefix = '',
          non_collapsible = '',
          collapsed = '',
          passed = '',
          running = '',
          failed = '',
          unknown = '',
          skipped = '',
        },
        -- overseer.nvim
        consumers = {
          overseer = require 'neotest.consumers.overseer',
        },
        overseer = {
          enabled = true,
          force_default = true,
        },
        loglevel = 1,
      }
      require('neotest').setup(opts)
    end,
  },
}
