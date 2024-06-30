return {
  { 'nvim-neorg/neorg-telescope' },
  { 'benlubas/neorg-interim-ls' },
  { 'benlubas/neorg-conceal-wrap' },
  { 'pysan3/neorg-templates' },
  {
    'nvim-neorg/neorg',
    version = '*',
    config = function()
      require 'config.neorg'
    end,
  },
}
