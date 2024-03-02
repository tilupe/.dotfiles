local M = {}

M.setup = function()
  vim.keymap.set('n', 'H', 'u', { buffer = 0 })
  vim.keymap.set('n', 'h', '-^', { buffer = 0 })
  vim.keymap.set('n', 'l', '<CR>', { silent = true, buffer = 0 })
  vim.keymap.set('n', '.', 'gh', { silent = true, buffer = 0 })
  vim.keymap.set('n', 'P', '<C-w>z', { silent = true, buffer = 0 })
  vim.keymap.set('n', 'L', '<CR><CMD>Lexplore<CR>', { silent = true, buffer = 0 })
  vim.keymap.set('n', 'q', '<CMD>Lexplore<CR>', { silent = true, buffer = 0 })
end

return M
