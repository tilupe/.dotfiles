return {

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'jmederosalvarado/roslyn.nvim',
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim', event = 'VeryLazy', config = true },
    },
    config = function()
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
        -- omnisharp = {},
      }
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
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

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      local on_attach = function(_, bufnr)
        local function sign_define(args)
          vim.fn.sign_define(args.name, {
            texthl = args.name,
            text = args.text,
            numhl = '',
          })
        end

        local icon = require('utils.icons').diagnostics
        sign_define { name = 'DiagnosticSignError', text = icon.BoldError }
        sign_define { name = 'DiagnosticSignWarn', text = icon.BoldWarning }
        sign_define { name = 'DiagnosticSignHint', text = icon.BoldHint }
        sign_define { name = 'DiagnosticSignInfo', text = icon.BoldInformation }
      end

      require('roslyn').setup {
        dotnet_cmd = 'dotnet', -- this is the default
        roslyn_version = '4.8.0-3.23475.7', -- this is the default
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
    end,
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {},
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'isort', 'black' },
          javascript = { { 'prettierd', 'prettier' } },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      }
    end,
    keys = require('config.keymaps').conform,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    keys = require('config.keymaps').mason,
    dependencies = {},
  },
  {
    'folke/trouble.nvim',
    event = { 'LspAttach' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = require('config.keymaps').trouble,
  },
  {
    'aznhe21/actions-preview.nvim',
    cmd = 'ActionsPreview',
  },
}
