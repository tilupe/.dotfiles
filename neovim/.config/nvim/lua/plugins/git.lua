return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Open Diffview" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Clsoe Diffview" },
    },
  },
}
