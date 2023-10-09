local keymap = vim.keymap.set

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')
keymap('n', 'g,', 'g,zvzz')
keymap('n', 'g;', 'g;zvzz')

-- Better escape using jk in insert and terminal mode
keymap('i', 'jk', '<ESC>')
keymap('t', 'jk', '<C-\\><C-n>')
keymap('t', '<C-h>', '<C-\\><C-n><C-w>h')
keymap('t', '<C-j>', '<C-\\><C-n><C-w>j')
keymap('t', '<C-k>', '<C-\\><C-n><C-w>k')
keymap('t', '<C-l>', '<C-\\><C-n><C-w>l')

-- Better indent
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Paste over currently selected text without yanking it
keymap('v', 'p', '"_dP')

-- Resize window using <shift> arrow keys
keymap('n', '<S-Up>', '<CMD>resize +2<CR>')
keymap('n', '<S-Down>', '<CMD>resize -2<CR>')
keymap('n', '<S-Left>', '<CMD>vertical resize -2<CR>')
keymap('n', '<S-Right>', '<CMD>vertical resize +2<CR>')

keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

keymap('n', '<leader>qq', '<CMD>qa<CR>', { desc = 'Quit all' })
keymap('n', '<leader>ww', '<CMD>update!<CR>', { desc = 'Save' })
keymap('n', '<leader>wa', '<CMD>wa<CR>', { desc = '[W]rite [A]ll' })
keymap('n', '<leader>wd', '<C-W>c', { desc = 'Delete' })

-- Quickfix navigation
keymap('n', '<C-Down>', '<CMD>cbelow<CR>', { desc = 'Quickfix below' })
keymap('n', '<C-Up>', '<CMD>cabove<CR>', { desc = 'Quickfix above' })

-- Tabs
keymap('n', '<leader><tab>d', '<CMD>tabclose<CR>', { desc = 'Close' })

keymap('n', '<F5>', '<CMD>e<CR>', { desc = 'Reload file' })
keymap('n', '<F10>', "<CMD>let $VIM_DIR=expand('%:p:h')<CR><cmd>terminal<CR>cd $VIM_DIR<cr>", { desc = 'Current DIR Terminal' })

local M = {}

M.lsp = function()
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>sh', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
end

M.neogit = {
  { '<leader>gg', '<CMD>Neogit<CR>', silent = true, desc = 'Neogit' },
}

M.blame = {
  { '<leader>gb', '<CMD>ToggleBlame<CR>', silent = true, desc = 'Blame' },
}

M.telescope = {
  { '<leader>sr', '<CMD>Telescope oldfiles<CR>', desc = 'Recent' },
  { '<leader>sb', '<CMD>Telescope buffers<CR>', desc = 'Buffers' },
  { '<leader>sk', '<CMD>Telescope git_files<CR>', desc = 'Git' },
  { '<leader>sg', '<CMD>Telescope live_grep<CR>', desc = 'Grep' },
  { '<leader>ss', '<CMD>Telescope<CR>', desc = 'Telescope' },
}

M.mason = {
  { '<leader>m', '<CMD>Mason<CR>', desc = 'Mason' },
}

M.neorg = {
  { '<leader>nl', '<CMD>Telescope neorg insert_file_link<CR>', desc = 'Insert file link' },
  { '<leader>nw', '<CMD>Neorg workspace<CR>', desc = 'workspace' },
  { '<leader>nn', '<CMD>Neorg keybind<CR>', desc = 'New Note' },
  { '<leader>nr', '<CMD>Neorg return<CR>', desc = 'Close & return' },
  { '<leader>nt', '<CMD>Telescope neorg<CR>', desc = 'Telescope' },
}

M.tmux = {
  { '<C-h>', '<CMD>TmuxNavigateLeft<CR>', desc = 'Window Left' },
  { '<C-j>', '<CMD>TmuxNavigateDown<CR>', desc = 'Window Down' },
  { '<C-k>', '<CMD>TmuxNavigateUp<CR>', desc = 'Window Up' },
  { '<C-l>', '<CMD>TmuxNavigateRight<CR>', desc = 'Window Right' },
}

