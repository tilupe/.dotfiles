require "neogit".setup({
  kind = 'auto',
  graph_style = 'unicode',
  disable_commit_confirmation = false,
  integrations = {
    diffview = true,
  },
})


-- vim.keymap.set(
--   'n',
--   '<leader>gg',
--   function()
--     local neogit = require 'neogit'
--     return neogit.open { kind = 'replace' }
--   end,
--   { desc = 'neo[g]it' })

-- vim.keymap.set('n', '<leader>gc',
--   function()
--     local neogit = require 'neogit'
--     return neogit.open { 'commit' }
--   end,
--   { desc = '[c]ommit' })

-- vim.keymap.set('n', '<leader>gP',
--   function()
--     local neogit = require 'neogit'
--     return neogit.open { 'push' }
--   end,
--   { desc = '[P]ush' })

-- vim.keymap.set('n', '<leader>gp',
--   function()
--     local neogit = require 'neogit'
--     return neogit.open { 'pull' }
--   end,
--   { desc = '[p]ull' })
--
-- vim.keymap.set('n', '<leader>gl',
--   function()
--     local neogit = require 'neogit'
--     return neogit.open { 'log' }
--   end,
--   { desc = '[l]og' })
