vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'g,', 'g,zvzz')
vim.keymap.set('n', 'g;', 'g;zvzz')

-- Better escape using jk in insert and terminal mode
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('t', 'jk', '<C-\\><C-n>')
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')

-- Better indent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Paste over currently selected text without yanking it
vim.keymap.set('v', 'p', '"_dP')

-- Resize window using <shift> arrow keys
vim.keymap.set('n', '<S-Up>', '<CMD>resize +2<CR>')
vim.keymap.set('n', '<S-Down>', '<CMD>resize -2<CR>')
vim.keymap.set('n', '<S-Left>', '<CMD>vertical resize -2<CR>')
vim.keymap.set('n', '<S-Right>', '<CMD>vertical resize +2<CR>')

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<leader>qq', '<CMD>qa<CR>', { desc = 'Quit all' })
vim.keymap.set('n', '<leader>bw', '<CMD>update!<CR>', { desc = 'Save' })
vim.keymap.set('n', '<leader>bW', '<CMD>wa<CR>', { desc = '[W]rite [A]ll' })
vim.keymap.set('n', '<leader>bd', '<C-W>c', { desc = 'Delete' })

-- Quickfix navigation
vim.keymap.set('n', '<C-Down>', '<CMD>cnext<CR>', { desc = 'Quickfix next' })
vim.keymap.set('n', '<C-Up>', '<CMD>cprev<CR>', { desc = 'Quickfix prev' })

-- Tabs
vim.keymap.set('n', '<leader><tab>d', '<CMD>tabclose<CR>', { desc = 'Close' })

vim.keymap.set('n', '<F5>', '<CMD>e<CR>', { desc = 'Reload file' })
vim.keymap.set('n', '<F10>', "<CMD>let $VIM_DIR=expand('%:p:h')<CR><cmd>terminal<CR>cd $VIM_DIR<cr>", { desc = 'Current DIR Terminal' })

-- Diagnostics
vim.keymap.set('n', '<leader>cj', '<CMD>lua vim.diagnostic.goto_next()<CR>', { desc = 'Next Diagnostic' })
vim.keymap.set('n', '<leader>ck', '<CMD>lua vim.diagnostic.goto_prev()<CR>', { desc = 'Previous Diagnostic' })

local M = {}

M.neogit = {
  { '<leader>gg', '<CMD>lua require("utils.custom.git").status()<CR>', silent = true, desc = 'neo[g]it' },
  { '<leader>gc', '<CMD>lua require("utils.custom.git").commit()<CR>', silent = true, desc = '[c]ommit' },
  { '<leader>gp', '<CMD>lua require("utils.custom.git").pull()<CR>', silent = true, desc = '[p]ull' },
  { '<leader>gP', '<CMD>lua require("utils.custom.git").push()<CR>', silent = true, desc = '[P]ush' },
  { '<leader>gl', '<CMD>lua require("utils.custom.git").log()<CR>', silent = true, desc = '[L]og' },
}

M.gitsigns = {
  { '<leader>gs', '<CMD>Gitsigns stage_hunk<CR>', silent = true, desc = '[s]tage hunk' },
  { '<leader>gu', '<CMD>Gitsigns undo_stage_hunk<CR>', silent = true, desc = '[u]ndo-stage hunk' },
  { '<leader>gr', '<CMD>Gitsigns reset_hunk<CR>', silent = true, desc = '[r]eset-hunk' },
  { '<leader>gj', '<CMD>Gitsigns next_hunk<CR>', silent = true, desc = 'next-hunk' },
  { '<leader>gk', '<CMD>Gitsigns prev_hunk<CR>', silent = true, desc = 'prev-hunk' },
  { '<leader>gb', '<CMD>Gitsigns blame_line<CR>', silent = true, desc = 'prev-hunk' },
  { '<leader>gq', '<CMD>Gitsigns setqflist<CR>', silent = true, desc = 'prev-hunk' },
}

