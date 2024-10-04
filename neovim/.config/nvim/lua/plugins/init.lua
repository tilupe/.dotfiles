return {
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-neotest/nvim-nio' },
  {
    'seblj/roslyn.nvim',
    config = function()
      require('roslyn').setup {
        config = {
          settings = {
            ['csharp|inlay_hints'] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,
              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ['csharp|code_lens'] = {
              dotnet_enable_references_code_lens = true,
            },
            ['csharp|symbol_search'] = {
              dotnet_search_reference_assemblies = true,
            },
            ['csharp|completion'] = {
              dotnet_show_completion_items_from_unimported_namespaces = true,
              dotnet_show_name_completion_suggestions = true,
            },
            ['csharp|background_analysis'] = {
              dotnet_analyzer_diagnostics_scope = 'fullSolution',
              dotnet_compiler_diagnostics_scope = 'fullSolution',
            },
          },
        },
        filewatching = true,
      }
    end,
    lazy = false,
    keys = {
      {
        '<leader>lt',
        function()
          vim.cmd 'CSTarget'
        end,
      },
    },
  },
  {
    'sindrets/diffview.nvim',
    opts = {
      default_args = {
        DiffviewOpen = { '--imply-local' },
      },
      keymaps = {
        file_panel = {
          {
            'n',
            'cc',
            [[<Cmd>call jobstart(["git", "commit"]) | au BufWinEnter * ++once wincmd J<CR>]],
            { desc = 'Commit staged changes' },
          },
          {
            'n',
            'ca',
            [[<Cmd>call jobstart(["git", "commit", "--amend"]) | au BufWinEnter * ++once wincmd J<CR>]],
            { desc = 'Amend the last commit' },
          },
        },
      },
    },
    keys = {
      { '<leader>gd', '<CMD>DiffviewOpen<CR>', { desc = '[d]iffview Open' } },
      { '<leader>gDh', '<CMD>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges<CR>', { desc = '[D]iffview commit [h]istory' } },
      { '<leader>gq', '<CMD>DiffviewClose<CR>', { desc = '[D]iffview Close' } },
      { '<leader>gh', '<CMD>DiffviewFileHistory %<CR>', { desc = 'File [H]istory' } },
      { '<leader>gH', '<CMD>DiffviewFileHistory<CR>', { desc = 'All File [H]istory' } },
      { '<leader>gR', '<CMD>DiffviewRefresh<CR>', { desc = 'All File [H]istory' } },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = true,
    keys = {

      { '<leader>gs', '<CMD>Gitsigns stage_hunk<CR>', { desc = '[s]tage hunk' } },
      { '<leader>gu', '<CMD>Gitsigns undo_stage_hunk<CR>', { desc = '[u]ndo-stage hunk' } },
      { '<leader>gr', '<CMD>Gitsigns reset_hunk<CR>', { desc = '[r]eset-hunk' } },
      { '<leader>gj', '<CMD>Gitsigns next_hunk<CR>', { desc = 'next-hunk' } },
      { '<leader>gk', '<CMD>Gitsigns prev_hunk<CR>', { desc = 'prev-hunk' } },
      { '<leader>gb', '<CMD>Gitsigns blame<CR>', { desc = 'blame' } },
    },
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'config.harpoon'
    end,
  },
  { 'mbbill/undotree', lazy = true, cmd = 'UndotreeToggle', keys = {
    { '<leader>u', ':UndotreeToggle<cr>' },
  } }, -- see undo tree
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
    'HakonHarnes/img-clip.nvim',
    opts = {
      default = {
        dir_path = '~/Pictures/', ---@type string
      },
    },
    keys = {
      {
        '<leader>po',
        function()
          local oil = require 'oil'
          local filename = oil.get_cursor_entry().name
          local dir = oil.get_current_dir()
          oil.close()

          local img_clip = require 'img-clip'
          img_clip.paste_image({}, dir .. filename)
        end,
        { desc = 'Past img' },
      },
      {
        '<leader>fc',
        function()
          require('oil').close()
        end,
        { desc = '[f]iles [c]lose' },
      },
    },
  },
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
    'sbdchd/neoformat',
    cmd = 'Neoformat',
    keys = {
      { '<leader>cf', '<CMD>Neoformat<CR>', { desc = '[c]ode [f]ormat' } },
    },
  },
  {
    'L3MON4D3/LuaSnip',
    version = '*',
    config = function()
      require 'config.luasnip'
    end,
  },
  { 'mfussenegger/nvim-dap' },
  { 'nvim-tree/nvim-web-devicons', version = '*' },
  {
    'NeogitOrg/neogit',
    opts = {
      kind = 'auto',
      graph_style = 'unicode',
      disable_commit_confirmation = false,
      integrations = {
        diffview = true,
      },
    },
    keys = {
      {
        '<leader>gg',
        function()
          local neogit = require 'neogit'
          return neogit.open { kind = 'replace' }
        end,
        { desc = 'neo[g]it' },
      },
    },
  },
  { 'neovim/nvim-lspconfig', version = '*' },
  { 'williamboman/mason.nvim', version = '*' },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require 'config.mason-lspconfig'
    end,
  },
  { 'rcarriga/nvim-dap-ui', version = '*' },
  { 'Tastyep/structlog.nvim', version = '*' },
  { 'jay-babu/mason-nvim-dap.nvim', version = '*' },
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
  { '3rd/image.nvim', version = '*' },
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
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
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
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('easy-dotnet').setup()
    end,
  },
  { 'bluz71/vim-nightfly-colors', name = 'nightfly', lazy = false, priority = 1000 },
  { 'bluz71/vim-moonfly-colors', name = 'moonfly', lazy = false, priority = 1000 },
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    priority = 1100,
  },
}
