local M = {}

M.autopairs = function()
    local present1, autopairs = pcall(require, "nvim-autopairs")
    local present2, cmp = pcall(require, "cmp")

    if not present1 and present2 then
        print("Auto pairs is not running")
        return
    end

    autopairs.setup({
        fast_wrap = {},
        disable_filetype = { "TelescopePrompt", "vim" },
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.autotag = function()
    local present, autotag = pcall(require, "nvim-ts-autotag")
    if not present then
        return
    end

    local filetypes = {
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "svelte",
        "vue",
        "tsx",
        "jsx",
        "rescript",
        "xml",
        "php",
        "markdown",
        "glimmer",
        "handlebars",
        "hbs",
    }
    local skip_tags = {
        "area",
        "base",
        "br",
        "col",
        "command",
        "embed",
        "hr",
        "img",
        "slot",
        "input",
        "keygen",
        "link",
        "meta",
        "param",
        "source",
        "track",
        "wbr",
        "menuitem",
    }

    autotag.setup({
        enable = "true",
        filetypes = filetypes,
        skip_tags = skip_tags,
    })
end

return M
