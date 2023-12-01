return {
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    enabled = true,
    config = function()
      require('notify').setup {
        background_colour = '#000000',
      }
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  {
    'savq/melange-nvim',
    event = 'VeryLazy',
    priority = 900,
    config = function()
      vim.cmd [[colorscheme melange]]
    end,
  },
  {
    'Shatur/neovim-ayu',
    lazy = false,
    config = function()
      require('ayu').setup {
        mirage = true,
        overrides = {},
      }
    end,
  },
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
          lualine_y = {},
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
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', event = 'VeryLazy', config = true },
  {
    'xiyaowong/nvim-transparent',
    cmd = { 'TransparentEnable', 'TransparentDisable', 'TransparentToggle' },
    event = 'VeryLazy',
    opts = {
      extra_groups = {
        'NormalFloat',
        'MiniClueBorder',
        'MiniFilesBorder',
        'LuaLine',
        'NoiceCmdlinePopupBorder',
        'NoiceCmdlinePopupTitle',
        'NoiceCmdlineIcon',
        'GitSignsAdd',
        'GitSignsDelete',
        'GitSignsChange',
        'CursorLine',
      },
    },
    keys = require('config.keymaps').transparent,
    config = true,
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = true,
    keys = require('config.keymaps').colorizer,
  },
}
