require"blame".setup()

vim.keymap.set("n", "<leader>gB", "<CMD>BlameToggle<CR>", { desc = "Blame File"})
