local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local tilupe_group = augroup('tilupe', { clear = true })

---- FileType
-- Hide statusline on dashboard
autocmd('FileType', {
  pattern = 'alpha',
  group = augroup('filegroup', { clear = true }),
  command = 'setlocal laststatus=0 noruler',
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
