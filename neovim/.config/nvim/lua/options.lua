local opt = vim.opt

opt.formatoptions = 'jcroqlnt' -- tcqj
opt.shortmess:append { W = true, I = true, c = true }
opt.breakindent = true
opt.clipboard = 'unnamedplus' -- Access system clipboard
opt.cmdheight = 1
opt.completeopt = 'menuone,noselect,longest'
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.tabstop = 2
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = 'split'
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
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 300
opt.title = true
opt.undofile = true
opt.wildmode = 'longest:full,full'
opt.splitkeep = 'screen'
opt.shortmess:append { C = true }

opt.updatetime = 1000

opt.swapfile = false

-- grep
--
if vim.fn.executable('rg') == 1 then
  opt.grepprg = 'rg --vimgrep --hidden --smart-case'
  opt.grepformat = "%f:%l:%c:%m"
end

-- fold
opt.foldcolumn = '1' -- '0' is not bad
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 2

-- view
opt.wrap = true
opt.number = true
opt.relativenumber = true

-- langauge
opt.spelllang = { 'en_us', 'de_ch' }
opt.spell = true

-- Diff
opt.fillchars = 'diff:╱'
opt.diffopt = 'linematch:60,context:5,closeoff,algorithm:histogram'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

opt.list = true
opt.listchars = { tab = '│ ' }
