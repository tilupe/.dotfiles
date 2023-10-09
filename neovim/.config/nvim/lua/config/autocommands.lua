local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

---- FileType
-- Hide statusline on dashboard
autocmd('FileType', {
  pattern = 'alpha',
  group = augroup('filegroup', { clear = true }),
  command = 'setlocal laststatus=0 noruler',
})

---- BufWritePre
-- format on save
autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format { bufnr = args.buf }
  end,
})

----TextYankPost
-- highlight text when yanking
--autocmd('TextYankPost', {
--  callback = function()
--    vim.highlight.on_yank()
--  end,
--  desc = 'Briefly highlight yanked text',
--  group = augroup('yank', { clear = true }),
--})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
