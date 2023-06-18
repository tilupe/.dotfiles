return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      show_help = false,
      plugins = { spelling = true },
      key_labels = { ["<leader>"] = "SPC" },
      triggers = "auto",
    })
    wk.register({
      w = { name = "+Window" },
      q = { name = "+Quick" },
      f = { name = "+File" },
      g = { name = "+Git" },
      o = { name = "+Overseer" },
      t = { name = "+Test" },
      u = { name = "+Ui" },
      d = { name = "+Debug" },
      s = { name = "+Search" },
      b = { name = "+Buffer" },
      l = {
        name = "+Code",
        x = {
          name = "Swap Next",
          f = "Function",
          p = "Parameter",
          c = "Class",
        },
        X = {
          name = "Swap Previous",
          f = "Function",
          p = "Parameter",
          c = "Class",
        },
      },
      ["<tab>"] = { name = "+Tab" },
    }, { prefix = "<leader>" })
  end,
}
