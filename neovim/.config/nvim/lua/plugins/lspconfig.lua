return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            'nvim-dap-ui',
          },
        },
      },
      { 'saghen/blink.cmp' },
    },
    version = '*',
    config = function()
      local lspconfig = require 'lspconfig'
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      lspconfig.lua_ls.setup { capabilities = capabilities }
      lspconfig.nixd.setup { capabilities = capabilities }
      lspconfig.gopls.setup { capabilities = capabilities }
      lspconfig.rust_analyzer.setup { capabilities = capabilities }
      lspconfig.yamlls.setup { capabilities = capabilities }
      lspconfig.sqls.setup { capabilities = capabilities }
      lspconfig.htmx.setup { capabilities = capabilities }

      capabilities.textDocument.completion.completionItem.snippetSupport = true
      require('lspconfig').html.setup {
        capabilities = capabilities,
      }
    end,
  },
  {
    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor' },
    dependencies = {
      {
        -- By loading as a dependencies, we ensure that we are available to set
        -- the handlers for roslyn
        'tris203/rzls.nvim',
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require('rzls').setup {}
        end,
      },
    },
    config = function()
      local rzls_lib_path = vim.fs.joinpath(vim.fn.resolve(vim.fn.exepath 'rzls'), '..', '..', 'lib', 'rzls')
      local design_time_target_path = vim.fs.joinpath(rzls_lib_path, 'Targets', 'Microsoft.NET.Sdk.Razor.DesignTime.targets')
      local razor_compiler_path = vim.fs.joinpath(rzls_lib_path, 'Microsoft.CodeAnalysis.Razor.Compiler.dll')
      require('roslyn').setup {
        --config = {
        -- Here you can pass in any options that that you would like to pass to `vim.lsp.start`.
        -- Use `:h vim.lsp.ClientConfig` to see all possible options.
        -- The only options that are overwritten and won't have any effect by setting here:
        --     - `name`
        --     - `cmd`
        --     - `root_dir`
        --},
        exe = 'Microsoft.CodeAnalysis.LanguageServer',
        args = {
          '--logLevel=Information',
          '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
          '--stdio',
          -- '--razorSourceGenerator=' .. razor_compiler_path,
          -- '--razorDesignTimeTarget=' .. design_time_target_path,
        },
        -- config = {
        --   handlers = require 'rzls.roslyn_handlers',
        -- },
        settings = {
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
          },
          ['csharp|symbol_search'] = {
            dotnet_search_reference_assemblies = true,
          },
          ['csharp|completion'] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'fullSolution',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
          },
        },

        filewatching = true,
        choose_target = nil,
        ignore_target = nil,
        broad_search = false,
        lock_target = false,
      }
    end,
    init = function()
      -- we add the razor filetypes before the plugin loads
      vim.filetype.add {
        extension = {
          razor = 'razor',
          cshtml = 'razor',
        },
      }
    end,
    keys = {
      {
        '<leader>lt',
        function()
          vim.cmd 'Roslyn target'
        end,
      },
    },
  },
}
