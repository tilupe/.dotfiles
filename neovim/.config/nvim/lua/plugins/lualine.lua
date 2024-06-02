local M = {}


M.macro_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end

local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = "lualine_c_normal",
    })
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
          lualine_c = { 'filename', 'location',
            {
                "macro-recording",
                fmt = M.macro_recording,
            },
      {
        symbols.get,
        cond = symbols.has
      },
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype', 'progress' },
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
        },
        extensions = { 'quickfix' },

      }
