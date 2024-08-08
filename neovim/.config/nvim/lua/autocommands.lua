local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- local format_group = vim.api.nvim_create_augroup('Format', { clear = true })
-- autocmd('BufWritePre', {
--   callback = function()
--     vim.cmd 'Neoformat'
--   end,
--   group = format_group,
--   pattern = '*',
-- })

local lsp_setup = vim.api.nvim_create_augroup('LspSetup', { clear = true })
autocmd('LspAttach', {
  callback = function()
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[N]ame' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [Implementation]' })
    vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[g]oto [D]eclaration' })
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { desc = '[G]oto [D]eclaration' })
  end,
  group = lsp_setup,
  pattern = '*',
})
