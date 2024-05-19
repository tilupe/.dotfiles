require('telescope').load_extension('fzf')
vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sx', builtin.oldfiles, { desc = '[R]ecent' })

    vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[R]ecent' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[B]uffers' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[G]rep' })
    vim.keymap.set('n', '<leader>st', '<CMD>Telescope<CR>', { desc = 'Telescope' })
    vim.keymap.set('n', '<leader>gf', '<CMD>Telescope git_files<CR>', { desc = 'search [F]iles' })
    vim.keymap.set('n', '<leader><space>', function()
        builtin.find_files {
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
        previewer = false
      } end, { desc = '[F]iles' })
    vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', '<leader>F', function()
      builtin.find_files { hidden = true }
    end, { desc = 'Find All Files' })
    vim.keymap.set('n', '<leader>gh', builtin.help_tags, { desc = '[H]elp' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]ymbols' })
