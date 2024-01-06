return -- Fuzzy Finder (files, lsp, etc)
{
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        layout_strategy = 'horizontal',
        file_ignore_patterns = { '^.git/' },
        preview = {
          filesize_limit = 0.1, -- MB
          mime_hook = function(filepath, bufnr, opts)
            local is_image = function(filepath)
              local image_extensions = { 'png', 'jpg' } -- Supported image formats
              local split_path = vim.split(filepath:lower(), '.', { plain = true })
              local extension = split_path[#split_path]
              return vim.tbl_contains(image_extensions, extension)
            end
            if is_image(filepath) then
              local term = vim.api.nvim_open_term(bufnr, {})
              local function send_output(_, data, _)
                for _, d in ipairs(data) do
                  vim.api.nvim_chan_send(term, d .. '\r\n')
                end
              end
              vim.fn.jobstart({
                'catimg',
                filepath, -- Terminal image viewer command
              }, { on_stdout = send_output, stdout_buffered = true, pty = true })
            else
              require('telescope.previewers.utils').set_preview_message(bufnr, opts.winid, 'Binary cannot be previewed')
            end
          end,
        },
        mappings = {
          i = {
            ['<C-n>'] = function(...)
              return require('telescope.actions').cycle_history_next(...)
            end,
            ['<C-p>'] = function(...)
              return require('telescope.actions').cycle_history_prev(...)
            end,
            ['<C-J>'] = function(...)
              return require('telescope.actions').preview_scrolling_down(...)
            end,
            ['<C-K>'] = function(...)
              return require('telescope.actions').preview_scrolling_up(...)
            end,
            ['<C-j>'] = function(...)
              return require('telescope.actions').move_selection_next(...)
            end,
            ['<C-k>'] = function(...)
              return require('telescope.actions').move_selection_previous(...)
            end,
          },
          n = {
            ['q'] = function(...)
              return require('telescope.actions').close(...)
            end,
          },
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--trim', -- add this value
        },
      },
      pickers = {
        find_files = {
          find_command = { 'fdfind', '--type', 'f', '--strip-cwd-prefix' },
          mappings = {
            n = {
              ['cd'] = function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                local dir = vim.fn.fnamemodify(selection.path, ':p:h')
                require('telescope.actions').close(prompt_bufnr)
                -- Depending on what you want put `cd`, `lcd`, `tcd`
                vim.cmd(string.format('silent cd %s', dir))
              end,
            },
          },
        },
      },
      extensions = {},
    }

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sx', builtin.oldfiles, { desc = '[R]ecent' })

    vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[R]ecent' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[B]uffers' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[G]rep' })
    vim.keymap.set('n', '<leader>st', '<CMD>Telescope<CR>', { desc = 'Telescope' })
    vim.keymap.set('n', '<leader>gf', '<CMD>Telescope git_files<CR>', { desc = 'search [F]iles' })
    vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = '[F]iles' })
    vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gI', builtin.lsp_implementations, { desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', '<leader>F', function()
      builtin.find_files { hidden = true }
    end, { desc = 'Find All Files' })
    vim.keymap.set('n', '<leader>gh', builtin.help_tags, { desc = '[H]elp' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]ymbols' })
  end,
}
