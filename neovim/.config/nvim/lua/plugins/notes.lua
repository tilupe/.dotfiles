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
          subdir = '/assets/templates/obsidian/notes',
          date_format = '%Y-%m-%d-%a',
          time_format = '%H:%M',
        },
        note_id_func = function(title)
          local suffix = ''
          if title ~= nil then
            suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
          else
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return tostring(os.date '%Y%m%d%H%M%S') .. '-' .. suffix
        end,

        new_notes_location = 'current_dir',
        preferred_link_style = 'markdown',
        completion = {
          nvim_cmp = true,
          min_chars = 1,
        },
      }

      local M = {}
      M.new = function()
        local title = vim.fn.input 'Name: '
        vim.cmd('ObsidianNew ' .. title)
      end

      vim.keymap.set('v', '<leader>nl', '<CMD>ObsidianLink<CR>', { desc = 'Insert file link' })
      vim.keymap.set('v', '<leader>nL', '<CMD>ObsidianLinkNew<CR>', { desc = 'Insert new file link' })
      vim.keymap.set('n', '<leader>no', '<CMD>ObsidianOpen<CR>', { desc = 'Open in Obsidian' })
      vim.keymap.set('n', '<leader>nn', M.new, { desc = 'New Note' })
      vim.keymap.set('n', '<leader>nf', '<CMD>ObsidianQuickSwitch<CR>', { desc = 'Find' })
      vim.keymap.set('n', '<leader>sn', '<CMD>ObsidianSearch<CR>', { desc = 'Notes' })
      vim.keymap.set('n', '<leader>nb', '<CMD>ObsidianBacklinks<CR>', { desc = 'Backlinks' })
      vim.keymap.set('n', '<leader>nt', '<CMD>ObsidianTemplate<CR>', { desc = 'Template' })
      vim.keymap.set('n', '<leader>np', '<CMD>ObsidianPasteImg<CR>', { desc = 'Paste Img' })
      vim.keymap.set('n', '<leader>nr', '<CMD>ObsidianRename<CR>', { desc = 'Rename' })
    end,
  },
}
