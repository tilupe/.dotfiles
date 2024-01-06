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

autocmd('ModeChanged', {
  pattern = { 'n:i', 'v:s' },
  desc = 'Disable diagnostics in insert and select mode',
  callback = function(e)
    vim.diagnostic.disable(e.buf)
  end,
})

autocmd('LspAttach', {
  group = tilupe_group,
  desc = 'Add lsp keymaps',
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = '[N]ame' }))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = '[G]oto [D]efinition' }))
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'Type [D]efinition' }))
    vim.keymap.set(
      'n',
      '<leader>ws',
      require('telescope.builtin').lsp_dynamic_workspace_symbols,
      vim.tbl_extend('force', opts, { desc = '[W]orkspace [S]ymbols' })
    )
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover Documentation' }))
    vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Documentation' }))
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = '[G]oto [D]eclaration' }))
    vim.keymap.set('i', '<C-h', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = '[G]oto [D]eclaration' }))
  end,
})
