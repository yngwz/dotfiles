local utils = require("yngwz.utils")
local core_modules = {
    "yngwz.packer",
    "yngwz.set",
    "yngwz.autocmds",
    "yngwz.cmds",
    "yngwz.keymaps",
}

vim.g.catppuccin_flavour = "frappe"
vim.g.utils = utils

for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
        error("Error loading " .. module .. "\n\n" .. err)
    end
end
