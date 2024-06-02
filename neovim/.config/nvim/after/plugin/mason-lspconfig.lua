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

    vim.keymap.set( 'n',
    '<leader>rn',
    vim.lsp.buf.rename,
    vim.tbl_extend('force', opts, { desc = '[N]ame' }))

    vim.keymap.set('n',
    'gd',
    vim.lsp.buf.definition,
    vim.tbl_extend('force', opts, { desc = '[G]oto [D]efinition' }))

    vim.keymap.set('n',
    '<leader>D',
    vim.lsp.buf.type_definition,
    vim.tbl_extend('force', opts, { desc = 'Type [D]efinition' }))
    vim.keymap.set(
      'n',
      '<leader>ws',
      require('telescope.builtin').lsp_dynamic_workspace_symbols,
      vim.tbl_extend('force', opts, { desc = '[W]orkspace [S]ymbols' }))

    vim.keymap.set('n',
    'K',
    vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Hover Documentation' }))
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = '[G]oto [Implementation]' }))
    vim.keymap.set( 'n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ction' })
    vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Documentation' }))
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = '[g]oto [D]eclaration' }))
    vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, vim.tbl_extend('force', opts, { desc = '[c]ode [f]ormat' }))
    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = '[G]oto [D]eclaration' }))

  local function sign_define(args)
    vim.fn.sign_define(args.name, {
      texthl = args.name,
      text = args.text,
      numhl = '',
    })
  end
  local icon = require('icons').diagnostics
  sign_define { name = 'DiagnosticSignError', text = icon.BoldError }
  sign_define { name = 'DiagnosticSignWarn', text = icon.BoldWarning }
  sign_define { name = 'DiagnosticSignHint', text = icon.BoldHint }
  sign_define { name = 'DiagnosticSignInfo', text = icon.BoldInformation }
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

require('roslyn').setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
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
