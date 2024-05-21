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
local function get_path_only(full_path)
    -- Detect the operating system
    local separator = package.config:sub(1, 1)
    local pattern = separator == '\\' and "(.*\\)" or "(.*/)"
    -- Capture and return the path
    local path = full_path:match(pattern)
    return path
end

vim.keymap.set( 'n', '<leader>ni', '<CMD>Neorg index<CR>', { desc = '[n]eorg [i]dex' })
vim.keymap.set( 'n', '<leader>no', '<CMD>Neorg return<CR>', { desc = '[n]eorg ret[o]rn' })
vim.keymap.set( 'i', '<C-s>', '<CMD>Telescope neorg insert_file_link<CR>', { desc = 'insert file link' })
vim.keymap.set( 'i', '<C-l>', '<CMD>Telescope neorg insert_link<CR>', { desc = 'insert link' })

vim.keymap.set( 'n', '<leader>nn', function ()
  local timestamp = os.date("%Y%m%d%H%M%S")
  local filename = vim.fn.input("file name:")
  local inboxpath = "~/notes/neorg/inbox/"
  local filetype = ".norg"
  vim.cmd.edit(inboxpath..timestamp..filename..filetype)
end, { desc = '[n]ew [i]nbox' })
vim.keymap.set( 'n', '<leader>nl', function ()
  local timestamp = os.date("%Y%m%d%H%M%S")
  local filename = vim.fn.input("file name:")
  local current_file_path = get_path_only(vim.fn.expand("%:p"))

  local filetype = ".norg"
  vim.cmd.edit(current_file_path..timestamp..filename..filetype)
end, { desc = '[n]ew [l]ocal' })

