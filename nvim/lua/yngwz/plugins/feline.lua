local ctp_present, ctp_feline =
    pcall(require, "catppuccin.groups.integrations.feline")

if not ctp_present then
    print("No catppuccin")
    return
end

local present, feline = pcall(require, "feline")

if not present then
    print("No feline")
    return
end

require("feline").setup({
    components = ctp_feline.get(),
})
