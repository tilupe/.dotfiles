if vim.g.vscode then
  print 'hello vs code'
else
  require 'config.options'
  -- Install package manager
  --    https://github.com/folke/lazy.nvim
  --    `:help lazy.nvim.txt` for more info
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)
  -- Load plugin specs from lua/plugins/*.lua
  require('lazy').setup('plugins', {
    defaults = {
      lazy = true, -- Default to lazy loading, optional
    },
    checker = {
      enable = true,
    },
    change_detection = {
      notify = false, -- I find the config changed notification super annoying
    },
  })

  -- [[ Setting options ]]
  -- See `:help vim.o`
  -- NOTE: You can change these options as you wish!

  require 'config.keymaps'
  -- [[ Basic Keymaps ]]

  -- Keymaps for better default experience
  -- See `:help vim.keymap.set()`

  -- Remap for dealing with word wrap
  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  -- [[ Configure Telescope ]]
  -- See `:help telescope` and `:help telescope.setup()`
  -- Enable telescope fzf native, if installed
  pcall(require('telescope').load_extension, 'fzf')

  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- [[ Configure Treesitter ]]
  -- See `:help nvim-treesitter`
  -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
  vim.defer_fn(function() end, 0)
end
