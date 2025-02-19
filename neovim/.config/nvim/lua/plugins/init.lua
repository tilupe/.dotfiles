return {
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-neotest/nvim-nio' },
  {
    'sindrets/diffview.nvim',
    config = function()
      require('diffview').setup {
        default_args = {
          DiffviewOpen = { '--imply-local' },
        },
        keymaps = {
          file_panel = {
            {
              'n',
              'cc',
              function()
                vim.ui.input({ prompt = 'Commit message: ' }, function(msg)
                  if not msg then
                    return
                  end
                  local results = vim.system({ 'git', 'commit', '-m', msg }, { text = true }):wait()

                  if results.code ~= 0 then
                    vim.notify(
                      'Commit failed with the message: \n' .. vim.trim(results.stdout .. '\n' .. results.stderr),
                      vim.log.levels.ERROR,
                      { title = 'Commit' }
                    )
                  else
                    vim.notify(results.stdout, vim.log.levels.INFO, { title = 'Commit' })
                  end
                end)
              end,
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>gd', '<CMD>DiffviewOpen<CR>', { desc = 'Diffview open' })
      vim.keymap.set(
        'n',
        '<leader>gDh',
        '<CMD>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges<CR>',
        { desc = '[D]iffview commit [h]istory' }
      )
      vim.keymap.set('n', '<leader>gm', '<CMD>DiffviewOpen origin/master...HEAD<CR>', { desc = 'Master [D]' })
      vim.keymap.set('n', '<leader>gq', '<CMD>DiffviewClose<CR>', { desc = 'Quit [D]' })
      vim.keymap.set('n', '<leader>gh', '<CMD>DiffviewFileHistory %<CR>', { desc = 'history' })
      vim.keymap.set('n', '<leader>gH', '<CMD>DiffviewFileHistory<CR>', { desc = 'All File [H]istory' })
      vim.keymap.set('n', '<leader>gR', '<CMD>DiffviewRefresh<CR>', { desc = 'All File [H]istory' })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = true,
    keys = {

      { '<leader>gs', '<CMD>Gitsigns stage_hunk<CR>', { desc = 'stage hunk' } },
      { '<leader>gu', '<CMD>Gitsigns undo_stage_hunk<CR>', { desc = 'undo-stage hunk' } },
      { '<leader>gr', '<CMD>Gitsigns reset_hunk<CR>', { desc = 'reset-hunk' } },
      { ']g', '<CMD>Gitsigns next_hunk<CR>', { desc = 'down-hunk' } },
      { '[g', '<CMD>Gitsigns prev_hunk<CR>', { desc = 'up-hunk' } },
      { '<leader>gb', '<CMD>Gitsigns blame<CR>', { desc = 'blame' } },
    },
  },
  {
    'mbbill/undotree',
    lazy = true,
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>U', ':UndotreeToggle<cr>' },
    },
  }, -- see undo tree
  {
    'oonamo/ef-themes.nvim',
    config = function()
      require('ef-themes').setup {
        light = 'ef-spring', -- Ef-theme to select for light backgrounds
        dark = 'ef-dream', -- Ef-theme to select for dark backgrounds
        transparent = false,
        styles = {
          -- Set specific styles for specific highlight groups
          -- Can be any valid attr-list value. See `:h nvim_set_hl`
          comments = { italic = true },
          keywords = { bold = true },
          functions = {},
          variables = {},

          diagnostic = 'default', -- Can be "full"
          pickers = 'default', -- Can be "borderless"
        },

        modules = {
          -- Enable/Disable highlights for a module
          -- See `h: EfThemes-modules` for the list of available modules
          blink = true,
          fzf = true,
          mini = true,
          semantic_tokens = true,
          snacks = false,
          treesitter = true,
        },

        --- Override any color from the ef-theme
        ---@param colors Ef-Theme
        ---@param name string
        on_colors = function(colors, name) end,

        --- Override specific highlights
        ---@param highlights table
        ---@param colors Ef-Theme
        ---@param name string
        ---@return table
        on_highlights = function(highlights, colors, name)
          -- Returns a table of highlights
          -- return {
          --   Normal = { fg = colors.fg_alt, bg = colors.bg_inactive }
          --   ObscurePlugin = { fg = colors.yellow_faint }
          -- }
        end,

        options = {
          compile = true, -- Whether to compile a theme
          compile_path = vim.fn.stdpath 'cache' .. '/ef-themes', -- Directory in which to place compiled themes
        },
      }

      --vim.cmd.colorscheme 'ef-theme' -- To use the default colorscheme defined above
      -- Or choose a specific theme
      -- vim.cmd.colorscheme("ef-dream")
    end,
  },
  { 'ellisonleao/gruvbox.nvim' },
  { 'f4z3r/gruvbox-material.nvim' },
  {
    'neanias/everforest-nvim',
    priority = 1000,
    config = function()
      local everforest = require 'everforest'
      everforest.setup {
        background = 'hard',
        italics = true,
        inlay_hints_background = 'dimmed',
        disable_italic_comments = false,
        diagnostic_line_highlight = true,
        show_eob = false,
        spell_foreground = true,
      }
      everforest.load()
    end,
  },
  { 'savq/melange-nvim' },
  { 'norcalli/nvim-colorizer.lua' },
  {
    'zbirenbaum/copilot.lua', -- Copilot but lua
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = true,
    opts = {
      panel = {
        enabled = false,
        auto_refresh = false,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<C-CR>',
          refresh = 'gr',
          open = '<M-CR>',
        },
        layout = {
          position = 'bottom', -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = '<C-f>',
          accept_word = false,
          accept_line = false,
          next = '<C-Down>',
          prev = '<C-Up>',
          dismiss = '<C-x>',
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {},
    },
  },
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        formatters = {
          -- csharpier = { command = 'dotnet', args = { 'csharpier', '--write-stdout' } },
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'goimports', 'gofmt' },
          python = { 'isort', 'black' },
          rust = { 'rustfmt', lsp_format = 'fallback' },
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
          cs = { 'csharpier' },
          nix = { 'nixfmt' },
          json = { 'jq' },
          sql = { 'sql_formatter', lsp_format = 'never' },
          --['*'] = { 'injected' }, -- enables injected-lang formatting for all filetypes
        },
        default_format_opts = {
          lsp_format = 'fallback',
        },
      }
      require('conform').formatters.sql_formatter = {
        prepend_args = { '-c', vim.fn.expand '~/.config/sql_formatter.json' },
      }

      vim.keymap.set('n', '<leader>bw', function()
        require('conform').format()
        vim.cmd 'update!'
      end, { desc = 'Save' })
      vim.keymap.set('n', '<leader>ba', function()
        require('conform').format()
        vim.cmd 'wa'
      end, { desc = 'Save' })

      vim.keymap.set('n', '<leader>cf', function()
        require('conform').format()
      end, { desc = 'Format' })
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '*',
    config = function()
      require 'config.luasnip'
    end,
  },
  {
    'mfussenegger/nvim-dap',
    config = function()
      require('config.dap').setup()
    end,
  },
  { 'nvim-tree/nvim-web-devicons', version = '*' },
  {
    'NeogitOrg/neogit',
    config = function()
      require('neogit').setup {
        kind = 'auto',
        graph_style = 'unicode',
        disable_commit_confirmation = false,
        integrations = {
          diffview = true,
        },
      }

      vim.keymap.set('n', '<leader>gg', function()
        local neogit = require 'neogit'
        return neogit.open { kind = 'replace' }
      end, { desc = 'Neogit' })
    end,
  },
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' }, verison = '*' },
  { 'Tastyep/structlog.nvim', version = '*' },
  {
    'stevearc/oil.nvim',
    version = '*',
    opts = {
      default_file_explorer = false,
    },
    keys = {
      { '-', '<CMD>Oil<CR>', { desc = 'Explore' } },
      {
        '<leader>-',
        function()
          local git_root_path = vim.fn.finddir('.git', '.;')
          vim.cmd('Oil ' .. git_root_path)
        end,
        { desc = 'Explore' },
      },
    },
  },
  { 'nvim-telescope/telescope.nvim' },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    'stevearc/overseer.nvim',
    config = function()
      require 'config.overseer'
    end,
  },
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },
  {
    'isakbm/gitgraph.nvim',
    dependencies = { 'sindrets/diffview.nvim' },
    opts = {
      hooks = {
        -- Check diff of a commit
        on_select_commit = function(commit)
          vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
          vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
        end,
        -- Check diff from commit a -> commit b
        on_select_range_commit = function(from, to)
          vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
          vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
        end,
      },
      -- symbols = {
      --   merge_commit = '',
      --   commit = '',
      --   merge_commit_end = '󰜝',
      --   commit_end = '',
      --   GVER = '│',
      --   GHOR = '─',
      --   GCRD = '╭',
      -- },
    },
    init = function()
      vim.keymap.set('n', '<leader>gl', function()
        require('gitgraph').draw({}, { all = true, max_count = 5000 })
      end, { desc = 'new git graph' })
    end,
  },
  {
    'stevearc/quicker.nvim',
    lazy = false,
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    config = function()
      vim.keymap.set('n', '<leader>qf', function()
        require('quicker').toggle()
      end, {
        desc = 'Toggle quickfix',
      })
      vim.keymap.set('n', '<leader>ql', function()
        require('quicker').toggle { loclist = true }
      end, {
        desc = 'Toggle loclist',
      })
      require('quicker').setup {
        keys = {
          {
            '>',
            function()
              require('quicker').expand { before = 2, after = 2, add_to_existing = true }
            end,
            desc = 'Expand quickfix context',
          },
          {
            '<',
            function()
              require('quicker').collapse()
            end,
            desc = 'Collapse quickfix context',
          },
        },
      }
    end,
  },
  {
    'OXY2DEV/helpview.nvim',
    lazy = false, -- Recommended

    -- In case you still want to lazy load
    -- ft = "help",

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'davidmh/cspell.nvim',
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'davidmh/cspell.nvim',
    },
    config = function()
      local null_ls = require 'null-ls'

      local cspell = require 'cspell'
      null_ls.setup {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        cspell.diagnostics,
        cspell.code_actions,
      }
    end,
  },
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'ibhagwan/fzf-lua' },
    ft = 'cs',
    config = function()
      local dotnet = require 'easy-dotnet'
      dotnet.setup {
        picker = 'fzf',
      }
    end,
    keys = {
      {
        '<leader>xr',
        function()
          require('easy-dotnet').run_profile()
        end,
        { desc = '[r]un' },
      },
      {
        '<leader>xb',
        function()
          require('easy-dotnet').build_quickfix()
        end,
        { desc = '[b]uild' },
      },
      {
        '<leader>xs',
        function()
          require('easy-dotnet').restore()
        end,
        { desc = 'Re[s]tor' },
      },
    },
  },
  { 'bluz71/vim-nightfly-colors', name = 'nightfly', lazy = false, priority = 1000 },
  { 'bluz71/vim-moonfly-colors', name = 'moonfly', lazy = false, priority = 1000 },
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    priority = 1100,
  },
  {
    'MagicDuck/grug-far.nvim',
    config = function()
      require('grug-far').setup {}
    end,
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'config.fzf-lua'
    end,
  },
  {
  },
  {
    'ramilito/kubectl.nvim',
    config = function()
      require('kubectl').setup()
      vim.keymap.set('n', '<leader>k', '<cmd>lua require("kubectl").toggle()<cr>', { noremap = true, silent = true })
    end,
  },
}
