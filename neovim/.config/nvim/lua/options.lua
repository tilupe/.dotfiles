local opt = vim.opt

-- views can only be fully collapsed with the global statusline
opt.laststatus = 3 -- from avante.nvim
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.shortmess:append { W = true, I = true, c = true }
opt.breakindent = true
opt.clipboard = 'unnamedplus' -- Access system clipboard
opt.cmdheight = 1
opt.completeopt = 'menuone,noselect,longest'
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.tabstop = 2
opt.hidden = true
opt.hlsearch = true
opt.joinspaces = false
opt.mouse = 'a'
opt.pumblend = 10
opt.pumheight = 10
opt.scrollback = 100000
opt.scrolloff = 999
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shiftround = true
opt.shiftwidth = 2
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.ignorecase = true
opt.inccommand = 'split'
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.title = true

vim.opt.undofile = true -- save undo history
local keyset = vim.keymap.set
keyset('i', ',', ',<C-g>U')
keyset('i', '.', '.<C-g>U')
keyset('i', '!', '!<C-g>U')
keyset('i', '?', '?<C-g>U')

opt.wildmode = 'list:longest,list:full' -- for : stuff
opt.wildignore:append { '.javac', 'node_modules', '*.pyc' }
opt.wildignore:append { '.aux', '.out', '.toc' } -- LaTeX
opt.wildignore:append {
  '.o',
  '.obj',
  '.dll',
  '.exe',
  '.so',
  '.a',
  '.lib',
  '.pyc',
  '.pyo',
  '.pyd',
  '.swp',
  '.swo',
  '.class',
  '.DS_Store',
  '.git',
  '.hg',
  '.orig',
}
opt.splitkeep = 'screen'
opt.shortmess:append { C = true }

opt.updatetime = 1000

opt.swapfile = false

-- grep
--
if vim.fn.executable 'rg' == 1 then
  opt.grepprg = 'rg --vimgrep --hidden --smart-case'
  opt.grepformat = '%f:%l:%c:%m'
end

-- fold
opt.foldcolumn = '1' -- '0' is not bad
opt.foldenable = true

-- view
opt.wrap = true
opt.number = true
opt.relativenumber = true

-- langauge
opt.spelllang = { 'en_us', 'de_ch' }
opt.spell = true
opt.spelloptions = 'camel'

-- Diff
opt.fillchars = 'diff:╱'
opt.diffopt = 'filler,internal,closeoff,algorithm:histogram,context:5,linematch:60,indent-heuristic' --'

vim.g.mapleader = ' '
vim.g.maplocalleader = 'ö'
vim.g.have_nerd_font = true

opt.list = true
opt.listchars = { tab = '│ ' }
