local opts = {
  workspaces = {
    {
      name = 'notes',
      path = '~/private/documents/notes',
    },
  },
  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = 'daily-notes',
    date_format = '%Y-%m-%d',
    default_tags = { 'daily-note' },
    --template = '~/private/notes/resources/templates/obsidian/daily_note.md',
  },
  log_level = vim.log.levels.INFO,
  completion = {
    min_chars = 2,
  },
  mappings = {
    ['gf'] = {
      action = function()
        return require('obsidian').util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    ['<cr>'] = {
      action = function()
        return require('obsidian').util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
  },
  new_notes_location = 'current_dir',
  follow_url_func = function(url)
    vim.ui.open(url)
  end,
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ''
    if title ~= nil then
      suffix = title:gsub(' ', '-')
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.date '%Y%m%d%H%M%S') .. '-' .. suffix
  end,
  picker = {
    name = 'fzf-lua',
    note_mappings = {
      new = '<C-x>',
      insert_link = '<C-l>',
    },
    tag_mappings = {
      tag_note = '<C-x>',
      insert_tag = '<C-l>',
    },
  },
  sort_by = 'modified',
  sort_reversed = true,
  open_notes_in = 'current',
  ui = {
    enable = false,
  },
  -- templates = {
  --   folder = 'resources/templates/obsidian',
  --   date_format = '%Y-%m-%d-%a',
  --   time_format = '%H:%M',
  -- },
}

require('obsidian').setup(opts)

vim.keymap.set('n', '<leader>on', function()
  vim.cmd 'ObsidianNew'
end, { desc = '[o]bsidian [n]ew note' })

vim.keymap.set('n', '<leader>oN', function()
  vim.cmd 'ObsidianNewFromTemplate'
end, { desc = '[o]bsidian [n]ew note' })

vim.keymap.set('n', '<leader>os', function()
  vim.cmd 'ObsidianSearch'
end, { desc = '[o]bsidian [s]tring search' })

vim.keymap.set('n', '<leader>oo', function()
  vim.cmd 'ObsidianOpen'
end, { desc = '[o]bsidian [o]pen' })

vim.keymap.set('n', '<leader>oc', function()
  vim.cmd 'ObsidianToggleCheckbox'
end, { desc = '[o]bsidian [c]heckbox' })

vim.keymap.set('n', '<leader>of', function()
  vim.cmd 'ObsidianQuickSwitch'
end, { desc = '[o]bsidian [f]iles' })

vim.keymap.set('n', '<leader>od', function()
  vim.cmd 'ObsidianToday'
end, { desc = '[o]bsidian [d]aily' })

vim.keymap.set('n', '<leader>or', function()
  vim.cmd 'ObsidianRename'
end, { desc = '[o]bsidian [r]ename' })

vim.keymap.set('n', '<leader>op', function()
  vim.cmd 'ObsidianPasteImg'
end, { desc = '[o]bsidian [p]aste image' })

vim.keymap.set('n', '<leader>og', function()
  vim.cmd 'ObsidianTOC'
end, { desc = '[o]bsidian [p]aste image' })

vim.keymap.set('n', '<leader>ob', function()
  vim.cmd 'ObsidianBacklinks'
end, { desc = '[o]bsidian [b]acklinks' })

vim.keymap.set('v', '<leader>ol', function()
  vim.cmd 'ObsidianLink'
end, { desc = '[o]bsidian [l]ink' })

vim.keymap.set('v', '<leader>on', function()
  vim.cmd 'ObsidianLinkNew'
end, { desc = '[o]bsidian [n]ew' })

vim.keymap.set('v', '<leader>oe', function()
  vim.cmd 'ObsidianExtractNote'
end, { desc = '[o]bsidian [e]xtract' })
