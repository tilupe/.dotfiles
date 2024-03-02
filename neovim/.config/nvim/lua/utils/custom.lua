local M = {}

M.macro_recording = function()
  local recording_register = vim.fn.reg_recording()
  if recording_register == '' then
    return ''
  else
    return 'Recording @' .. recording_register
  end
end
return M