M.neotest = {
  {
    '<leader>tF',
    "<cmd>lua require('plugins.dap.functions').run(vim.fn.expand('%'))<cr>",
    desc = 'Debug File',
  },
  { '<leader>tL', "<cmd>lua require('neotest').run.run_last({strategy = 'dap'})<cr>", desc = 'Debug Last' },
  { '<leader>ta', "<cmd>lua require('neotest').run.attach()<cr>", desc = 'Attach' },
  { '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = 'File' },
  { '<leader>tl', "<cmd>lua require('neotest').run.run_last()<cr>", desc = 'Last' },
  { '<leader>tn', "<cmd>lua require('neotest').run.run()<cr>", desc = 'Nearest' },
  { '<leader>tN', "<cmd>lua require('plugins.dap.functions').run()<cr>", desc = 'Debug Nearest' },
  { '<leader>to', "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = 'Output' },
  { '<leader>ts', "<cmd>lua require('neotest').run.stop()<cr>", desc = 'Stop' },
  { '<leader>tS', "<cmd>lua require('neotest').summary.toggle()<cr>", desc = 'Summary' },
}

M.vim_test = {
  { '<leader>ttc', '<cmd>TestClass<cr>', desc = 'Class' },
  { '<leader>ttf', '<cmd>TestFile<cr>', desc = 'File' },
  { '<leader>ttl', '<cmd>TestLast<cr>', desc = 'Last' },
  { '<leader>ttn', '<cmd>TestNearest<cr>', desc = 'Nearest' },
  { '<leader>tts', '<cmd>TestSuite<cr>', desc = 'Suite' },
  { '<leader>ttv', '<cmd>TestVisit<cr>', desc = 'Visit' },
}

M.mini_files = {
  { '<leader>ff', '<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', desc = 'Mini Files' },
  { '<leader>fF', '<CMD>lua MiniFiles.open()<CR>', desc = 'Mini Files' },
}

M.dap = {
  {
    '<leader>dR',
    function()
      require('dap').run_to_cursor()
    end,
    desc = 'Run to Cursor',
  },
  {
    '<leader>dE',
    function()
      require('dapui').eval(vim.fn.input '[Expression] > ')
    end,
    desc = 'Evaluate Input',
  },
  {
    '<leader>dC',
    function()
      require('dap').set_breakpoint(vim.fn.input '[Condition] > ')
    end,
    desc = 'Conditional Breakpoint',
  },
  {
    '<leader>dU',
    function()
      require('dapui').toggle()
    end,
    desc = 'Toggle UI',
  },
  {
    '<leader>db',
    function()
      require('dap').step_back()
    end,
    desc = 'Step Back',
  },
  {
    '<leader>dc',
    function()
      require('dap').continue()
    end,
    desc = 'Continue',
  },
  {
    '<leader>dd',
    function()
      require('dap').disconnect()
    end,
    desc = 'Disconnect',
  },
  {
    '<leader>de',
    function()
      require('dapui').eval()
    end,
    mode = { 'n', 'v' },
    desc = 'Evaluate',
  },
  {
    '<leader>dg',
    function()
      require('dap').session()
    end,
    desc = 'Get Session',
  },
  {
    '<leader>dh',
    function()
      require('dap.ui.widgets').hover()
    end,
    desc = 'Hover Variables',
  },
  {
    '<leader>dS',
    function()
      require('dap.ui.widgets').scopes()
    end,
    desc = 'Scopes',
  },
  {
    '<leader>di',
    function()
      require('dap').step_into()
    end,
    desc = 'Step Into',
  },
  {
    '<leader>do',
    function()
      require('dap').step_over()
    end,
    desc = 'Step Over',
  },
  {
    '<leader>dp',
    function()
      require('dap').pause.toggle()
    end,
    desc = 'Pause',
  },
  {
    '<leader>dq',
    function()
      require('dap').close()
    end,
    desc = 'Quit',
  },
  {
    '<leader>dr',
    function()
      require('dap').repl.toggle()
    end,
    desc = 'Toggle REPL',
  },
  {
    '<leader>ds',
    function()
      require('dap').continue()
    end,
    desc = 'Start',
  },
  {
    '<leader>dt',
    function()
      require('dap').toggle_breakpoint()
    end,
    desc = 'Toggle Breakpoint',
  },
  {
    '<leader>dx',
    function()
      require('dap').terminate()
    end,
    desc = 'Terminate',
  },
  {
    '<leader>du',
    function()
      require('dap').step_out()
    end,
    desc = 'Step Out',
  },
}

return M
