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
          vim.cmd 'FzfLua lsp_implementations'
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
          vim.cmd 'FzfLua lsp_references'
        end,
        desc = '[r]eferences',
      },
      {
        'gd',
        function()
          vim.cmd 'FzfLua lsp_definitions'
        end,
        desc = '[d]efinitions',
      },
      {
        '<C-f>',
        function()
          vim.cmd 'FzfLua grep_visual'
        end,
        mode = 'v',
        desc = 'Resume',
      },
    },
  },
}
