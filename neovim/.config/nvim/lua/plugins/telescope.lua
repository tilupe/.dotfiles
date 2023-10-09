return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { '^.git/' },
        mappings = {
          i = {
            ['<c-t>'] = function(...)
              return require('trouble.providers.telescope').open_with_trouble(...)
            end,
            ['<a-t>'] = function(...)
              return require('trouble.providers.telescope').open_selected_with_trouble(...)
            end,
            ['<C-n>'] = function(...)
              return require('telescope.actions').cycle_history_next(...)
            end,
            ['<C-p>'] = function(...)
              return require('telescope.actions').cycle_history_prev(...)
            end,
            ['<C-J>'] = function(...)
              return require('telescope.actions').preview_scrolling_down(...)
            end,
            ['<C-K>'] = function(...)
              return require('telescope.actions').preview_scrolling_up(...)
            end,
            ['<C-j>'] = function(...)
              return require('telescope.actions').move_selection_next(...)
            end,
            ['<C-k>'] = function(...)
              return require('telescope.actions').move_selection_previous(...)
            end,
          },
          n = {
            ['q'] = function(...)
              return require('telescope.actions').close(...)
            end,
          },
        },
      },
    },
    keys = require('config.keymaps').telescope,
    config = true,
  },
}
