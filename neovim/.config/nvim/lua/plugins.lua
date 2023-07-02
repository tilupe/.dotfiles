--[[
  File: plugins.lua
  Description: This file needed for loading plugin list into lazy.nvim and loading plugins
  Info: Use <zo> and <zc> to open and close foldings
  See: https://github.com/folke/lazy.nvim
]]

require "helpers/globals"

return {
  -- Mason {{{
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require "extensions.mason"
    end
  },
  -- }}}

  -- Neo Tree {{{
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require "extensions.neotree"
    end
  },
  -- }}}

  -- Telescope {{{
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require "extensions.telescope"
    end
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  -- }}}

  -- CMP Autocompletion{{{
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require "extensions.cmp"
    end
  },
  -- }}}

  -- LSP Kind {{{
  {
    'onsails/lspkind-nvim',
    lazy = true,
    config = function()
      require "extensions.lspkind"
    end
  },
  -- }}}

  -- Git {{{
  {
    'lewis6991/gitsigns.nvim',
    event = "VeryLazy",
    config = function()
      require "extensions.gitsigns"
    end
  },

  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  -- }}}

  -- Trouble {{{
  {
    "folke/trouble.nvim",
    lazy = true,
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require "extensions.trouble"
    end,
  },
  -- }}}

  -- TreeSitter {{{
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require "extensions.treesitter"
    end
  },
  -- }}}

  -- WhichKey {{{
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require "extensions.whichkey"
    end,
  },
  -- }}}

  -- Mini {{{
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
  -- }}}

  -- Tools {{{
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    cmd = { "ToggleTerm", "TermExec" },
    config = function()
      require "extensions.toggleterm"
    end
  },
  -- }}}

  -- Notes {{{
  {

    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope",
    },
    config = function()
      require "extensions.neorg"
    end,
    keys = {
      { "<leader>nl", "<cmd>Telescope neorg insert_file_link<cr>", desc = "Insert file link" },
      { "<leader>nw", "<cmd>Neorg workspace<cr>",                  desc = "workspace" },
      { "<leader>nn", "<cmd>Neorg keybind<cr>",                    desc = "New Note" },
      { "<leader>nr", "<cmd>Neorg return<cr>",                     desc = "Close & return" },
      { "<leader>nt", "<cmd>Telescope neorg<cr>",                  desc = "Telescope" },
    },
  },
  -- }}}

  -- Theme: Sonokai {{{
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      require "extensions.colorscheme.sonokai"
    end
  }
  -- }}}
}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
