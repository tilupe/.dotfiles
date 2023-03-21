return {
  -- uncomment and add lsp servers with their config to servers below

  {
    "Hoffs/omnisharp-extended-lsp.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "Hoffs/omnisharp-extended-lsp.nvim",
    },
    opts = {
      servers = {
        jsonls = {
          filetype = { "avsc" },
        },
        sumneko_lua = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        omnisharp = {
          handlers = {
            ["textDocument/definition"] = function()
              vim.notify("I was here")
              return require("omnisharp_extended").handler
            end,
          },
        },
        yamlls = {},
        bashls = {},
        pyright = {},
      },
    },
  },
}
