return {
  --
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 900,
    config = function()
      require('gruvbox').setup {
        contrast = 'soft',
        palette_overrides = {
          bright_red = '#f2594b',
        },
        overrides = {
          Keyword = { fg = '#d2890b' },
        },
      }
      vim.cmd [[colorscheme gruvbox]]
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',

    config = function()
      --local components = require 'plugins.statusline.components'

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = {},
          section_separators = {},
          disabled_filetypes = {
            statusline = { 'alpha', 'lazy' },
            winbar = {
              'help',
              'alpha',
              'lazy',
            },
          },
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = { require('utils.lualine').lsp_client },
          lualine_x = { 'filename', 'encoding', 'fileformat', 'filetype', 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
        },
        extensions = { 'quickfix' },
      }
    end,
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = 'ibl',
    opts = {},
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', event = 'VeryLazy', config = true },
  {
    'xiyaowong/nvim-transparent',
    cmd = { 'TransparentEnable', 'TransparentDisable', 'TransparentToggle' },
    event = 'VeryLazy',
    opts = {
      extra_groups = { -- table/string: additional groups that should be cleared
        'NormalFloat',
        'MiniClueBorder',
        'MiniFilesBorder',
        'LuaLine',
      },
    },
    keys = {
      { '<leader>ut', '<cmd>TransparentToggle<cr>', desc = 'TransparentToggle' },
    },
    config = true,
  },
}
