-- From https://github.com/sindrets/diffview.nvim/blob/main/USAGE.md 
if vim.fn.executable("nvr") == 1 then
  local nvr = "nvr --servername " .. vim.v.servername .. " "
  vim.env.GIT_EDITOR = nvr .. "-cc split +'setl bh=delete' --remote-wait"
  vim.env.EDITOR = nvr .. "-l --remote" -- (Optional)
  vim.env.VISUAL = nvr .. "-l --remote" -- (Optional)
end
----------
