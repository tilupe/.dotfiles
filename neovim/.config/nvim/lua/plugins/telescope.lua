return {
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("file_browser")
      end,
    },
    keys = {
      { "<leader>sf", "<cmd>Telescope file_browser path=%:p:h<cr>", desc = "File Browser current" },
      { "<leader>sF", "<cmd>Telescope file_browser<cr>", desc = "File Browser root" },
    },
  },
}
