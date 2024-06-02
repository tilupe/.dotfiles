local trouble = require "trouble"

trouble.setup({
  modes = {
    diagnostics_buffer = {
      mode = "diagnostics", -- inherit from diagnostics mode
      filter = { buf = 0 }, -- filter diagnostics to the current buffer
    },
    mydiags = {
      mode = "diagnostics", -- inherit from diagnostics mode
      filter = {
        any = {
          buf = 0,                                    -- current buffer
          {
            severity = vim.diagnostic.severity.ERROR, -- errors only
            -- limit to files in the current project
            function(item)
              return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
            end,
          },
        },
      },
    },
    cascade = {
      mode = "diagnostics",   -- inherit from diagnostics mode
      filter = function(items)
        local severity = vim.diagnostic.severity.HINT
        for _, item in ipairs(items) do
          severity = math.min(severity, item.severity)
        end
        return vim.tbl_filter(function(item)
          return item.severity == severity
        end, items)
      end,
    }
  }
})

vim.keymap.set('n', '<leader>fd', function() vim.cmd("Trouble diagnostics_buffer toggle") end, { desc = '[f]ind [d]iagnostics ' })
vim.keymap.set('n', '<leader>fe', function() vim.cmd("Trouble mydiags toggle") end, { desc = '[f]ind [e]rrors' })
vim.keymap.set('n', '<leader>fc', function() vim.cmd("Trouble cascade toggle") end , { desc = '[f]ind [c]ascade' })

vim.keymap.set('n', '<leader>xq', '<CMD>Trouble qflist toggle <CR>', { desc = '[T]rouble' })
vim.keymap.set('n', '<leader>xl', '<CMD>Trouble loclist toggle <CR>', { desc = '[T]rouble' })
