local neorg = require "neorg"

neorg.setup({
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
    ["core.export.markdown"] = {
      extensions = "md",
    },
    ["core.completion"] = {
      engine = "nvim-cmp",
    },
    ["core.manoeuvre"] = {},
    -- ["core.ui.calendar"] = {},
    ["core.integrations.telescope"] = {},
    ["core.integrations.nvim-cmp"] = {},
  },
})
