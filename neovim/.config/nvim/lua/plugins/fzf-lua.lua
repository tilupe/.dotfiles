return {
  {
    'ibhagwan/fzf-lua',
    config = function()
      require 'config.fzf-lua'
    end,
    keys = {
      {
        '<leader><space>',
        function()
          vim.cmd 'FzfLua files'
        end,
        desc = 'files',
      },
      {
        '<leader>ff',
        function()
          vim.cmd 'FzfLua'
        end,
        desc = '[f]zfLua',
      },
      {
        '<leader>fs',
        function()
          vim.cmd 'FzfLua live_grep_native'
        end,
        desc = '[s]tring',
      },
      {
        '<leader>fr',
        function()
          vim.cmd 'FzfLua resume'
        end,
        desc = '[r]esume',
      },
      {
        '<leader>fw',
        function()
          vim.cmd 'FzfLua grep_cWORD'
        end,
        desc = '[w]ord',
      },
      {
        '<leader>fi',
        function()
          require('fzf-lua').lsp_implementations {
            jump_to_single_result = true,
          }
        end,
        desc = '[i]mplementations',
      },
      {
        '<leader>ca',
        function()
          require('fzf-lua').lsp_code_actions { winopts = { height = 0.25, width = 0.8 } }
        end,
        desc = '[c]ode [a]ctions',
      },
      {
        'gr',
        function()
          require('fzf-lua').lsp_references {
            sync = true,
            ignore_current_line = true,
            includeDeclaration = false,
            jump_to_single_result = true,
          }
        end,
        desc = '[r]eferences',
      },
      {
        'gd',
        function()
          require('fzf-lua').lsp_definitions {
            sync = true,
            ignore_current_line = true,
            includeDeclaration = false,
            jump_to_single_result = true,
          }
        end,
        desc = '[d]efinitions',
      },
    },
  },
}
