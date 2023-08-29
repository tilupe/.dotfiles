return {
  {
    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      -- build = "cd app && yarn install",
      build = ":call mkdp#util#install()",
      keys = {
        { "<leader>um", "<cmd>MarkdownPreviewToggle<cr>", desc = "MarkdownPreview" },
      },
    },
  },
}
