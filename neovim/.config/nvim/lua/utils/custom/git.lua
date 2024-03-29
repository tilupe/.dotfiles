local M = {}

M.status = function()
  local neogit = require 'neogit'
  return neogit.open { kind = 'replace' }
end

M.commit = function()
  local neogit = require 'neogit'
  return neogit.open { 'commit' }
end

M.push = function()
  local neogit = require 'neogit'
  return neogit.open { 'push' }
end

M.pull = function()
  local neogit = require 'neogit'
  return neogit.open { 'pull' }
end

M.log = function()
  local neogit = require 'neogit'
  return neogit.open { 'log' }
end

return M
