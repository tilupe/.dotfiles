local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

require('neorg').setup {
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
        zen_mode = 'zen-mode',
      },
    },
    ['core.completion'] = {
      config = {
        engine = 'nvim-cmp',
      },
    },
    ['external.conceal-wrap'] = {},
    --['external.interim-ls'] = {},
    ['external.templates'] = {
      -- default_subcommand = "add", -- or "fload", "load"
      config = {
        keywords = {
          EXAMPLE_KEYWORD = function()
            return require('luasnip').insert_node(1, 'default text blah blah')
          end,
          OS_DATE_ID = function()
            return t(os.date '%Y%m%d%H%M%S')
          end,
        },
        -- snippets_overwrite = {},
      },
    },
  },
}
local function get_path_only(full_path)
  -- Detect the operating system
  local separator = package.config:sub(1, 1)
  local pattern = separator == '\\' and '(.*\\)' or '(.*/)'
  -- Capture and return the path
  local path = full_path:match(pattern)
  return path
end

---@return string
local function get_date_string()
  return os.date '%Y%m%d'
end

---@param file_path string
local function edit_new_norg_note(file_path)
  local filename = vim.fn.input 'file name:'
  vim.cmd.edit(file_path .. os.date '%Y%m%d' .. filename .. '.norg')
end

local neorg_loaded, neorg = pcall(require, 'neorg.core')
assert(neorg_loaded, 'Neorg is not loaded - please make sure to load Neorg first')
local fzf_lua_loaded, fzf_lua = pcall(require, 'fzf-lua')
assert(fzf_lua_loaded, 'fzf-lua is not loaded - please make sure to load fzf-lua first')
local builtin = require 'fzf-lua.previewer.builtin'

local function neorg_node_injector()
  local current_workspace = neorg.modules.get_module('core.dirman').get_current_workspace()

  local base_directory = current_workspace[2]
  -- IMP: CHANGE FDFIND and RG here according to your preferred tool
  local norg_files_output = vim.fn.systemlist('fdfind -e norg --type f --base-directory ' .. base_directory)
  local norg_files = table.concat(norg_files_output, ' ')
  local rg_command = 'rg --multiline "(?s)@document\\.meta.*?title:\\s+(.*?)\\s+@end" ' .. norg_files .. ' ' .. base_directory
  local rg_results = vim.fn.system(rg_command)

  -- Extract lines containing "title:"
  local titles = {}
  for line in rg_results:gmatch '[^\r\n]+' do
    if line:find 'title:' then
      table.insert(titles, line)
    end
  end

  -- Concatenate the filtered lines into a single string
  local filtered_results = table.concat(titles, '\n')

  local title_path_pairs = {}

  -- Iterate over each line in the output
  for line in filtered_results:gmatch '[^\r\n]+' do
    -- Split the line into two parts based on ":"
    local file_path, title = line:match '^(.-):(.*)$'
    -- And again to get rid of the annoying "title"
    _, title = title:match '^(.-): (.*)$'
    -- Store all in a dictionary. This finna be a problem for
    -- people with Big Chungus workspaces
    title_path_pairs[title] = file_path
  end

  local workspace_previewer = builtin.buffer_or_file:extend()

  function workspace_previewer:new(o, opts, fzf_win)
    workspace_previewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, workspace_previewer)
    return self
  end

  function workspace_previewer:parse_entry(entry_str)
    return {
      path = title_path_pairs[entry_str],
      line = 1,
      col = 1,
    }
  end

  local navigate_to = function(selected)
    vim.notify('Navigating to --> ' .. selected[1])
    vim.cmd('e ' .. title_path_pairs[selected[1]])
  end

  local paste_address = function(selected)
    vim.notify('Pasting address of --> ' .. selected[1])

    -- This is necessary because the "/" in the dir address
    -- can effect the regex-ing
    local escaped_prefix = base_directory:gsub('[%^%$%(%)%%%.%[%]%*%+%-%?]', '%%%1')
    local relative_path = title_path_pairs[selected[1]]:gsub('^' .. escaped_prefix, '')

    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    -- Why use an if statement here, you ask?
    -- IDFK, some OS seem to add a random '.' in the address and some don't...
    if relative_path:sub(1, 1) == '.' then
      local hyperlink = '{:$' .. relative_path:sub(2, -6) .. ':}[' .. selected[1] .. ']'
      vim.api.nvim_put({ hyperlink }, '', true, true)
    else
      local hyperlink = '{:$' .. relative_path:sub(1, -6) .. ':}[' .. selected[1] .. ']'
      vim.api.nvim_put({ hyperlink }, '', true, true)
    end

    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end

  local function table_keys(tbl)
    local keys = {}
    for key, _ in pairs(tbl) do
      table.insert(keys, key)
    end
    return keys
  end

  local prompt = 'Navigate to -> '
  fzf_lua.fzf_exec(table_keys(title_path_pairs), {
    previewer = workspace_previewer,
    prompt = prompt,
    actions = {
      ['default'] = navigate_to,
      ['ctrl-i'] = paste_address,
    },
  })
end

local function neorg_workspace_selector()
  local workspaces = neorg.modules.get_module('core.dirman').get_workspaces()
  local workspace_names = {}

  for name in pairs(workspaces) do
    table.insert(workspace_names, name)
  end

  local workspace_previewer = builtin.buffer_or_file:extend()

  function workspace_previewer:new(o, opts, fzf_win)
    workspace_previewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, workspace_previewer)
    return self
  end

  function workspace_previewer:parse_entry(entry_str)
    local path = workspaces[entry_str]
    return {
      path = path .. '/index.norg',
      line = 1,
      col = 1,
    }
  end

  local workspace_set = function(selected)
    vim.cmd('Neorg workspace ' .. selected[1])
  end

  local workspace_open = function(selected)
    vim.cmd('Neorg workspace ' .. selected[1])
    vim.cmd 'Neorg index'
  end

  local prompt = 'Select Neorg Directory -> '
  fzf_lua.fzf_exec(workspace_names, {
    previewer = workspace_previewer,
    prompt = prompt,
    actions = {
      ['default'] = workspace_set,
      ['ctrl-i'] = workspace_open,
    },
  })
end

--------- Keymaps---------
vim.keymap.set('n', '<leader>ni', '<CMD>Neorg index<CR>', { desc = '[n]eorg [i]dex' })
vim.keymap.set('n', '<leader>no', '<CMD>Neorg return<CR>', { desc = '[n]eorg ret[o]rn' })
vim.keymap.set('i', '<C-s>', '<CMD>Telescope neorg insert_file_link<CR>', { desc = 'insert file link' })
vim.keymap.set('i', '<C-l>', '<CMD>Telescope neorg insert_link<CR>', { desc = 'insert link' })

vim.keymap.set('n', '<leader>nn', function()
  local inboxpath = '~/notes/neorg/inbox/'
  edit_new_norg_note(inboxpath)
end, { desc = '[n]ew [n]ote inbox' })

vim.keymap.set('n', '<leader>nl', function()
  local current_file_path = get_path_only(vim.fn.expand '%:p')
  edit_new_norg_note(current_file_path)
end, { desc = '[n]ew note [l]ocal' })
