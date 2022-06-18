local present, feline = pcall(require, "feline")

if not present then
    return
end

local settings = {
    components = require("catppuccin.core.integrations.feline"),
}

feline.setup(settings)
