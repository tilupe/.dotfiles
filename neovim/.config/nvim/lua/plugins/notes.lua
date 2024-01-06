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
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'preservim/vim-markdown',
      -- see below for full list of optional dependencies 👇
    },
    config = function()
      require('obsidian').setup {
        workspaces = {
          {
            name = 'notes',
            path = '~/notes/',
          },
        },
        templates = {
          subdir = 'templates/obsidian/notes',
          date_format = '%Y-%m-%d-%a',
          time_format = '%H:%M',
        },
        note_id_func = function(title)
          -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
          -- In this case a note with the title 'My new note' will be given an ID that looks
          -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
          local suffix = ''

          if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
          else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return tostring(os.time()) .. '-' .. suffix
        end,
      }

      local function new_note()
        local title = vim.fn.input 'Name: '
        return '<CMD>ObsidianNew<CR>'
      end

      vim.keymap.set('v', '<leader>nl', '<CMD>ObsidianLink<CR>', { desc = 'Insert file link' })
      vim.keymap.set('v', '<leader>nL', '<CMD>ObsidianLinkNew<CR>', { desc = 'Insert new file link' })
      vim.keymap.set('n', '<leader>no', '<CMD>ObsidianOpen<CR>', { desc = 'Open in Obsidian' })
      vim.keymap.set('n', '<leader>nn', '<CMD>ObsidianNew' .. vim.fn.input 'Name:' .. '<CR>', { desc = 'New Note' })
      vim.keymap.set('n', '<leader>nf', '<CMD>ObsidianQuickSwitch<CR>', { desc = 'Find' })
      vim.keymap.set('n', '<leader>sn', '<CMD>ObsidianSearch<CR>', { desc = 'Notes' })
      vim.keymap.set('n', '<leader>nb', '<CMD>ObsidianBacklinks<CR>', { desc = 'Backlinks' })
      vim.keymap.set('n', '<leader>nt', '<CMD>ObsidianTemplate<CR>', { desc = 'Template' })
      vim.keymap.set('n', '<leader>np', '<CMD>ObsidianPasteImg<CR>', { desc = 'Paste Img' })
      vim.keymap.set('n', '<leader>nr', '<CMD>ObsidianRename<CR>', { desc = 'Rename' })
    end,
  },
}
