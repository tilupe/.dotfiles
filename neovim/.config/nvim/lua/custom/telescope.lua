local M = {}

function M.search_notes()
  require("telescope.builtin").grep_string({
    shorten_path = true,
    search = vim.fn.input("Rg> "),
  })
end

return M
