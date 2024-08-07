local harpoon = require 'harpoon'

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set('n', '<leader>m', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<leader>hh', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<leader>ha', function()
  harpoon:list():select(1)
end)
vim.keymap.set('n', '<leader>hs', function()
  harpoon:list():select(2)
end)
vim.keymap.set('n', '<leader>hd', function()
  harpoon:list():select(3)
end)
vim.keymap.set('n', '<leader>hf', function()
  harpoon:list():select(4)
end)
vim.keymap.set('n', '<leader>hv', function()
  harpoon:list():select(5)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<C-S-P>', function()
  harpoon:list():prev()
end)
vim.keymap.set('n', '<C-S-N>', function()
  harpoon:list():next()
end)
