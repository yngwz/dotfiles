local utils = require("utils")
require("plugins")

-- aliases
local opt = vim.opt -- global
local g = vim.g -- global for let options
-- local wo = vim.wo    -- window local
-- local bo = vim.bo    -- buffer local
-- local fn = vim.fn    -- access vim functions
-- local cmd = vim.cmd  -- vim commands
-- local api = vim.api

------------------------------------------------------------------------------
-- General Settings something
------------------------------------------------------------------------------
opt.hidden = true
opt.termguicolors = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.smartcase = true
opt.exrc = true
opt.nu = true
opt.pumheight = 10
opt.relativenumber = true
opt.hlsearch = false
opt.errorbells = false
opt.undodir = vim.fn.stdpath("config") .. "/.undo"
opt.undofile = true
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.incsearch = true
opt.cmdheight = 1
opt.updatetime = 50
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.ignorecase = true
opt.completeopt = "menuone,noselect"
opt.timeoutlen = 500
opt.updatetime = 100
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false

------------------------------------------------------------------------------
-- Keymaps
------------------------------------------------------------------------------
local map = utils.map

--Remap space as leader key
map("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

map("n", "<leader>vr", ":source $MYVIMRC<cr>", { noremap = true }) -- Source init.lua
map("n", "<leader>ve", ":edit ~/.config/nvim/init.lua<cr> ", { noremap = true }) -- Edit init.lua

-- Window navigation
map("n", "<C-h>", "<C-w>h", { noremap = true })
map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })

map("i", "jk", "<ESC>", { noremap = true })

-- Buffer navigation
map("n", "<S-l>", ":bnext<cr>", { noremap = true })
map("n", "<S-h>", ":bprevious<cr>", { noremap = true })

-- Substitution and Search
map("n", "<leader>sg", ":%s/<C-r><C-w>//g<Left><Left>", { noremap = true })

-- Packer shortcuts
map("n", "<leader>pi", ":PackerInstall<cr>", { noremap = true })
map("n", "<leader>ps", ":PackerSync<cr>", { noremap = true })

-- Telescope shortcuts
map("n", "<leader>f", ":Telescope find_files<cr>", { noremap = true })
map("n", "<leader>fg", ":Telescope live_grep<cr>", { noremap = true })
map("n", "<leader>fb", ":Telescope buffers<cr>", { noremap = true })
map("n", "<leader>fh", ":Telescope help_tags<cr>", { noremap = true })

------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------
require("plugins.configs.impatient")
require("plugins.configs.catppuccin")
require("plugins.configs.cmp")
require("plugins.configs.lsp")
require("plugins.configs.telescope")
require("plugins.configs.treesitter")
require("plugins.configs.autopairs")
require("plugins.configs.comment")
require("plugins.configs.indentline")
require("plugins.configs.gitsigns")
require("plugins.configs.bufferline")
require("plugins.configs.toggleterm")
require("plugins.configs.feline")
require("plugins.configs.whichkey")
require("plugins.configs.colorizer")
require("plugins.configs.neotree")

------------------------------------------------------------------------------
-- Theme
------------------------------------------------------------------------------
vim.cmd([[colorscheme catppuccin]])
