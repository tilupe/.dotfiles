require "helpers/globals"
require "helpers/keyboard"

g.mapleader =
' '                    -- Use Space, like key for alternative hotkeys
g.maplocalleader =
','                    -- Use Space, like key for alternative hotkeys

-- LSP {{{
nm('K', '<cmd>lua vim.lsp.buf.hover()<CR>')        -- Hover object
nm('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- Code actions
nm('gR', '<cmd>lua vim.lsp.buf.rename()<CR>')      -- Rename an object
nm('gD', '<cmd>lua vim.lsp.buf.declaration()<cr>') -- Go to declaration
-- }}}

-- Telescope {{{

nm('gd', '<cmd>Telescope lsp_definitions<CR>') -- Goto declaration
-- }}}

-- Trouble {{{
nm('<leader>x', '<cmd>TroubleToggle<CR>')   -- Show all problems in project (with help of LSP)
nm('gr', '<cmd>Trouble lsp_references<CR>') -- Show use of object in project
-- }}}

-- Neo Tree {{{
nm('<leader>v', '<cmd>NeoTreeFocusToggle<CR>') -- Toggle file explorer
-- }}}

-- Git {{{

nm("<leader>gg", "<cmd>Git<cr>", { desc = "Status" })
nm("<leader>gb", "<cmd>Git blame<cr>", { desc = "Blame" })
nm("<leader>gP", "<cmd>Git -c push.default=current push<cr>", { desc = "Push" })
nm("<leader>gp", "<cmd>Git pull<cr>", { desc = "Pull" })
nm("<leader>gdf", "<cmd>Gvdiffsplit<cr>", { desc = "File" })
nm("<leader>gdm", "<cmd>Gvdiff origin/master<cr>", { desc = "Master" })
nm("<leader>gsf", "<cmd>Gwrite<cr>", { desc = "File" })
nm("<leader>gsR", "<cmd>Gwrite<cr>", { desc = "Reset File" })
nm("<leader>gl", "<cmd>lua require('extensions.toggleterm').Lazygit_toggle()<cr>", { desc = "Lazygit" })
-- }}}

-- Tools {{{
nm("<leader>0", "<Cmd>2ToggleTerm<Cr>", { desc = "Floatterm" })
-- }}}

-- Notes {{{
nm("<leader>nl", "<cmd>Telescope neorg insert_file_link<cr>", { desc = "Insert file link" })
nm("<leader>nw", "<cmd>Neorg workspace<cr>", { desc = "workspace" })
nm("<leader>nn", "<cmd>Neorg keybind<cr>", { desc = "New Note" })
nm("<leader>nr", "<cmd>Neorg return<cr>", { desc = "Close & return" })
nm("<leader>nt", "<cmd>Telescope neorg<cr>", { desc = "Telescope" })
-- }}}


-- General {{{

-- Remap for dealing with word wrap
--nm("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
--nm("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
nm("n", "nzzzv")
nm("N", "Nzzzv")
nm("g,", "g,zvzz")
nm("g;", "g;zvzz")

-- Better escape using jk in insert and terminal mode
im("jk", "<ESC>")
tm("jk", "<C-\\><C-n>")
tm("<C-h>", "<C-\\><C-n><C-w>h")
tm("<C-j>", "<C-\\><C-n><C-w>j")
tm("<C-k>", "<C-\\><C-n><C-w>k")
tm("<C-l>", "<C-\\><C-n><C-w>l")

-- Add undo break-points
---- im(",", ",<c-g>u") -- Todo find out what this does
---- im(".", ".<c-g>u") -- Todo find out what this does
---- im(";", ";<c-g>u") -- Todo find out what this does

-- Better indent
vm("<", "<gv")
vm(">", ">gv")

-- Paste over currently selected text without yanking it
vm("p", '"_dP')

-- Move Lines
---- nm("<A-j>", ":m .+1<CR>==") -- Uncomment if acutally needed
---- vm("<A-j>", ":m '>+1<CR>gv=gv") -- Uncomment if acutally needed
---- im("<A-j>", "<Esc>:m .+1<CR>==gi") -- Uncomment if acutally needed
---- nm("<A-k>", ":m .-2<CR>==") -- Uncomment if acutally needed
---- vm("<A-k>", ":m '<-2<CR>gv=gv") -- Uncomment if acutally needed
---- im("<A-k>", "<Esc>:m .-2<CR>==gi") -- Uncomment if acutally needed

-- Resize window using <shift> arrow keys
nm("<S-Up>", "<cmd>resize +2<CR>")
nm("<S-Down>", "<cmd>resize -2<CR>")
nm("<S-Left>", "<cmd>vertical resize -2<CR>")
nm("<S-Right>", "<cmd>vertical resize +2<CR>")

-- Better Window navigation
nm("<C-h>", "<C-w>h")
nm("<C-j>", "<C-w>j")
nm("<C-k>", "<C-w>k")
nm("<C-l>", "<C-w>l")

nm("<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
nm("<leader>ww", "<cmd>update!<CR>", { desc = "Save" })
nm("<leader>wa", "<cmd>wa<CR>", { desc = "Save all" })
nm("<leader>wk", "<cmd>wq<CR>", { desc = "Save & Kuit" })
nm("<leader>wd", "<C-W>c", { desc = "Delete" })
nm("<leader>ws", "<C-W>s", { desc = "Split below" })
nm("<leader>wv", "<C-W>v", { desc = "Split right" })

nm("<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close" })

nm("<F5>", "<cmd>e<cr>", { desc = "Reload file" })
--}}}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
