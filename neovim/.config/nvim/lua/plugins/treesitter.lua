return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update { with_sync = true }()
    end,
    config = function()
      local configs = require 'nvim-treesitter.configs'
      configs.setup {
        ensure_installed = {
          'c',
          'c_sharp',
          'cpp',
          'css',
          'regex',
          'elixir',
          'go',
          'heex',
          'html',
          'markdown',
          'markdown_inline',
          'norg',
          'html',
          'latex',
          'javascript',
          'typst',
          'json',
          'lua',
          'python',
          'query',
          'rust',
          'vim',
          'vimdoc',
          'yaml',
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  { 'yorickpeterse/nvim-tree-pairs', config = true },
}
