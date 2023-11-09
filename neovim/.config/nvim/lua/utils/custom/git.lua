local M = {}

M.status = function()
  local neogit = require 'neogit'
  return neogit.open { kind = 'replace' }
end

M.commit = function()
  local neogit = require 'neogit'
  return neogit.open { 'commit' }
end

return M
