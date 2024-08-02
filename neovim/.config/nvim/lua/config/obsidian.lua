local opts = {
  workspaces = {
    {
      name = 'notes',
      path = '~/Documents/notes',
    },
  },
  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = 'projects/journal/dailies',
    date_format = '%Y-%m-%d',
    default_tags = { 'daily-notes' },
    template = 'resources/templates/obsidian/daily_note.md',
  },
  log_level = vim.log.levels.INFO,
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  mappings = {
    ['gf'] = {
      action = function()
        return require('obsidian').util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    ['<leader>ch'] = {
      action = function()
        return require('obsidian').util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    ['<cr>'] = {
      action = function()
        return require('obsidian').util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
  },
  new_notes_location = 'current_dir',
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ''
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(' ', '_'):gsub('[^A-Za-z0-9-]', ''):lower()
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
}

require('obsidian').setup(opts)
