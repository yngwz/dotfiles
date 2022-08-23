local core_modules = {
    "yngwz.packer",
    "yngwz.set",
    "yngwz.utils",
    "yngwz.autocmds",
    "yngwz.cmds",
    "yngwz.keymaps",
}

for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
        error("Error loading " .. module .. "\n\n" .. err)
    end
end
