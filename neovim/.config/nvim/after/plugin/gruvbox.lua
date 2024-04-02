require('gruvbox').setup {
        contrast = 'soft',
        palette_overrides = {
          bright_red = '#f2594b',
        },
        overrides = {
          Keyword = { fg = '#d2890b' },
        },
      }

vim.cmd([[colorscheme gruvbox]])
