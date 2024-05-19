local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local tilupe_group = augroup('tilupe', { clear = true })


local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- autocmd('BufReadPre', {
--   callback = function()
--     require("rocks").packadd("mason-lspconfig")
--   end,
--   group = tilupe_group,
--   pattern = '*',
-- })


--autocmd('LspAttach', {
--  group = tilupe_group,
--  desc = 'Add lsp keymaps',
--  callback = function(e)
--    local opts = { buffer = e.buf }
--    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = '[N]ame' }))
--    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = '[G]oto [D]efinition' }))
--    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = 'Type [D]efinition' }))
--    vim.keymap.set(
--      'n',
--      '<leader>ws',
--      require('telescope.builtin').lsp_dynamic_workspace_symbols,
--      vim.tbl_extend('force', opts, { desc = '[W]orkspace [S]ymbols' })
--    )
--    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover Documentation' }))
--    vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Documentation' }))
--    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = '[G]oto [D]eclaration' }))
--    vim.keymap.set('i', '<C-h', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = '[G]oto [D]eclaration' }))
--  end,
--})
