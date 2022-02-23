require('plugins')
local utils = require('utils')

-- aliases
local opt = vim.opt  -- global
local g = vim.g      -- global for let options
local wo = vim.wo    -- window local
local bo = vim.bo    -- buffer local
local fn = vim.fn    -- access vim functions
local cmd = vim.cmd  -- vim commands
local api = vim.api

------------------------------------------------------------------------------
-- General Settings
------------------------------------------------------------------------------
opt.hidden = true
opt.termguicolors = true
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.exrc = true
opt.nu = true
opt.relativenumber = true
opt.hlsearch = false
opt.errorbells = false
opt.undodir = "~/.vim/undodir"
opt.scrolloff = 10
opt.incsearch = true
opt.cmdheight = 2
opt.updatetime = 50
opt.signcolumn = "auto"
opt.clipboard = "unnamed"
opt.ignorecase = true
opt.completeopt = 'menuone,noselect'

------------------------------------------------------------------------------
-- Keymaps
------------------------------------------------------------------------------
local map = utils.map

--Remap space as leader key
map('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '
g.maplocalleader = ' '

map("n", "<leader>vr", ":source $MYVIMRC<cr>",{noremap = true})  -- Source init.lua
map("n" , "<leader>ve", ":edit ~/.config/nvim/init.lua<cr> ", { noremap = true })   -- Edit init.lua

-- Substitution and Search
map("n" , "<leader>sg", ":%s/<C-r><C-w>//g<Left><Left>", { noremap = true })

-- Packer shortcuts
map("n" , "<leader>pi", ":PackerInstall<cr>", { noremap = true })
map("n" , "<leader>ps", ":PackerSync<cr>", { noremap = true })

-- Telescope shortcuts
map("n","<leader>f", ":Telescope find_files<cr>",{ noremap = true})
map("n","<leader>fg", ":Telescope live_grep<cr>",{ noremap = true})
map("n","<leader>fb", ":Telescope buffers<cr>",{ noremap = true})
map("n","<leader>fh", ":Telescope help_tags<cr>",{ noremap = true})

------------------------------------------------------------------------------
-- Plugins
------------------------------------------------------------------------------
require "plugins.configs.treesitter"
require "plugins.configs.catppuccin"
require "plugins.configs.cmp"
require "plugins.configs.lsp"
require "plugins.configs.telescope"
require "plugins.configs.autopairs"
require "plugins.configs.comment"

------------------------------------------------------------------------------
-- Theme
------------------------------------------------------------------------------
vim.cmd[[colorscheme catppuccin]]
