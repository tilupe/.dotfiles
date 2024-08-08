return {
  {
    'folke/trouble.nvim',
    opts = {
      modes = {
        diagnostics_buffer = {
          mode = 'diagnostics', -- inherit from diagnostics mode
          filter = { buf = 0 }, -- filter diagnostics to the current buffer
        },
      },
    },
    keys = {

      {
        '<leader>dd',
        function()
          vim.cmd 'Trouble diagnostics_buffer toggle'
        end,
        { desc = '[d]iagnistic [d]iagnostics ' },
      },
      { '<leader>xq', '<CMD>Trouble qflist toggle <CR>', { desc = '[T]rouble' } },
      { '<leader>xl', '<CMD>Trouble loclist toggle <CR>', { desc = '[T]rouble' } },
    },
  },
}
