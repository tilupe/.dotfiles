local mason = require 'mason'
mason.setup()
local servers = {
  rust_analyzer = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
  yamlls = {},
  jdtls = {},
  kotlin_language_server = {},
}

local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities = vim.tbl_deep_extend('force', capabilities, {
  filetypes = { 'cs', 'razor' },
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = false,
    },
  },
})

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}
