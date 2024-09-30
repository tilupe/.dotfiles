return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
    config = function()
      require 'config.markdown'
    end,
  },
  { 'bullets-vim/bullets.vim' },
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
}
