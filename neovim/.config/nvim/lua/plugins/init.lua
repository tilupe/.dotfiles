return {
  { 'nvim-lua/plenary.nvim' },
  {
    'seblj/roslyn.nvim',
    config = function()
      require('roslyn').setup {
        exe = vim.fs.joinpath(vim.fn.stdpath 'data' --[[@as string]], 'roslyn', 'Microsoft.CodeAnalysis.LanguageServer.dll'),
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
      { '<leader>gD', '<CMD>DiffviewOpen<CR>', { desc = '[D]iffview Close' } },
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
      { '<leader>gq', '<CMD>Gitsigns setqflist<CR>', { desc = 'prev-hunk' } },
    },
  },
  { 'nvim-neotest/neotest' },
  { 'Issafalcon/neotest-dotnet' },
  { 'nvim-neotest/neotest-python' },
  { 'nvim-neotest/neotest-plenary' },
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
        dir_path = '~/notes/neorg/assets/imgs', ---@type string
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
          next = '<C-e>',
          prev = '<C-r>',
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
  { 'mfussenegger/nvim-dap', version = '*' },
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
  { 'SuperBo/fugit2.nvim', event = 'BufRead', version = '*' },
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
    {
      '<leader>gl',
      function()
        vim.cmd 'Fugit2Graph'
      end,
      { desc = 'Log' },
    },
  },
  {
    'echasnovski/mini.diff',
    version = '*',
    config = true,
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
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    'kylechui/nvim-surround', -- surround objects
    config = function()
      require('nvim-surround').setup {}
    end,
  },
  { 'stevearc/overseer.nvim' },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  {
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },
}
