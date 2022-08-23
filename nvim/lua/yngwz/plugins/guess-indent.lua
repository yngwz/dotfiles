local present, guess_indent = pcall(require, "guess-indent")

if not present then
    return
end

local settings = {
    auto_cmd = true, -- Set to false to disable automatic execution
    filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
        "help",
        "terminal",
        "alpha",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "lsp-installer",
    },
    buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
        "help",
        "nofile",
        "terminal",
        "prompt",
    },
}

guess_indent.setup(settings)
