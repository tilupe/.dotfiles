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
    ft = { 'markdown', 'norg', 'rmd', 'org', 'vimwiki', 'Avante' },
    opts = {
      preview = {
        icon_provider = 'mini',
        enable_hybrid_mode = true,
        hybrid_modes = { 'n', 'i' },
        filetypes = { 'markdown', 'norg', 'rmd', 'org', 'vimwiki', 'Avante' },
      },
    },

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
    },
  },
}
