return {
  --{
  --  "eddyekofo94/gruvbox-flat.nvim",
  --  lazy = false,
  --  priority = 1000,
  --  config = function()
  --    vim.cmd([[colorscheme gruvbox-flat]])
  --  end,
  --},
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 900,
    config = function()
      require("gruvbox").setup({
        contrast = "soft",
        palette_overrides = {
          bright_red = "#f2594b",
        },
        overrides = {
          Keyword = { fg = "#d2890b" },
        },
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
    keys = {
      { "<leader>uc", "<cmd>ColorizerToggle<cr>", desc = "ColorizerToggle" },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      transparent_background = true,
      flavour = "latte",
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "xiyaowong/nvim-transparent",
    cmd = { "TransparentEnable", "TransparentDisable", "TransparentToggle" },
    opts = {
      extra_groups = { -- table/string: additional groups that should be cleared
        -- In particular, when you set it to 'all', that means all available groups

        -- example of akinsho/nvim-bufferline.lua
        "BufferLineTabClose",
        "BufferlineBufferSelected",
        "BufferLineFill",
        "BufferLineBackground",
        "BufferLineSeparator",
        "BufferLineIndicatorSelected",
      },
    },
    keys = {
      { "<leader>ut", "<cmd>TransparentToggle<cr>", desc = "TransparentToggle" },
    },
    config = function(_, opts)
      require("transparent").setup(opts)
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 160,
      },
    },
    keys = {
      { "<leader>mf", "<cmd>ZenMode<cr>", desc = "ZenMode" },
    },
  },
}
