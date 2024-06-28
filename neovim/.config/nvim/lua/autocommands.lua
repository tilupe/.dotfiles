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

local format_group = vim.api.nvim_create_augroup('Format', { clear = true })
autocmd('BufWritePre', {
  callback = function()
    vim.cmd 'Neoformat'
  end,
  group = format_group,
  pattern = '*',
})
