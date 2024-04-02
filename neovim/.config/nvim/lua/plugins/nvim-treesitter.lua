require("nvim-treesitter.configs").setup({
  ensure_installed = {
    'c',
    'c_sharp',
    'cpp',
    'css',
    'go',
    'html',
    'json',
    'lua',
    'norg',
    'python',
    'rust',
    'vimdoc',
    'yaml',
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  indent = {
    enable = true,
  }
})
