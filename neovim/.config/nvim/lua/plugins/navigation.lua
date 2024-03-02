return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      }
      vim.keymap.set('n', '<leader>hh', function()
        harpoon:list():append()
      end)
      vim.keymap.set('n', '<leader>hu', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<leader>hs', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<leader>hd', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<leader>hf', function()
        harpoon:list():select(4)
      end)
      vim.keymap.set('n', '<leader>hg', function()
        harpoon:list():select(5)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>hk', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<leader>hj', function()
        harpoon:list():next()
      end)
    end,
  },
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'FzfLua',
    config = function()
      -- calling `setup` is optional for customization
      require('fzf-lua').setup {}
    end,
    keys = require('config.keymaps').fzf,
  },
  {
    'echasnovski/mini.files',
    event = 'VeryLazy',
    config = function(_, opts)
      require('mini.files').setup(opts)
    end,
    keys = require('config.keymaps').mini_files,
  },
  {
    'christoomey/vim-tmux-navigator',
    event = 'VeryLazy',
    keys = require('config.keymaps').tmux,
  },
  ---- Mini
  { 'echasnovski/mini.nvim', version = '*' },
  {
    'echasnovski/mini.clue',
    event = 'VeryLazy',
    version = '*',
    config = function()
      local miniclue = require 'mini.clue'
      miniclue.setup {
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),

          { mode = 'n', keys = '<leader>g', desc = '[G]it' },
          { mode = 'n', keys = '<leader>c', desc = '[C]ode' },
          { mode = 'n', keys = '<leader>s', desc = '[S]earch' },
          { mode = 'n', keys = '<leader>n', desc = '[N]otes' },
          { mode = 'n', keys = '<leader>d', desc = '[D]ebu' },
          { mode = 'n', keys = '<leader>t', desc = '[T]est' },
          { mode = 'n', keys = '<leader>r', desc = '[R]efactor' },
          { mode = 'n', keys = '<leader>w', desc = '[W]orkspace' },
          { mode = 'n', keys = '<leader>b', desc = '[B]uffer' },
        },
      }
    end,
  },
  {
    'goolord/alpha-nvim',
    lazy = false,
    config = function()
      local dashboard = require 'alpha.themes.dashboard'
      dashboard.section.header.val = {
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        '                                                     ',
      }
      dashboard.section.buttons.val = {
        dashboard.button('o', ' ' .. ' Find file', ':Telescope find_files <CR>'),
        dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
        dashboard.button('g', ' ' .. ' Git', '<CMD>lua require("utils.custom.git").status()<CR>'),
        dashboard.button('f', ' ' .. ' Grep', '<CMD>Telescope live_grep <CR>'),
        dashboard.button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
        dashboard.button('l', '鈴' .. ' Lazy', ':Lazy<CR>'),
        dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = 'AlphaButtons'
        button.opts.hl_shortcut = 'AlphaShortcut'
      end
      dashboard.section.footer.opts.hl = 'Constant'
      dashboard.section.header.opts.hl = 'AlphaHeader'
      dashboard.section.buttons.opts.hl = 'AlphaButtons'
      dashboard.opts.layout[1].val = 0

      if vim.o.filetype == 'lazy' then
        -- close and re-open Lazy after showing alpha
        vim.notify('Missing plugins installed!', vim.log.levels.INFO, { title = 'lazy.nvim' })
        vim.cmd.close()
        require('alpha').setup(dashboard.opts)
        require('lazy').show()
      else
        require('alpha').setup(dashboard.opts)
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

          -- local now = os.date "%d-%m-%Y %H:%M:%S"
          local version = '   v' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch
          local fortune = require 'alpha.fortune'
          local quote = table.concat(fortune(), '\n')
          local plugins = '⚡Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
          local footer = '\t' .. version .. '\t' .. plugins .. '\n' .. quote
          dashboard.section.footer.val = footer
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
