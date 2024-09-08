local storage = require 'bars.storage'

require('bars').setup {
  exclude_filetypes = {},
  exclude_buftypes = {},

  statuscolumn = {
    enable = true,
    parts = {},

    custom = {},
  },
  statusline = {
    enable = true,
    parts = {
      {
        -- Name of the part
        type = 'mode',

        -- Default configuration table
        default = {
          corner_left = { ' ', 'BarsStatuslineNormal' },
          padding_left = nil,

          content = { ' Normal' },

          padding_right = { ' ' },
          corner_right = { '', 'BarsStatuslineNormalSep' },
        },

        -- Configuration table for various modes
        modes = {
          ['i'] = {
            corner_left = { ' ', 'BarsStatuslineInsert' },
            content = { ' Insert' },
            corner_right = { '', 'BarsStatuslineInsertSep' },
          },
          ['c'] = {
            corner_left = { ' ', 'BarsStatuslineCmd' },
            content = { ' Command' },
            corner_right = { '', 'BarsStatuslineCmdSep' },
          },
        },
      },
      {
        type = 'bufname',

        -- Default configuration table
        default = {
          id = 'BufName',

          corner_left = nil,
          padding_left = nil,

          padding_right = nil,
          corner_right = nil,

          click = function()
            local diagMode = storage.get('statusline', 'diagnosticMode')

            if diagMode and diagMode < 5 then
              storage.set('statusline', 'diagnosticMode', diagMode + 1)
            elseif diagMode then
              storage.set('statusline', 'diagnosticMode', 0)
            else
              storage.set('statusline', 'diagnosticMode', 1)
            end

            vim.cmd 'redraws'
          end,
        },

        -- Configuration table for various file extensions
        extensions = {},
      },
      {
        -- Part type
        type = 'diagnostic',
        -- Mode, between 0 - 5
        mode = function()
          return 5
        end,

        -- Icons for diagnostic levels
        info = ' 󰍣 ',
        hint = '  ',
        warn = '  ',
        error = '  ',
      },
      {
        -- Part name
        type = 'git_branch',

        -- Default configuration
        default = {
          corner_left = { '󰊢 ', 'Comment' },
          padding_left = nil,

          content = nil,

          padding_right = nil,
          corner_right = nil,
        },

        -- Branch name based configuration
        branches = {
          {
            match = 'dev',
            corner_left = { '󰊢 ', 'CmdViolet' },
          },
        },
      },
      {
        -- Part name
        type = 'ruler',

        -- Length of the visual ruler
        max_len = 10,

        -- Parts for the visual ruler
        parts = {
          default = '─',
          line = '◆',
          column = '◇',
          both = '◈',
        },
      },
    },
    custom = {},
  },
  tabline = true,
}
