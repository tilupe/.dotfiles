return {

  { 'echasnovski/mini.icons', version = false, config = true },
  { 'echasnovski/mini.extra', version = false, config = true },
  {
    'echasnovski/mini.statusline',
    version = '*',
    config = function()
      require('mini.statusline').setup()
    end,
  },
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    config = function()
      require('mini.ai').setup()
    end,
  },
  { 'echasnovski/mini.bracketed', version = '*', config = true },
  { 'echasnovski/mini.surround', version = '*', config = true },
  {
    'echasnovski/mini.pick',
    version = '*',
    config = function()
      require('mini.pick').setup()
      -- vim.keymap.set('n', '<leader><space>', function() MiniPick.builtin.files() end, { desc = 'files' })
      -- vim.keymap.set('n', '<leader>fs', function() MiniPick.builtin.grep_live() end, { desc = 'string grep' })
      -- vim.keymap.set('n', '<leader>fr', function() MiniPick.builtin.resume() end, { desc = 'resue' })
      -- vim.keymap.set('n', '<leader>fw', function() MiniPick.builtin.grep() end, { desc = 'word grep' })
      -- vim.keymap.set('n', '<leader>fh', function() MiniPick.builtin.help() end, { desc = 'help' })
    end,
  },
  {
    'echasnovski/mini.clue',
    version = '*',
    config = function()
      local miniclue = require 'mini.clue'
      miniclue.setup { -- cute prompts about bindings

        triggers = {
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },
          { mode = 'n', keys = '<space>' },
          { mode = 'x', keys = '<space>' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = 'n', keys = 'z' },
          { mode = 'x', keys = 'z' },

          -- Bracketed
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },
        },
        clues = {
          { mode = 'n', keys = '<Leader>t', desc = '+Test' },
          { mode = 'n', keys = '<Leader>g', desc = '+Git' },
          { mode = 'n', keys = '<Leader>f', desc = '+Find' },
          { mode = 'n', keys = '<Leader>x', desc = '+eXecute' },
          { mode = 'n', keys = '<Leader>r', desc = '+Refactor' },
          { mode = 'n', keys = '<Leader>o', desc = '+Obsidian' },
          { mode = 'n', keys = '<Leader>l', desc = '+Lsp' },
          { mode = 'n', keys = '<Leader>c', desc = '+Code' },
          { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
          { mode = 'n', keys = '<Leader>u', desc = 'UndoTreeToggle' },
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      }
    end,
  },
}
