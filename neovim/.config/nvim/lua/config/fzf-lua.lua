local fzf = require 'fzf-lua'
fzf.setup {
  file_icons = 'mini',
  formatter = 'path.filename_first',
  previewers = {
    builtin = {
      extensions = {
        ['png'] = { 'viu', '-b' },
        ['jpg'] = { 'ueberzug' },
        ['jpeg'] = { 'ueberzug' },
      },
    },
  },
}

vim.keymap.set('n', '<leader><space>', function()
  fzf.files { formatter = 'path.filename_first', winopts = { split = 'belowright new' } }
end, { desc = 'files' })
vim.keymap.set('n', '<leader>ff', function()
  vim.cmd 'FzfLua'
end, { desc = 'fzfLua' })
vim.keymap.set('n', '<leader>fs', function()
  fzf.live_grep_glob { formatter = 'path.filename_first', winopts = { split = 'belowright new' } }
end, { desc = 'string live grep' })
vim.keymap.set('n', '<leader>fr', function()
  vim.cmd 'FzfLua resume'
end, { desc = 'resume' })
vim.keymap.set('n', '<leader>fw', function()
  vim.cmd 'FzfLua grep_cWORD'
end, { desc = 'word grep' })
vim.keymap.set('n', '<leader>fo', function()
  vim.cmd 'FzfLua oldfiles'
end, { desc = 'oldfiles' })
vim.keymap.set('n', '<leader>fi', function()
  require('fzf-lua').lsp_implementations { jump_to_single_result = true }
end, { desc = 'implementations' })
vim.keymap.set('n', '<leader>ca', function()
  require('fzf-lua').lsp_code_actions { winopts = { height = 0.25, width = 0.8 } }
end, { desc = 'actions' })
vim.keymap.set('n', 'gr', function()
  require('fzf-lua').lsp_references { sync = true, ignore_current_line = true, includeDeclaration = false, jump_to_single_result = true }
end, { desc = 'references' })
vim.keymap.set('n', 'gd', function()
  require('fzf-lua').lsp_definitions { sync = true, ignore_current_line = true, includeDeclaration = false, jump_to_single_result = true }
end, { desc = 'definitions' })
vim.keymap.set('v', '<C-s>', function()
  vim.cmd 'FzfLua grep_visual'
end, { desc = 'grep string' })
