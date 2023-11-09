return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    event = 'BufRead',
    config = function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          'c',
          'c_sharp',
          'comment',
          'cpp',
          'css',
          'csv',
          'diff',
          'git_config',
          'git_rebase',
          'gitcommit',
          'gitignore',
          'go',
          'hjson',
          'html',
          'htmldjango',
          'http',
          'java',
          'javascript',
          'json',
          'json5',
          'jsonc',
          'jsonnet',
          'kconfig',
          'kdl',
          'latex',
          'lua',
          'luadoc',
          'luap',
          'luau',
          'norg',
          'python',
          'regex',
          'rust',
          'scss',
          'sql',
          'terraform',
          'toml',
          'tsx',
          'typescript',
          'vim',
          'vimdoc',
          'xml',
          'yaml',
        },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim', event = 'VeryLazy', config = true },
    },
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
    'williamboman/mason-lspconfig.nvim',

    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
    },
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    keys = require('config.keymaps').mason,
    dependencies = {
      'jmederosalvarado/roslyn.nvim',
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
        require('config.keymaps'):lsp()

        -- Taken from https://github.com/neovim/nvim-lspconfig/issues/2657#issuecomment-1783891455
        -- if client.supports_method(require('vim.lsp.protocol').Methods.textDocument_diagnostic) then
        --   vim.api.nvim_create_autocmd('BufEnter', {
        --     buffer = bufnr,
        --     callback = function()
        --       require('vim.lsp.util')._refresh(require('vim.lsp.protocol').Methods.textDocument_diagnostic, { only_visible = true, client_id = client.id })
        --     end,
        --   })
        -- end
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
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = require('config.keymaps').trouble,
  },
  {
    'nvimdev/lspsaga.nvim',
    event = { 'BufEnter' },
    config = function()
      require('lspsaga').setup {}
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
    keys = require('config.keymaps').lspsaga,
  },
}
