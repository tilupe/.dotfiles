local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

require "neorg".setup({
  load = {
    ['core.defaults'] = {},
    ['core.esupports.metagen'] = {
      config = {
        type = 'auto',
        author = 'tilupe',
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
    --['core.manoeuvre'] = {},
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
    ["external.templates"] = {
      -- default_subcommand = "add", -- or "fload", "load"
      config = {
        keywords = {
          EXAMPLE_KEYWORD = function()
            return require("luasnip").insert_node(1, "default text blah blah")
          end,
          OS_DATE_ID = function()
            return t(os.date("%Y%m%d%H%M%S"))
          end,

        },
        -- snippets_overwrite = {},
      },
    }
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

---@return string
local function get_date_string()
  return os.date("%Y%m%d")
end

---@param file_path string
local function edit_new_norg_note(file_path)
  local filename = vim.fn.input("file name:")
  vim.cmd.edit(file_path .. os.date("%Y%m%d") .. filename .. '.norg')
end

vim.keymap.set('n', '<leader>ni', '<CMD>Neorg index<CR>', { desc = '[n]eorg [i]dex' })
vim.keymap.set('n', '<leader>no', '<CMD>Neorg return<CR>', { desc = '[n]eorg ret[o]rn' })
vim.keymap.set('i', '<C-s>', '<CMD>Telescope neorg insert_file_link<CR>', { desc = 'insert file link' })
vim.keymap.set('i', '<C-l>', '<CMD>Telescope neorg insert_link<CR>', { desc = 'insert link' })

vim.keymap.set('n', '<leader>nn',
  function()
    local inboxpath = "~/notes/neorg/inbox/"
    edit_new_norg_note(inboxpath)
  end, { desc = '[n]ew [n]ote inbox' })

vim.keymap.set('n', '<leader>nl',
  function()
    local current_file_path = get_path_only(vim.fn.expand("%:p"))
    edit_new_norg_note(current_file_path)
  end, { desc = '[n]ew note [l]ocal' })
