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
            ["csharp|code_lens"] = {
                dotnet_enable_references_code_lens = true,
            },
            ["csharp|symbol_search"] = {
                dotnet_search_reference_assemblies = true,
            },
            ["csharp|completion"] = {
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_show_name_completion_suggestions = true,
            },
            ["csharp|background_analysis"] = {
                dotnet_analyzer_diagnostics_scope = "fullSolution",
                dotnet_compiler_diagnostics_scope= "fullSolution",
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
      { '<leader>gb', '<CMD>Gitsigns blame_line<CR>', { desc = 'prev-hunk' } },
    },
  },
  { 'Tastyep/structlog.nvim' },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'folke/trouble.nvim' },
    config = function()
      --require 'config.lualine'
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
  -- {
  --   'stevearc/conform.nvim',
  --   event = 'BufReadPre',
  --   opts = {
  --     formatters_by_ft = {
  --       cs = { 'csharpier' },
  --       lua = { 'stylua' },
  --       -- Conform will run multiple formatters sequentially
  --       python = { 'isort', 'black' },
  --       -- You can customize some of the format options for the filetype (:help conform.format)
  --       rust = { 'rustfmt', lsp_format = 'fallback' },
  --       -- Conform will run the first available formatter
  --       javascript = { 'prettierd', 'prettier', stop_after_first = true },
  --     },
  --     formatters = {
  --       csharpier = {
  --         command = 'dotnet-csharpier',
  --         args = { '--write-stdout' },
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       '<leader>cf',
  --       function()
  --         require('conform').format()
  --       end,
  --       { desc = '[c]ode [f]ormat' },
  --     },
  --   },
  -- },
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
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.statusline').setup()
    end,
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
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = function()
      local ai = require 'mini.ai'
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          },
          f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
          c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
          d = { '%f[%d]%d+' }, -- digits
          e = { -- Word with case
            { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
            '^().*()$',
          },
          -- i = LazyVim.mini.ai_indent, -- indent
          -- g = LazyVim.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      require('mini.ai').setup(opts)
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
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>y',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- Open in the current working directory
        '<leader>cw',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss All Notifications',
      },
    },
    opts = {
      stages = 'static',
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },
  -- lazy.nvim
  {
    'GustavEikaas/easy-dotnet.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('easy-dotnet').setup()
    end,
  },
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      local nvim_tmux_nav = require 'nvim-tmux-navigation'

      nvim_tmux_nav.setup {
        disable_when_zoomed = true, -- defaults to false
      }

      vim.keymap.set('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set('n', '<C-CR>', nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },
}
