local icons = require 'utils.icons'

return {
  {
    'FabijanZulj/blame.nvim',
    keys = require('config.keymaps').blame,
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = icons.git.LineAdded },
        change = { text = icons.git.LineModified },
        delete = { text = icons.git.LineRemoved },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
    keys = require('config.keymaps').gitsigns,
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      kind = 'auto',
      graph_style = 'unicode',
      disable_commit_confirmation = false,
      integrations = {
        diffview = true,
      },
    },
    config = true,
    keys = require('config.keymaps').neogit,
  },
  {
    'sindrets/diffview.nvim',
    cmd = 'DiffviewOpen',
    keys = require('config.keymaps').diffview,
  },
}
