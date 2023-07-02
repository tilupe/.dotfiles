local toggleterm = require"toggleterm"

toggleterm.setup({
  size = 20,
      hide_numbers = true,
      open_mapping = [[<C-\>]],
      shade_filetypes = {},
      shade_terminals = false,
      shading_factor = 0.3,
      start_in_insert = true,
      persist_size = true,
      direction = "float",
      winbar = {
        enabled = false,
        name_formatter = function(term)
          return term.name
        end,
      }
})

local M = {}
local Terminal = require("toggleterm.terminal").Terminal

local lg_cmd = "lazygit -w $PWD"
local lazygit = Terminal:new({
  cmd = lg_cmd,
  count = 5,
  direction = "float",
  float_opts = {
    border = "double",
    width = function()
      return vim.o.columns
    end,
    height = function()
      return vim.o.lines
    end,
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

function M.Lazygit_toggle()
  lazygit:toggle()
end

return M
