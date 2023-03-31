return {
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>ttc", "<cmd>TestClass<cr>", desc = "Class" },
      { "<leader>ttf", "<cmd>TestFile<cr>", desc = "File" },
      { "<leader>ttl", "<cmd>TestLast<cr>", desc = "Last" },
      { "<leader>ttn", "<cmd>TestNearest<cr>", desc = "Nearest" },
      { "<leader>tts", "<cmd>TestSuite<cr>", desc = "Suite" },
      { "<leader>ttv", "<cmd>TestVisit<cr>", desc = "Visit" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "belowright"
      vim.g["test#neovim#preserve_screen"] = 1
      vim.g["test#python#runner"] = "pyunit" -- pytest
      vim.g["test#csharp#runner"] = "dotnet test" -- dotnet test
    end,
  },
  {
    "nvim-neotest/neotest",
    keys = {
      {
        "<leader>tF",
        "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
        desc = "Debug File",
      },
      { "<leader>tL", "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>", desc = "Debug Last" },
      { "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach" },
      { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "File" },
      { "<leader>tl", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "Last" },
      { "<leader>tn", "<cmd>lua require('neotest').run.run()<cr>", desc = "Nearest" },
      { "<leader>tN", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
      { "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
      { "<leader>ts", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop" },
      { "<leader>tS", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Summary" },
    },
    dependencies = {
      --"vim-test/vim-test",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "rouge8/neotest-rust",
      "Issafalcon/neotest-dotnet",
    },
    config = function()
      local opts = {
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "unittest",
          }),
          require("neotest-plenary"),
          -- require("neotest-vim-test")({
          --   ignore_file_types = { "python", "vim", "lua", "cs" },
          -- }),
          require("neotest-rust"),
          require("neotest-dotnet"),
        },
        icons = {
          expanded = "",
          child_prefix = "",
          child_indent = "",
          final_child_prefix = "",
          non_collapsible = "",
          collapsed = "",
          passed = "",
          running = "",
          failed = "",
          unknown = "",
          skipped = "",
        },
        -- overseer.nvim
        consumers = {
          overseer = require("neotest.consumers.overseer"),
        },
        overseer = {
          enabled = true,
          force_default = true,
        },
        loglevel = 1,
      }
      require("neotest").setup(opts)
    end,
  },
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>oR", "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
      { "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Build" },
      { "<leader>oc", "<cmd>OverseerClose<cr>", desc = "Close" },
      { "<leader>od", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete Bundle" },
      { "<leader>ol", "<cmd>OverseerLoadBundle<cr>", desc = "Load Bundle" },
      { "<leader>oo", "<cmd>OverseerOpen<cr>", desc = "Open" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run" },
      { "<leader>os", "<cmd>OverseerSaveBundle<cr>", desc = "Save Bundle" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle" },
    },
    config = true,
  },
  -- {
  --   "andythigpen/nvim-coverage",
  --   cmd = { "Coverage" },
  --   config = true,
  -- },
}
