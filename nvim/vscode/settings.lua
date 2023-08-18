local opt = vim.opt
local g = vim.g

vim.o.termguicolors = true

opt.confirm = true
opt.laststatus = 3 -- global statusline
opt.title = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.cul = true -- cursor line
opt.cmdheight = 0

-- Indentline
opt.expandtab = true
opt.smartindent = false

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 8
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.swapfile = false

-- Word Wrap
opt.breakindent = true
opt.wrap = true
opt.autoindent = true
opt.linebreak = true
opt.breakat = " "

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250
opt.inccommand = "nosplit"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
g.mapleader = " "