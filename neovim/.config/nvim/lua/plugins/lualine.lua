local M = {}

M.macro_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end
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
