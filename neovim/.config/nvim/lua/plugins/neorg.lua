require "neorg".setup({
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
          notes = '~/notes/neorg/',
        },
        default_workspace = 'notes',
      },
    },
    ['core.export'] = {},
    ['core.export.markdown'] = {},
    ['core.manoeuvre'] = {},
    ['core.ui.calendar'] = {},
    ['core.integrations.telescope'] = {},
    ['core.presenter'] = {
      config = {
          zen_mode = "zen-mode",
      }
    },
    ['core.completion'] = {
      config = {
      engine = "nvim-cmp",
      }
    },
  },
})


vim.keymap.set( 'n', '<leader>ni', '<CMD>Neorg index<CR>', { desc = '[n]eorg [i]dex' })
vim.keymap.set( 'n', '<leader>no', '<CMD>Neorg return<CR>', { desc = '[n]eorg ret[o]rn' })
vim.keymap.set( 'i', '<C-l>', '<CMD>Telescope neorg insert_file_link<CR>', { desc = 'insert file link' })
vim.keymap.set( 'i', '<C-L>', '<CMD>Telescope neorg insert_link<CR>', { desc = 'insert link' })
vim.keymap.set( 'n', '<leader>nn', function ()
  local timestamp = os.date("%Y%m%d%H%M%S")
  local filename = vim.fn.input("file name:")
  local inboxpath = "~/notes/neorg/inbox/"
  local filetype = ".norg"
  vim.cmd.edit(inboxpath..timestamp..filename..filetype)
end, { desc = 'new file in inbox' })


