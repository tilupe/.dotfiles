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
    keys = {
      { '<leader>gd', '<CMD>DiffviewOpen<CR>', { desc = '[d]iffview Open' } },
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
      { '<leader>gb', '<CMD>Gitsigns blame_line<CR>', { desc = 'prev-hunk' } },
    },
  },
  { 'Tastyep/structlog.nvim' },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'config.lualine'
    end,
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
  { 'echasnovski/mini.icons', version = false, config = true },
  { 'NicholasMata/nvim-dap-cs' },
  {
    'neanias/everforest-nvim',
    priority = 1000,
    config = function()
      require('everforest').setup {
        background = 'hard',
      }
      vim.cmd [[colorscheme everforest]]
    end,
  },
  { 'savq/melange-nvim' },
  { 'norcalli/nvim-colorizer.lua' },
  { 'moreiraio/razor.nvim' },
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
          next = '<C-j>',
          prev = '<C-k>',
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
  { 'folke/lazydev.nvim', version = '*' },
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
  { 'folke/zen-mode.nvim', version = '*' },
  { '3rd/image.nvim', version = '*' },
  {
    'SuperBo/fugit2.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
      {
        'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
        dependencies = { 'stevearc/dressing.nvim' },
      },
    },

    config = function()
      require('fugit2').setup {
        libgit2_path = 'libgit2.so.1.1',
      }
    end,
    cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph', 'Fugit2Blame' },
    keys = {

      {
        '<leader>go',
        function()
          vim.cmd 'Fugit2'
        end,
        { desc = '[g]it' },
      },
      {
        '<leader>gB',
        function()
          vim.cmd 'Fugit2Blame'
        end,
        { desc = 'Blame' },
      },
      -- {
      --   '<leader>gl',
      --   function()
      --     vim.cmd 'Fugit2Graph'
      --   end,
      --   { desc = 'Log' },
      -- },
    },
  },
  {
    'echasnovski/mini.diff',
    version = '*',
    config = function()
      require('fugit2').setup {
        libgit2_path = 'libgit2.so.1.1',
      }
    end,
    keys = {
      {
        '<leader>gp',
        function()
          require('mini.diff').toggle_overlay()
        end,
        { desc = 'preview toggle' },
      },
    },
  },
  { 'nvim-telescope/telescope.nvim' },
  {
    'rmagatti/auto-session', -- auto save session
    config = function()
      require('auto-session').setup {
        log_level = 'error',
        auto_session_suppress_dirs = {
          '~/',
          '~/Downloads',
          '~/Documents',
        },
        auto_session_use_git_branch = true,
        auto_save_enabled = true,
      }
    end,
    keys = {
      {
        '<leader>qq',
        function()
          vim.cmd 'SessionDelete'
          vim.cmd 'qq'
        end,
        { desc = 'Save Session' },
      },
      {
        '<leader>sl',
        function()
          require('auto-session').load()
        end,
        { desc = 'Load Session' },
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  -- {
  --   'kylechui/nvim-surround', -- surround objects
  --   config = function()
  --     require('nvim-surround').setup {}
  --   end,
  -- },
  { 'echasnovski/mini.surround', version = '*', config = true },
  {
    'stevearc/overseer.nvim',
    config = function()
      require 'config.overseer'
    end,
  },
  -- {
  --   'folke/flash.nvim',
  --   event = 'VeryLazy',
  --   opts = {},
  --   keys = {
  --     {
  --       's',
  --       mode = { 'n', 'x', 'o' },
  --       function()
  --         require('flash').jump()
  --       end,
  --       desc = 'Flash',
  --     },
  --     {
  --       'S',
  --       mode = { 'n', 'x', 'o' },
  --       function()
  --         require('flash').treesitter()
  --       end,
  --       desc = 'Flash Treesitter',
  --     },
  --     {
  --       'r',
  --       mode = 'o',
  --       function()
  --         require('flash').remote()
  --       end,
  --       desc = 'Remote Flash',
  --     },
  --     {
  --       'R',
  --       mode = { 'o', 'x' },
  --       function()
  --         require('flash').treesitter_search()
  --       end,
  --       desc = 'Treesitter Search',
  --     },
  --     {
  --       '<c-s>',
  --       mode = { 'c' },
  --       function()
  --         require('flash').toggle()
  --       end,
  --       desc = 'Toggle Flash Search',
  --     },
  --   },
  -- },
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },
  {
    'https://git.sr.ht/~swaits/zellij-nav.nvim',
    lazy = true,
    event = 'VeryLazy',
    keys = {
      { '<A-h>', '<cmd>ZellijNavigateLeft<cr>', { silent = true, desc = 'navigate left' } },
      { '<A-j>', '<cmd>ZellijNavigateDown<cr>', { silent = true, desc = 'navigate down' } },
      { '<A-k>', '<cmd>ZellijNavigateUp<cr>', { silent = true, desc = 'navigate up' } },
      { '<A-l>', '<cmd>ZellijNavigateRight<cr>', { silent = true, desc = 'navigate right' } },
    },
    opts = {},
  },
  {
    'ramilito/kubectl.nvim',
    config = function()
      require('kubectl').setup()
    end,
    keys = {
      { '<leader>k', '<cmd>lua require("kubectl").open()<cr>', { noremap = true, silent = true } },
    },
  },
  { --  colorscheme
    'vague2k/vague.nvim',
    config = function()
      require('vague').setup {
        transparent = true,
      }
    end,
  },
  { 'echasnovski/mini.ai', version = '*' },
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
      symbols = {
        merge_commit = '',
        commit = '◯',
        merge_commit_end = '',
        commit_end = '',
        --
        --   -- Advanced symbols
        --   -- GVER = '',
        --   -- GHOR = '',
        GCLD = '╮',
        GCRD = '╭',
        --    '': [hline],
        -- '': [vline],
        -- '': [p(fading_hline, num=4, fade='right')],
        -- '': [p(fading_hline, num=4, fade='left')],
        -- '': [p(fading_vline, num=5, fade='down')],
        -- '': [p(fading_vline, num=5, fade='up')],
        -- '': [p(rounded_corner, which='╭')],
        -- '': [p(rounded_corner, which='╮')],
        -- '': [p(rounded_corner, which='╰')],
        -- '': [p(rounded_corner, which='╯')],
        -- '': [vline, p(rounded_corner, which='╰')],
        -- '': [vline, p(rounded_corner, which='╭')],
        -- '': [p(rounded_corner, which='╰'), p(rounded_corner, which='╭')],
        -- '': [vline, p(rounded_corner, which='╯')],
        -- '': [vline, p(rounded_corner, which='╮')],
        -- '': [p(rounded_corner, which='╮'), p(rounded_corner, which='╯')],
        -- '': [hline, p(rounded_corner, which='╮')],
        -- '': [hline, p(rounded_corner, which='╭')],
        -- '': [p(rounded_corner, which='╭'), p(rounded_corner, which='╮')],
        -- '': [hline, p(rounded_corner, which='╯')],
        -- '': [hline, p(rounded_corner, which='╰')],
        -- '': [p(rounded_corner, which='╰'), p(rounded_corner, which='╯')],
        -- '': [vline, p(rounded_corner, which='╰'), p(rounded_corner, which='╯')],
        -- '': [vline, p(rounded_corner, which='╭'), p(rounded_corner, which='╮')],
        -- '': [hline, p(rounded_corner, which='╮'), p(rounded_corner, which='╯')],
        -- '': [hline, p(rounded_corner, which='╰'), p(rounded_corner, which='╭')],
        -- '': [vline, p(rounded_corner, which='╭'), p(rounded_corner, which='╯')],
        -- '': [vline, p(rounded_corner, which='╮'), p(rounded_corner, which='╰')],
        -- '': [hline, p(rounded_corner, which='╭'), p(rounded_corner, which='╯')],
        -- '': [hline, p(rounded_corner, which='╮'), p(rounded_corner, which='╰')],
        -- '': [commit],
        -- '': [p(commit, solid=False)],
        -- '': [p(commit, line='right')],
        -- '': [p(commit, solid=False, line='right')],
        -- '': [p(commit, line='left')],
        -- '': [p(commit, solid=False, line='left')],
        -- '': [p(commit, line='horizontal')],
        -- '': [p(commit, solid=False, line='horizontal')],
        -- '': [p(commit, line='down')],
        -- '': [p(commit, solid=False, line='down')],
        -- '': [p(commit, line='up')],
        -- '': [p(commit, solid=False, line='up')],
        -- '': [p(commit, line='vertical')],
        -- '': [p(commit, solid=False, line='vertical')],
        --   GCLU = '',
        --   GCRU = '',
        --   GLRU = '',
        --   GLRD = '',
        --   GLUD = '',
        --   GRUD = '',
        --   GFORKU = '',
        --   GFORKD = '',
        --   GRUDCD = '',
        --   GRUDCU = '',
        --   GLUDCD = '',
        --   GLUDCU = '',
        --   GLRDCL = '',
        --   GLRDCR = '',
        --   GLRUCL = '',
        --   GLRUCR = '',
      },
    },
    init = function()
      vim.keymap.set('n', '<leader>gl', function()
        require('gitgraph').draw({}, { all = true, max_count = 5000 })
      end, { desc = 'new git graph' })
    end,
  },
}
