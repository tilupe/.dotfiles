local opt = vim.opt
-- Set highlight on search
-- Make line numbers default
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- Enable break indent
-- Save undo history
-- Case-insensitive searching UNLESS \C or capital in search
-- Keep signcolumn on by default
-- Decrease update time
opt.updatetime = 200
-- Set completeopt to have a better completion experience
-- NOTE: You should make sure your terminal supports this
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.shortmess:append { W = true, I = true, c = true }
opt.breakindent = true
opt.clipboard = 'unnamedplus' -- Access system clipboard
opt.cmdheight = 0
opt.completeopt = 'menuone,noselect,longest'
opt.conceallevel = 3
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.tabstop = 2
opt.foldcolumn = '1' -- '0' is not bad
opt.foldenable = true
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.hidden = true
opt.hlsearch = false
opt.ignorecase = true
opt.inccommand = 'nosplit'
opt.joinspaces = false
opt.laststatus = 0
opt.list = true
opt.mouse = 'a'
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
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
opt.updatetime = 200
opt.wildmode = 'longest:full,full'
opt.spelllang = { 'en_us', 'de_ch' }
opt.spell = true
opt.diffopt = 'linematch:60,context:5,closeoff,algorithm:histogram'
opt.fillchars = 'diff:╱'
opt.splitkeep = 'screen'
opt.shortmess:append { C = true }
--opt.netrw_keepdir = 0
--opt.netrw_winsize = 30
--opt.netrw_localcopydircmd = 'cp -r'

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
