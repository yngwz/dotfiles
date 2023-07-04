local utils = require("yngwz.utils")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.termguicolors = true
vim.g.loaded_netrwPlugin = 1

local core_modules = {
    "yngwz.lazy-plugins",
    "yngwz.globals",
    "yngwz.set",
    "yngwz.autocmds",
    "yngwz.cmds",
    "yngwz.keymaps",
    "yngwz.lsp",
    "yngwz.plugins",
}

vim.g.catppuccin_flavour = "frappe"
vim.g.utils = utils

for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
        error("Error loading " .. module .. "\n\n" .. err)
    end
end

-- Componentizer DEV stuff.

require("componentizer").setup()
