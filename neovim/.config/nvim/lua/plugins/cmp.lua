return {
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  {
    'saadparwaiz1/cmp_luasnip',
    dependencies = { 'L3MON4D3/LuaSnip' },
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
      require 'config.cmp'
    end,
  },
}
