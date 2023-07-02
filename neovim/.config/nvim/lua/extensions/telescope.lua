--[[
  File: telescope.lua
  Description: Telescope plugin configuration
  See: https://github.com/nvim-telescope/telescope.nvim
]]
local telescope = require("telescope")
telescope.setup()


      nm("<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", { desc = "Switch Buffer"})
      nm("<leader>:", "<cmd>Telescope command_history<cr>", { desc = "Command History"})
      nm(
        "<leader><space>",
        "<cmd>lua require('telescope.builtin').find_files()<cr>",
        { desc = "Find Files" }
      )
      nm("<leader>sr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent"})
      nm("<leader>sb", "<cmd>Telescope buffers<cr>", { desc = "Buffers"})
      nm("<leader>sG", "<cmd>Telescope git_files<cr>", { desc = "Git Files"})
      nm("<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "Grep"})
      nm("<leader>sk", "<cmd>Telescope file_browser path=%:p:h<cr>", { desc = "File Browser current"})
      nm("<leader>sK", "<cmd>Telescope file_browser<cr>", { desc = "File Browser root"})
      nm("<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "commits"})
      -- search
      nm("<leader>sa", "<cmd>Telescope autocommands<cr>", { desc = "Auto Commands"})
      nm("<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer"})
      nm("<leader>fc", "<cmd>Telescope command_history<cr>", { desc = "Command History"})
      nm("<leader>sC", "<cmd>Telescope commands<cr>", { desc = "Commands"})
      nm("<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics"})
      nm("<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages"})
      nm("<leader>sH", "<cmd>Telescope highlights<cr>", { desc = "Search Highlight Groups"})
      nm("<leader>sm", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps"})
      nm("<leader>sM", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages"})
      nm("<leader>sm", "<cmd>Telescope marks<cr>", { desc = "Jump to Mark"})
      nm("<leader>so", "<cmd>Telescope vim_options<cr>", { desc = "Options"})
      nm("<leader>sR", "<cmd>Telescope resume<cr>", { desc = "Resume"})

