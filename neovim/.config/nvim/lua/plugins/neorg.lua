return {
  {
    'nvim-neorg/neorg',
    lazy = false,
    version = '*',
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          --['core.completion'] = {},
          ['core.export'] = {},
          ['core.text-objects'] = {},
          ['core.export.markdown'] = {},
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/private/notes/neorg',
              },
              default_workspace = 'notes',
            },
          },
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
}