M.diffview = {
  { '<leader>gd', '<CMD>DiffviewOpen<CR>', silent = true, desc = '[d]iffview Open' },
  { '<leader>gD', '<CMD>DiffviewOpen<CR>', silent = true, desc = '[D]iffview Close' },
  { '<leader>gh', '<CMD>DiffviewFileHistory %<CR>', silent = true, desc = 'File [H]istory' },
  { '<leader>gH', '<CMD>DiffviewFileHistory<CR>', silent = true, desc = 'All File [H]istory' },
  { '<leader>gR', '<CMD>DiffviewRefresh<CR>', silent = true, desc = 'All File [H]istory' },
}

M.blame = {
  { '<leader>gB', '<CMD>ToggleBlame<CR>', silent = true, desc = 'Blame' },
}

M.telescope = {
  { '<leader>sr', '<CMD>Telescope oldfiles<CR>', desc = '[R]ecent' },
  { '<leader>sb', '<CMD>Telescope buffers<CR>', desc = '[B]uffers' },
  { '<leader>sg', '<CMD>Telescope live_grep<CR>', desc = '[G]rep' },
  { '<leader>st', '<CMD>Telescope<CR>', desc = 'Telescope' },
  { '<leader>gf', '<CMD>Telescope git_files<CR>', desc = 'search [F]iles' },
  { '<leader><space>', '<CMD>FzfLua files<CR>', desc = '[F]iles' },
  { 'gr', '<CMD>FzfLua lsp_references<CR>', '[G]oto [R]eferences' },
  { 'gI', '<CMD>FzfLua lsp_implementations<CR>', '[G]oto [I]mplementation' },
  {

    '<leader>F',
    "<cmd>lua require('telescope.builtin').find_files({ hidden = true})<cr>",
    desc = 'Find All Files',
  },
  { '<leader>gh', '<CMD>Telescope help_tags<CR>', desc = '[H]elp' },
  { '<leader>sw', '<CMD>Telescope grep_string<CR>', desc = 'current [W]ord' },
  { '<leader>sd', '<CMD>Telescope diagnostics<CR>', desc = '[D]iagnostics' },
  { '<leader>sr', '<CMD>Telescope resume<CR>', desc = '[S]earch [R]esume' },
  { '<leader>ss', '<CMD>lua require("telescope.builtin").lsp_document_symbols()<CR>', desc = '[S]ymbols' },
}

M.mason = {
  { '<leader>m', '<CMD>Mason<CR>', desc = 'Mason' },
}

M.conform = {
  { '<leader>cf', '<CMD>lua require("conform").format({ async = true, lsp_fallback = true })<CR>', desc = 'Format' },
  { '<leader>cf', '<CMD>lua require("conform").format({ async = true, lsp_fallback = true })<CR>', desc = 'Format' },
  { '<leader>cF', '<CMD>ConformInfo<CR>', desc = 'FormatInfo' },
}

M.neorg = {}

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
  { '<leader>tN', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = 'Debug Nearest' },
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
  { '<leader>sf', '<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', desc = 'Mini Files' },
  { '<leader>sF', '<CMD>lua MiniFiles.open()<CR>', desc = 'Mini Files' },
}

M.trouble = {
  { '<leader>ct', '<CMD>TroubleToggle<CR>', desc = '[T]rouble Document' },
  { '<leader>cT', '<CMD>TroubleToggle<CR>', desc = '[T]rouble Workspace' },
}

M.fzf = {

  { '<leader>ca', '<CMD>FzfLua lsp_code_actions<CR>', desc = '[A]ctions' },
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
M.colorizer = {
  { '<leader>uc', '<cmd>ColorizerToggle<cr>', desc = 'ColorizerToggle' },
}

M.transparent = {
  { '<leader>ut', '<cmd>TransparentToggle<cr>', desc = 'TransparentToggle' },
}

M.nerdy = {
  { '<leader>in', '<cmd>Nerdy<cr>', desc = 'Nerdy' },
}

M.ccc = {
  { '<leader>ic', '<cmd>CccPick<cr>', desc = 'Colour Picker' },
}

return M
