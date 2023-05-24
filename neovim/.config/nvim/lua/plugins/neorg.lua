return {
  {

    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.integrations.telescope"] = {},
        ["core.export.markdown"] = {
          extensions = "md",
        },
        ["core.completion"] = {
          engine = "nvim-cmp",
        },
        ["core.manoeuvre"] = {},
        -- ["core.ui.calendar"] = {},
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope",
    },
    keys = {
      { "<leader>nl", "<cmd>Telescope neorg insert_file_link<cr>", desc = "Insert file link" },
      { "<leader>nw", "<cmd>Neorg workspace<cr>", desc = "workspace" },
      { "<leader>nn", "<cmd>Neorg keybind<cr>", desc = "New Note" },
      { "<leader>nr", "<cmd>Neorg return<cr>", desc = "Close & return" },
      { "<leader>nt", "<cmd>Telescope neorg<cr>", desc = "Telescope" },
    },
  },
}
