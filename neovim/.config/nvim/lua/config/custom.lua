local M = {}

M.telescope = {
  find_files = function()
    require('telescope.builtin').marks(require('telescope.themes').get_dropdown {})
  end,
}

return M
