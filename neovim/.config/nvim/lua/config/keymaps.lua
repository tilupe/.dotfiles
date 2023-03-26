local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>")
keymap("t", "jk", "<C-\\><C-n>")
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Add undo break-points
---- keymap("i", ",", ",<c-g>u") -- Todo find out what this does
---- keymap("i", ".", ".<c-g>u") -- Todo find out what this does
---- keymap("i", ";", ";<c-g>u") -- Todo find out what this does

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP')

-- Move Lines
---- keymap("n", "<A-j>", ":m .+1<CR>==") -- Uncomment if acutally needed
---- keymap("v", "<A-j>", ":m '>+1<CR>gv=gv") -- Uncomment if acutally needed
---- keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi") -- Uncomment if acutally needed
---- keymap("n", "<A-k>", ":m .-2<CR>==") -- Uncomment if acutally needed
---- keymap("v", "<A-k>", ":m '<-2<CR>gv=gv") -- Uncomment if acutally needed
---- keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi") -- Uncomment if acutally needed

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Better Window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>ww", "<cmd>update!<CR>", { desc = "Save" })
map("n", "<leader>wa", "<cmd>wa<CR>", { desc = "Save all" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete" })
map("n", "<leader>ws", "<C-W>s", { desc = "Split below" })
map("n", "<leader>wv", "<C-W>v", { desc = "Split right" })

-- Git
map("n", "<leader>gg", "<cmd>lua require('util').Lazygit_toggle()<cr>", { desc = "Lazygit" })
