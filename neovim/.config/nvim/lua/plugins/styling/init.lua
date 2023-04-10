return {
  {
    "eddyekofo94/gruvbox-flat.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox-flat]])
    end,
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
      exclude = {}, -- table: groups you don't want to clear
    },
    config = function(_, opts)
      require("transparent").setup(opts)
    end,
  },
}
