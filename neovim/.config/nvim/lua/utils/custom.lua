local M = {}

M.find_files = function()
  local tele = require 'telescope.builtin'
  local themes = require 'telescope.themes'
  tele.find_files(themes.get_ivy {
    winblend = 10,
    previewer = false,
  })
end

M.git {
  status = function()
    local neogit = require 'neogit'
    return neogit.open { kind = 'floating' }
  end,
}
return M
