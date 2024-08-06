return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    config = function ()
      require"config.markdown"
    end
  },
  -- {
  --   'OXY2DEV/markview.nvim',
  --   lazy = false, -- Recommended
  --   -- ft = "markdown" -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --     -- You will not need this if you installed the
  --     -- parsers manually
  --     -- Or if the parsers are in your $RUNTIMEPATH
  --     'nvim-treesitter/nvim-treesitter',
  --
  --     'nvim-tree/nvim-web-devicons',
  --   },
  --   config = function()
  --     require('markview').setup {
  --       modes = { 'n', 'I' }, -- If you are using it in insert mode
  --       hybrid_modes = { 'i' },
  --     }
  --   end,
  -- },
  { 'bullets-vim/bullets.vim' },
  {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require 'config.obsidian'
    end,
  },
}
