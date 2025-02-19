return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    keys = {},
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
          Snacks.toggle.inlay_hints():map '<leader>uh'
          Snacks.toggle.indent():map '<leader>ug'
          Snacks.toggle.dim():map '<leader>uD'
        end,
      })
    end,

    config = function()
      require('snacks').setup {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        image = { enabled = true },
        notifier = {
          enabled = true,
          timeout = 3000,
        },
        picker = {
          enabled = true,
          ui_select = true,
        },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        styles = {
          notification = {
            -- wo = { wrap = true } -- Wrap notifications
          },
        },
      }

      -- Picker

      vim.keymap.set('n', '<leader><space>', function()
        Snacks.picker.smart { layout = { preset = 'ivy', layout = { position = 'bottom' } } }
      end, { desc = 'files' })
      vim.keymap.set('n', '<leader>ff', function()
        Snacks.picker()
      end, { desc = 'fzfLua' })
      vim.keymap.set('n', '<leader>fs', function()
        Snacks.picker.grep()
      end, { desc = 'string live grep' })
      vim.keymap.set('n', '<leader>fr', function()
        Snacks.picker.resume()
      end, { desc = 'resume' })
      vim.keymap.set('n', '<leader>fw', function()
        Snacks.picker.grep_word()
      end, { desc = 'word grep' })
      vim.keymap.set('n', '<leader>fo', function()
        Snacks.picker.recent()
      end, { desc = 'oldfiles' })
      vim.keymap.set('n', '<leader>fi', function()
        Snacks.picker.lsp_implementations()
      end, { desc = 'implementations' })
      vim.keymap.set('n', '<leader>ca', function()
        vim.lsp.buf.code_action()
      end, { desc = 'actions' })
      vim.keymap.set('n', 'gr', function()
        Snacks.picker.lsp_references { layout = { preset = 'ivy', layout = { position = 'bottom' } } }
      end, { desc = 'references' })
      vim.keymap.set('n', 'gd', function()
        Snacks.picker.lsp_definitions { layout = { preset = 'ivy', layout = { position = 'bottom' } } }
      end, { desc = 'definitions' })
      vim.keymap.set('n', '<leader>fz', function()
        Snacks.picker.zoxide { layout = { preset = 'ivy', layout = { position = 'bottom' } } }
      end, { desc = 'zoxide' })
      -- vim.keymap.set('v', '<C-s>', function()
      --   vim.cmd 'FzfLua grep_visual'
      -- end, { desc = 'grep string' })

      vim.keymap.set('n', '<leader>u', '<cmd>Snacks.toggle<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
      vim.keymap.set('n', '<leader>Z', function()
        Snacks.zen.zoom()
      end, { desc = 'Toggle Zoom' })
      vim.keymap.set('n', '<leader>.', function()
        Snacks.scratch()
      end, { desc = 'Toggle Scratch Buffer' })
      vim.keymap.set('n', '<leader>S', function()
        Snacks.scratch.select()
      end, { desc = 'Select Scratch Buffer' })
      vim.keymap.set('n', '<leader>n', function()
        Snacks.notifier.show_history()
      end, { desc = 'Notification History' })
      vim.keymap.set('n', '<leader>bd', function()
        Snacks.bufdelete()
      end, { desc = 'Delete Buffer' })
      vim.keymap.set('n', '<leader>cR', function()
        Snacks.rename.rename_file()
      end, { desc = 'Rename File' })
      vim.keymap.set({ 'n', 'v' }, '<leader>gB', function()
        Snacks.gitbrowse()
      end, { desc = 'Git Browse' })
      vim.keymap.set('n', '<leader>gi', function()
        Snacks.git.blame_line()
      end, { desc = 'Git Blame Line' })
      vim.keymap.set('n', '<leader>un', function()
        Snacks.notifier.hide()
      end, { desc = 'Dismiss All Notifications' })
      vim.keymap.set('n', '<c-/>', function()
        Snacks.terminal()
      end, { desc = 'Toggle Terminal' })
      vim.keymap.set('n', '<c-_>', function()
        Snacks.terminal()
      end, { desc = 'which_key_ignore' })
      vim.keymap.set('n', '<leader>N', function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        }
      end, { desc = 'Neovim News' })
    end,
  },
}
