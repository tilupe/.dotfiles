local ls = require"luasnip"

local group = vim.api.nvim_create_augroup("Csharp Snippets", {clear = true})
local file_pattern = "*.cs"

require"luasnip.loaders.from_lua".load({paths = "~/.config/nvim/snippets/"})
require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})

