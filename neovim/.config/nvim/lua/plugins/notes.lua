return {
  {
    'nvim-neorg/neorg',
    ft = 'norg',
    build = ':Neorg sync-parsers',
    opts = {
      load = {
        ['core.defaults'] = {},
        ['core.esupports.metagen'] = {
          config = {
            type = 'auto',
          },
        },
        ['core.concealer'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
            },
            default_workspace = 'notes',
          },
        },
        ['core.export'] = {},
        ['core.manoeuvre'] = {},
        ['core.integrations.telescope'] = {},
        ['core.integrations.nvim-cmp'] = {},
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neorg/neorg-telescope',
    },
    keys = require('config.keymaps').neorg,
  },
}
