require "neotest".setup({
  adapters = {
    require 'neotest-plenary',
    require 'neotest-dotnet',
  },
  icons = {
    expanded = '',
    child_prefix = '',
    child_indent = '',
    final_child_prefix = '',
    non_collapsible = '',
    collapsed = '',
    passed = '',
    running = '',
    failed = '',
    unknown = '',
    skipped = '',
  },
  -- overseer.nvim
  consumers = {
    overseer = require 'neotest.consumers.overseer',
  },
  overseer = {
    enabled = true,
    force_default = true,
  },
  loglevel = 3,
})

vim.keymap.set('n', '<leader>tF', "<cmd>lua require('plugins.dap.functions').run(vim.fn.expand('%'))<cr>",
  { desc = 'Debug File', })
vim.keymap.set('n', '<leader>tL', "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>",
  { desc = 'Debug Last' })
vim.keymap.set('n', '<leader>ta', "<cmd>lua require('neotest').run.attach()<cr>", { desc = 'Attach' })
vim.keymap.set('n', '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = 'File' })
vim.keymap.set('n', '<leader>tl', "<cmd>lua require('neotest').run.run_last()<cr>", { desc = 'Last' })
vim.keymap.set('n', '<leader>tn', "<cmd>lua require('neotest').run.run()<cr>", { desc = 'Nearest' })
vim.keymap.set('n', '<leader>tN', "<cmd>lua require('plugins.dap.functions').run()<cr>", { desc = 'Debug Nearest' })
vim.keymap.set('n', '<leader>to', "<cmd>lua require('neotest').output.open({ enter = true })<cr>", { desc = 'Output' })
vim.keymap.set('n', '<leader>ts', "<cmd>lua require('neotest').run.stop()<cr>", { desc = 'Stop' })
vim.keymap.set('n', '<leader>tS', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = 'Summary' })
