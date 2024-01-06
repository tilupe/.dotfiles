return {
  {
    '2kabhishek/nerdy.nvim',
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Nerdy',
    keys = require('config.keymaps').nerdy,
  },
  {
    'uga-rosa/ccc.nvim',
    cmd = 'CccPick',
    keys = require('config.keymaps').ccc,
  },
  {
    'cohama/lexima.vim',
  },
  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recomended as each new version will have breaking changes
    opts = {
      --Config goes here
    },
  },
}
