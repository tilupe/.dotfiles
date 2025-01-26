return {
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  --   config = function()
  --     require 'config.markdown'
  --   end,
  -- },
  { 'bullets-vim/bullets.vim' },
  -- { 'jghauser/follow-md-links.nvim' },
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require 'config.obsidian'
    end,
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway
    opts = {
      preview = {
        hybrid_modes = { 'n', 'i' },
      },
    },

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
